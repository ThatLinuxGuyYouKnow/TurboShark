import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';

class DownloadProvider extends ChangeNotifier {
  final List<Download> _downloads = [];
  List<Download> get downloads => _downloads;

  void addDownload(String downloadName) {
    final download = Download(name: downloadName);
    _downloads.add(download);
    notifyListeners();
  }

  void updateProgress(String downloadName, double progress) {
    final download = _downloads.firstWhere((d) => d.name == downloadName);
    download.progress = progress;
    notifyListeners();
  }

  void updateState(String downloadName, Downloadstate state) {
    final download = _downloads.firstWhere((d) => d.name == downloadName);
    download.state = state;
    notifyListeners();
  }
}
