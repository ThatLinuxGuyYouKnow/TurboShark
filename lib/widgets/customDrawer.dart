import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.17,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('logo.png'),
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Turbo Shark',
                    style: GoogleFonts.russoOne(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerTile(
              context,
              icon: Icons.download,
              text: 'Downloads',
              onTap: () {
                // Handle downloads
              },
            ),
            _buildDrawerTile(
              context,
              icon: Icons.settings,
              text: 'Settings',
              isReversed: false,
              onTap: () {
                // Handle settings
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isReversed = false,
  }) {
    final tileContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: 59.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: isReversed
            ? [
                Text(
                  text,
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
              ]
            : [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  text,
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: tileContent,
          ),
        ),
      ),
    );
  }
}
