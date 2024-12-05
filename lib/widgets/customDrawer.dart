import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompactMode = screenWidth < 600;

    return Drawer(
      width: isCompactMode ? screenWidth * 0.75 : screenWidth * 0.16,
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
            _buildDrawerHeader(isCompactMode),
            ...drawerItems
                .map((item) => _buildDrawerTile(
                      context: context,
                      icon: item.icon,
                      text: item.text,
                      onTap: item.onTap,
                      isCompactMode: isCompactMode,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(bool isCompactMode) {
    return DrawerHeader(
      decoration: BoxDecoration(shape: BoxShape.rectangle),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Image(
            image: AssetImage('assets/logo.png'),
            width: 60,
            height: 60,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Turbo Shark',
              style: GoogleFonts.russoOne(
                fontWeight: FontWeight.bold,
                fontSize: isCompactMode ? 20 : 24,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isCompactMode,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                if (!isCompactMode)
                  Expanded(
                    child: Text(
                      text,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Drawer menu items configuration
class DrawerItemConfig {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  DrawerItemConfig({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

final List<DrawerItemConfig> drawerItems = [
  DrawerItemConfig(
    icon: Icons.download,
    text: 'Downloads',
    onTap: () {
      // Handle downloads
    },
  ),
  DrawerItemConfig(
    icon: Icons.history,
    text: 'History',
    onTap: () {
      // Handle history
    },
  ),
  DrawerItemConfig(
    icon: Icons.settings,
    text: 'Settings',
    onTap: () {
      // Handle settings
    },
  ),
  DrawerItemConfig(
    icon: Icons.help,
    text: 'Help',
    onTap: () {
      // Handle help
    },
  ),
];
