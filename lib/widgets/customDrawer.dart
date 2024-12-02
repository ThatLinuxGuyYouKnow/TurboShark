import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Turbo Shark',
              style: GoogleFonts.russoOne(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.lexend(fontSize: 14),
                ),
                Image(
                  image: AssetImage('assets/logo.png'),
                )
              ],
            ),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
        ],
      ),
    );
  }
}
