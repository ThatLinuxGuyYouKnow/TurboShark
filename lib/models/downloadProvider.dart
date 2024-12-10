import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/dataHandling/localPersistence.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/logic/downloadManager.dart';
import 'package:turbo_shark/models/download.dart';
import 'package:turbo_shark/models/download_history.dart';

class DownloadProvider extends ChangeNotifier {
  final List<Download> _downloads = [];
  final DownloadRepository _localData = DownloadRepository();

  List<Download> get downloads => _downloads;

  DownloadProvider() {
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    final downloadHistories = await _localData.getAllDownloads();

    // Convert DownloadHistory to Download
    _downloads.clear();
    for (var history in downloadHistories) {
      final download = Download(
          date: history.time,
          name: history.fileName,
          state: _convertStateStringToEnum(history.state),
          progress: history.progress,
          size: history.size);
      _downloads.add(download);
    }
    notifyListeners();
  }

  void addDownload(
    String downloadName,
    int size,
  ) {
    final download =
        Download(name: downloadName, size: size, date: DateTime.now());
    _downloads.add(download);

    // Also save to local persistence
    final downloadHistory = DownloadHistory(
        id: download.id,
        fileName: downloadName,
        filePath: '', // You might want to pass this when starting download
        progress: 0.0,
        state: download.state.toString().split('.').last,
        size: size,
        time: DateTime.now());
    _localData.addDownload(downloadHistory);

    notifyListeners();
  }

  Future<void> startDownload({
    required BuildContext context,
    required String url,
    required String savePath,
  }) async {
    final provider = Provider.of<DownloadProvider>(context, listen: false);
    print('starting download');

    // Get content length (file size) before proceeding
    final size = await ConcurrentFileDownloader(url: url, savePath: savePath)
        .getContentLength(url);

    if (size == null) {
      print('Failed to determine file size.');
      provider.updateState(url, Downloadstate.failed, size, DateTime.now());
      return; // Exit the function if size is unavailable
    }

    // Create and store download history
    final downloadHistory = DownloadHistory(
      id: url,
      fileName: url.split('/').last,
      filePath: savePath,
      progress: 0.0,
      state: Downloadstate.inProgress.toString().split('.').last,
      size: size,
      time: DateTime.now(),
    );
    _localData.addDownload(downloadHistory);

    // Add the download to the provider
    provider.addDownload(url, size);

    // Initialize the downloader
    final downloader = ConcurrentFileDownloader(
      url: url,
      savePath: savePath,
      segmentCount: 4,
      onProgress: (downloadName, progress) {
        provider.updateProgress(downloadName, progress, size, DateTime.now());
      },
      onStateChange: (downloadName, state) {
        provider.updateState(downloadName, state, size, DateTime.now());
      },
    );

    // Start the download and handle errors
    try {
      await downloader.download();
    } catch (error) {
      print('Download failed: $error');
      provider.updateState(url, Downloadstate.failed, size, DateTime.now());
    }
  }

  void updateProgress(String downloadName, double progress, size, time) {
    final download = _downloads.firstWhere((d) => d.name == downloadName);
    download.progress = progress;

    // Update in local persistence
    _localData.updateDownload(downloadName, progress,
        download.state.toString().split('.').last, size, time);

    notifyListeners();
  }

  void updateState(String downloadName, Downloadstate state, size, time) {
    try {
      final download = _downloads.firstWhere((d) => d.name == downloadName);

      // Prevent unnecessary updates
      if (download.state != state) {
        download.state = state;

        // Update in local persistence
        _localData.updateDownload(downloadName, download.progress,
            state.toString().split('.').last, size, time);

        notifyListeners();
      }
    } catch (e) {
      print('Error updating download state: $e');
    }
  }

  Downloadstate _convertStateStringToEnum(String stateString) {
    return Downloadstate.values.firstWhere(
        (state) => state.toString().split('.').last == stateString,
        orElse: () => Downloadstate.inProgress);
  }
}
