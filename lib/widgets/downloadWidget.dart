import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';

class DownloadWidget extends StatelessWidget {
  final String downloadName;
  final int downloadProgress;
  final Downloadstate downloadstate;
  DownloadWidget(
      {super.key,
      required this.downloadName,
      required this.downloadProgress,
      required this.downloadstate});
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(downloadName),
          LinearProgressIndicator(
            value: downloadProgress.toDouble(),
          ),
          if (downloadstate == Downloadstate.inProgress) Text('In Progress')
        ],
      ),
    );
  }
}
