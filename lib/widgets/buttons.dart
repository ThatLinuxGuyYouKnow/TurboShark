import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadPromptButton extends StatelessWidget {
  DownloadPromptButton({super.key});
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: 220,
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'New Download',
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
