import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/widgets/downloadWidget.dart';

class DownloadProvider extends ChangeNotifier {
  List<Widget> downloads = [];
  List<Widget> get _downloads => downloads;

  addDownload({
    required String downloadName,
  }) {
    _downloads.add(DownloadWidget(
        downloadName: downloadName,
        downloadProgress: 1,
        downloadstate: Downloadstate.inProgress));
  }
}
