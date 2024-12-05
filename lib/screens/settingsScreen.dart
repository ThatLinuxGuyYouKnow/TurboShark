import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        textContent: 'Settings',
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(children: [
            SizedBox(width: 20),
            Text(
              'Default Download PATH',
              style:
                  GoogleFonts.ubuntu(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            SizedBox(width: 10),
            Text(getDownloadsDirectory().toString())
          ])
        ],
      ),
    );
  }
}
