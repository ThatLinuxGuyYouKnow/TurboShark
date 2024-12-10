import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/screens/downloadDetailsModal.dart';
import 'package:turbo_shark/widgets/appbar.dart';
import 'package:turbo_shark/widgets/downloadWidget.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool showOverlay = false;

  @override
  Widget build(BuildContext context) {
    final downloadProvider = Provider.of<DownloadProvider>(context);

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
          ),
          body: downloadProvider.downloads.isEmpty
              ? Center(
                  child: Text(
                    'No downloads yet',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: downloadProvider.downloads.length,
                  itemBuilder: (context, index) {
                    final download = downloadProvider.downloads[downloadProvider
                            .downloads.length -
                        1 -
                        index]; // so the downloads start from most recent/last first
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: DownloadWidget(
                        download: download,
                      ),
                    );
                  },
                ),
        ),
        showOverlay
            ? DownloadDetailsModal(
                onModalClosePrompted: () {
                  setState(() {
                    showOverlay = false;
                  });
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
