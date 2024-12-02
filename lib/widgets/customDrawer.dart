import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.18, // 75% of screen width
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Image(
                  image: AssetImage('logo.png'),
                  width: 100, // Specify image width
                  height: 100, // Specify image height
                ),
                SizedBox(width: 16), // Add spacing between image and text
                Text(
                  'Turbo Shark',
                  style: GoogleFonts.russoOne(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Increased font size
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: GoogleFonts.lexend(fontSize: 16),
            ),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: Text(
              'Item 2',
              style: GoogleFonts.lexend(fontSize: 16),
            ),
            onTap: () {
              // Handle item 2 tap
            },
          ),
        ],
      ),
    );
  }
}
