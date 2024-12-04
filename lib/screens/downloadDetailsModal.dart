import 'package:flutter/material.dart';

class DownloadDetailsmodal extends StatelessWidget {
  DownloadDetailsmodal({super.key});
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: Container(
          height: 800,
          width: 800,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Icon(Icons.cancel_outlined)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
