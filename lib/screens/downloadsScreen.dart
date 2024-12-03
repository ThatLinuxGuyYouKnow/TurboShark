import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({super.key});
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        appBarTitle: 'Downloads',
      ),
    );
  }
}
