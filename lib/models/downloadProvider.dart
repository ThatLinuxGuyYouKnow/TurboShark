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
          name: history.fileName,
          state: _convertStateStringToEnum(history.state),
          progress: history.progress);
      _downloads.add(download);
    }
    notifyListeners();
  }

  void addDownload(String downloadName) {
    final download = Download(name: downloadName);
    _downloads.add(download);

    // Also save to local persistence
    final downloadHistory = DownloadHistory(
        id: download.id,
        fileName: downloadName,
        filePath: '', // You might want to pass this when starting download
        progress: 0.0,
        state: download.state.toString().split('.').last);
    _localData.addDownload(downloadHistory);

    notifyListeners();
  }

  void startDownload(BuildContext context, String url, String savePath) {
    final provider = Provider.of<DownloadProvider>(context, listen: false);

    // Create download history
    final downloadHistory = DownloadHistory(
        id: url, // Using URL as ID, consider a more robust ID generation
        fileName: url.split('/').last,
        filePath: savePath,
        progress: 0.0,
        state: Downloadstate.inProgress.toString().split('.').last);
    _localData.addDownload(downloadHistory);

    // Add the download to the provider
    provider.addDownload(url);

    final downloader = ConcurrentFileDownloader(
      url: url,
      savePath: savePath,
      segmentCount: 4,
      onProgress: (downloadName, progress) {
        provider.updateProgress(downloadName, progress);
      },
      onStateChange: (downloadName, state) {
        provider.updateState(downloadName, state);
      },
    );

    downloader.download().catchError((error) {
      print('Download failed: $error');
      provider.updateState(url, Downloadstate.failed);
    });
  }

  void updateProgress(String downloadName, double progress) {
    final download = _downloads.firstWhere((d) => d.name == downloadName);
    download.progress = progress;

    // Update in local persistence
    _localData.updateDownload(
        downloadName, progress, download.state.toString().split('.').last);

    notifyListeners();
  }

  void updateState(String downloadName, Downloadstate state) {
    try {
      final download = _downloads.firstWhere((d) => d.name == downloadName);

      // Prevent unnecessary updates
      if (download.state != state) {
        download.state = state;

        // Update in local persistence
        _localData.updateDownload(
            downloadName, download.progress, state.toString().split('.').last);

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
