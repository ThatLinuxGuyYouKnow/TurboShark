import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class DownloadScreen extends StatelessWidget {
  final BoxConstraints constraints;
  DownloadScreen({super.key, required this.constraints});
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForDownloads(
        appBarTitle: 'Downloads',
        constraints: constraints,
      ),
    );
  }
}
