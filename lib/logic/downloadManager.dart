import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:turbo_shark/ssl/ssl_handler.dart';

class ConcurrentFileDownloader {
  final String url;
  final int segmentCount;
  final String savePath;

  ConcurrentFileDownloader({
    required this.url,
    this.segmentCount = 4,
    required this.savePath,
  });

  Future<void> download() async {
    // Get file size first
    print('starting downlad');
    final contentLength = await _getContentLength();

    if (contentLength == null) {
      throw Exception('Could not determine file size');
    }

    // Calculate segment sizes
    final segmentSize = contentLength ~/ segmentCount;
    final file = await File(savePath).create(recursive: true);

    // Prepare download segments
    final downloadTasks = <Future>[];
    for (int i = 0; i < segmentCount; i++) {
      final start = i * segmentSize;
      final end =
          (i == segmentCount - 1) ? contentLength - 1 : start + segmentSize - 1;

      downloadTasks.add(_downloadSegment(start, end, i));
    }

    // Wait for all segments to complete
    await Future.wait(downloadTasks);
  }

  Future<int?> _getContentLength() async {
    try {
      final request = await HttpClient().getUrl(Uri.parse(url));
      request.followRedirects = true;
      final response = await request.close();
      return response.headers.contentLength;
    } catch (e) {
      print('Error getting content length: $e');
      return null;
    }
  }

  Future<void> _downloadSegment(int start, int end, int segmentIndex) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_downloadSegmentIsolate, {
      'url': url,
      'start': start,
      'end': end,
      'sendPort': receivePort.sendPort,
      'savePath': savePath,
      'segmentIndex': segmentIndex,
    });

    final result = await receivePort.first as Map<String, dynamic>;

    if (result['error'] != null) {
      throw Exception('Download segment error: ${result['error']}');
    }
  }

  static Future<void> _downloadSegmentIsolate(
      Map<String, dynamic> params) async {
    // Set the custom HttpOverrides in the isolate
    HttpOverrides.global = MyHttpOverrides();

    final sendPort = params['sendPort'] as SendPort;
    final url = params['url'] as String;
    final start = params['start'] as int;
    final end = params['end'] as int;
    final savePath = params['savePath'] as String;

    try {
      final request = await HttpClient().getUrl(Uri.parse(url));
      request.headers.set('range', 'bytes=$start-$end');

      final response = await request.close();
      final file = await File(savePath).open(mode: FileMode.writeOnlyAppend);

      // Write the received data manually
      int currentPosition = start;
      await for (final data in response) {
        await file.setPosition(currentPosition);
        await file.writeFrom(data);
        currentPosition += data.length;
      }

      await file.close();
      sendPort.send({'success': true});
    } catch (e) {
      sendPort.send({'error': e.toString()});
    }
  }
}

// Example usage
void main() async {
  final downloader = ConcurrentFileDownloader(
    url: 'https://example.com/largefile.zip',
    savePath: '/path/to/save/largefile.zip',
    segmentCount: 4, // Number of concurrent segments
  );

  try {
    await downloader.download();
    print('Download completed successfully');
  } catch (e) {
    print('Download failed: $e');
  }
}
