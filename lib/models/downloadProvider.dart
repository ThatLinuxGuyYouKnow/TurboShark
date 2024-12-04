import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/widgets/downloadWidget.dart';

class DownloadProvider extends ChangeNotifier {
  final List<Widget> _downloads = [];
  List<Widget> get downloads => _downloads;

  addDownload({
    required String downloadName,
  }) {
    _downloads.add(DownloadWidget(
        downloadName: downloadName,
        downloadProgress: 1,
        downloadstate: Downloadstate.inProgress));
    notifyListeners();
  }
}
