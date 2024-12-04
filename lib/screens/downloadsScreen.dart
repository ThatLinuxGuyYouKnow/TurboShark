import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class DownloadScreen extends StatelessWidget {
  final BoxConstraints constraints;
  DownloadScreen({super.key, required this.constraints});
  Widget build(BuildContext context) {
    final downloadProvider = Provider.of<DownloadProvider>(context);
    List<Widget> downloadList = downloadProvider.downloads;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForDownloads(
        appBarTitle: 'Downloads',
        constraints: constraints,
      ),
      body: Column(
        children: [...downloadList],
      ),
    );
  }
}
