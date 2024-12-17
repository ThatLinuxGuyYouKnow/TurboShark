import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as p; // Import path package
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/ssl/ssl_handler.dart';

class ConcurrentFileDownloader {
  final String url;
  final int segmentCount;
  final String savePath;
  final Function(String, double)? onProgress;
  final Function(String, Downloadstate)? onStateChange;

  ConcurrentFileDownloader({
    required this.url,
    this.segmentCount = 4,
    required this.savePath,
    this.onProgress,
    this.onStateChange,
  });

  Future<void> download() async {
    print('Starting download for URL: $url');
    onStateChange?.call(url, Downloadstate.inProgress);

    try {
      final contentLength = await getContentLength(url);
      if (contentLength == null) {
        print('Failed to determine file size for URL: $url');
        throw Exception('Could not determine file size');
      }

      print('Total file size: $contentLength bytes');
      final segmentSize = contentLength ~/ segmentCount;
      print('Segment size: $segmentSize bytes');

      final downloadTasks = <Future>[];
      for (int i = 0; i < segmentCount; i++) {
        final start = i * segmentSize;
        final end = (i == segmentCount - 1)
            ? contentLength - 1
            : start + segmentSize - 1;

        print('Preparing segment $i: start=$start, end=$end');
        downloadTasks.add(_downloadSegment(start, end, i, contentLength));
      }

      try {
        await Future.wait(downloadTasks);
        print('All segments downloaded successfully');
      } catch (e) {
        print('Error downloading segments: $e');
        rethrow;
      }

      // After all segments are downloaded, merge the temp files
      try {
        await _mergeSegments();
        print('Segments merged successfully');
      } catch (e) {
        print('Error merging segments: $e');
        rethrow;
      }

      onStateChange?.call(url, Downloadstate.done);
      print('Download completed successfully for URL: $url');
    } catch (e) {
      print('Download failed for URL: $url. Error: $e');
      onStateChange?.call(url, Downloadstate.failed);
      rethrow;
    }
  }

  Future<int?> getContentLength(url) async {
    try {
      print('Attempting to get content length for URL: $url');
      final request = await HttpClient().getUrl(Uri.parse(url));
      request.followRedirects = true;
      final response = await request.close();
      final contentLength = response.headers.contentLength;
      print('Content length retrieved: $contentLength bytes');
      return contentLength;
    } catch (e) {
      print('Error getting content length: $e');
      return null;
    }
  }

  Future<void> _downloadSegment(
    int start,
    int end,
    int segmentIndex,
    int totalSize,
  ) async {
    print('Starting download for segment $segmentIndex');
    int bytesDownloaded = 0;
    final receivePort = ReceivePort();
    final tempPath = _getTempFilePath(segmentIndex); // Unique temp path
    print('Temporary file path for segment $segmentIndex: $tempPath');

    try {
      await Isolate.spawn(_downloadSegmentIsolate, {
        'url': url,
        'start': start,
        'end': end,
        'sendPort': receivePort.sendPort,
        'savePath': tempPath, // Pass temp path to isolate
      });

      await for (final message in receivePort) {
        if (message is Map<String, dynamic> && message['bytes'] != null) {
          bytesDownloaded += message['bytes'] as int;
          final progress = bytesDownloaded / totalSize;
          onProgress?.call(url, progress);
          print(
              'Segment $segmentIndex progress: ${(progress * 100).toStringAsFixed(2)}%');
        } else if (message is Map<String, dynamic> && message['done'] == true) {
          print('Segment $segmentIndex download completed');
          break;
        } else if (message is Map<String, dynamic> &&
            message['error'] != null) {
          print('Error in segment $segmentIndex: ${message['error']}');
          throw Exception(message['error']);
        }
      }
    } catch (e) {
      print('Error downloading segment $segmentIndex: $e');
      rethrow;
    }
  }

  String _getTempFilePath(int segmentIndex) {
    try {
      final dir = Directory.systemTemp.createTempSync('turbo_shark_temp_');
      final path = p.join(dir.path, 'segment_$segmentIndex.tmp');
      print('Created temporary directory for segment $segmentIndex: $path');
      return path;
    } catch (e) {
      print('Error creating temporary file path: $e');
      rethrow;
    }
  }

  Future<void> _mergeSegments() async {
    print('Starting to merge segments');
    final file = await File(savePath).open(mode: FileMode.write);
    try {
      for (int i = 0; i < segmentCount; i++) {
        final tempFilePath = _getTempFilePath(i);
        final tempFile = File(tempFilePath);

        if (await tempFile.exists()) {
          print('Merging segment $i from $tempFilePath');
          final contents = await tempFile.readAsBytes();
          await file.writeFrom(contents);
          // Clean up the temporary file
          await tempFile.delete();
          print('Segment $i merged and temporary file deleted');
        } else {
          print('Temporary file for segment $i does not exist');
        }
      }
      print('All segments merged successfully');
    } catch (e) {
      print('Error merging segments: $e');
      rethrow;
    } finally {
      await file.close();
    }
  }

  static Future<void> _downloadSegmentIsolate(
      Map<String, dynamic> params) async {
    try {
      HttpOverrides.global = MyHttpOverrides();

      final sendPort = params['sendPort'] as SendPort;
      final url = params['url'] as String;
      final start = params['start'] as int;
      final end = params['end'] as int;
      final savePath = params['savePath'] as String;

      print('Isolate started for segment: $savePath');

      try {
        final request = await HttpClient().getUrl(Uri.parse(url));
        request.headers.set('range', 'bytes=$start-$end');

        final response = await request.close();
        final file = await File(savePath).open(mode: FileMode.write);

        await for (final data in response) {
          await file.writeFrom(data); // Write to the temp file
          sendPort.send({'bytes': data.length});
        }
        await file.close();
        sendPort.send({'done': true});
        print('Isolate segment download completed: $savePath');
      } catch (e) {
        print('Error in isolate download: $e');
        sendPort.send({'error': e.toString()});
      }
    } catch (e) {
      print('Unhandled error in isolate: $e');
    }
  }
}
