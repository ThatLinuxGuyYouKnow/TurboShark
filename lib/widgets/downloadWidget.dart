import 'package:flutter/material.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';

class DownloadWidget extends StatelessWidget {
  final Download download;

  const DownloadWidget({Key? key, required this.download}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(download.name),
      subtitle: LinearProgressIndicator(value: download.progress),
      trailing: Text(
        download.state.name,
        style: TextStyle(
          color: download.state == Downloadstate.inProgress
              ? Colors.orange
              : Colors.green,
        ),
      ),
    );
  }
}
