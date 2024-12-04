import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/widgets/downloadWidget.dart';

class DownloadProvider extends ChangeNotifier {
  final List<Widget> _downloads = [];
  List<Widget> get downloads => _downloads;
  final List<Widget> _currentDownloads = [];
  List<Widget> get currentDownloads => _currentDownloads;
  addDownload({
    required String downloadName,
  }) {
    _downloads.add(
      DownloadWidget(
          downloadName: downloadName,
          downloadProgress: 1,
          downloadstate: Downloadstate.inProgress),
    );
    _currentDownloads.add(DownloadWidget(
        downloadName: downloadName,
        downloadProgress: 1,
        downloadstate: Downloadstate.inProgress));
    notifyListeners();
  }
}
