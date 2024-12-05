import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/logic/downloadManager.dart';
import 'package:turbo_shark/models/download.dart';

class DownloadProvider extends ChangeNotifier {
  final List<Download> _downloads = [];
  List<Download> get downloads => _downloads;

  void addDownload(String downloadName) {
    final download = Download(name: downloadName);
    _downloads.add(download);
    notifyListeners();
  }

  void startDownload(BuildContext context, String url, String savePath) {
    final provider = Provider.of<DownloadProvider>(context, listen: false);

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
    notifyListeners();
  }

  void updateState(String downloadName, Downloadstate state) {
    try {
      final download = _downloads.firstWhere((d) => d.name == downloadName);

      // Prevent unnecessary updates
      if (download.state != state) {
        download.state = state;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating download state: $e');
      // Optionally, you could add error handling or logging here
    }
  }
}
