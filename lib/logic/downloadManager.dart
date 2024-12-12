import 'dart:io';
import 'dart:isolate';

import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/ssl/ssl_handler.dart';

class ConcurrentFileDownloader {
  final String url;
  final int segmentCount;
  final String savePath;
  final Function(String, double)? onProgress; // Callback for progress
  final Function(String, Downloadstate)? onStateChange; // Callback for state

  ConcurrentFileDownloader({
    required this.url,
    this.segmentCount = 4,
    required this.savePath,
    this.onProgress,
    this.onStateChange,
  });

  Future<void> download() async {
    onStateChange?.call(url, Downloadstate.inProgress);

    try {
      final contentLength = await getContentLength(url);
      if (contentLength == null) {
        throw Exception('Could not determine file size');
      }

      final segmentSize = contentLength ~/ segmentCount;

      final downloadTasks = <Future>[];
      for (int i = 0; i < segmentCount; i++) {
        final start = i * segmentSize;
        final end = (i == segmentCount - 1)
            ? contentLength - 1
            : start + segmentSize - 1;

        downloadTasks.add(_downloadSegment(start, end, i, contentLength));
      }

      await Future.wait(downloadTasks);
      onStateChange?.call(url, Downloadstate.done);
    } catch (e) {
      onStateChange?.call(url, Downloadstate.failed);
      rethrow;
    }
  }

  Future<int?> getContentLength(url) async {
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

  Future<void> _downloadSegment(
    int start,
    int end,
    int segmentIndex,
    int totalSize,
  ) async {
    int bytesDownloaded = 0;
    final receivePort = ReceivePort();

    await Isolate.spawn(_downloadSegmentIsolate, {
      'url': url,
      'start': start,
      'end': end,
      'sendPort': receivePort.sendPort,
      'savePath': savePath,
    });

    await for (final message in receivePort) {
      if (message is Map<String, dynamic> && message['bytes'] != null) {
        bytesDownloaded += message['bytes'] as int;
        final progress = bytesDownloaded / totalSize;
        onProgress?.call(url, progress); // Notify progress
      } else if (message is Map<String, dynamic> && message['done'] == true) {
        break;
      }
    }
  }

  static Future<void> _downloadSegmentIsolate(
      Map<String, dynamic> params) async {
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

      int currentPosition = start;
      await for (final data in response) {
        await file.setPosition(currentPosition);
        await file.writeFrom(data);
        currentPosition += data.length;

        // Send progress updates back to the main isolate
        sendPort.send({'bytes': data.length});
      }

      await file.close();
      sendPort.send({'done': true});
    } catch (e) {
      sendPort.send({'error': e.toString()});
    }
  }
}
