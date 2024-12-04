import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/screens/downloadDetailsModal.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class DownloadScreen extends StatefulWidget {
  final BoxConstraints constraints;

  const DownloadScreen({super.key, required this.constraints});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool showOverlay = false;
  @override
  Widget build(BuildContext context) {
    final downloadProvider = Provider.of<DownloadProvider>(context);
    List<Widget> downloadList = downloadProvider.downloads;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBarForDownloads(
            onNewDownloadPressed: () {
              setState(() {
                showOverlay = true;
              });
            },
            appBarTitle: 'Downloads',
            constraints: widget.constraints,
          ),
          body: downloadList.isEmpty
              ? Center(
                  child: Text(
                    'No downloads yet',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: downloadList.length,
                  itemBuilder: (context, index) {
                    return downloadList[index];
                  },
                ),
        ),
        showOverlay ? DownloadDetailsmodal() : SizedBox.shrink()
      ],
    );
  }
}
