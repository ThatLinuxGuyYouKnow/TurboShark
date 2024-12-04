import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class DownloadScreen extends StatelessWidget {
  final BoxConstraints constraints;

  const DownloadScreen({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final downloadProvider = Provider.of<DownloadProvider>(context);
    List<Widget> downloadList = downloadProvider.downloads;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForDownloads(
        appBarTitle: 'Downloads',
        constraints: constraints,
      ),
      body: downloadList.isEmpty
          ? Center(
              child: Text(
                'No downloads yet',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: downloadList,
            ),
    );
  }
}
