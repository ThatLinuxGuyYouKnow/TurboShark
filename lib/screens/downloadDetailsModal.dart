import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadDetailsmodal extends StatelessWidget {
  final Function onModalClosePrompted;
  DownloadDetailsmodal({super.key, required this.onModalClosePrompted});
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: Container(
          height: 800,
          width: 800,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () => onModalClosePrompted(),
                        child: Icon(Icons.cancel_outlined)),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'New Download',
                      style: GoogleFonts.ubuntu(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Enter the details for your new download.',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Download URL',
                      style: GoogleFonts.ubuntu(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
