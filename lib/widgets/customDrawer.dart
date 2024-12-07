import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/screens/downloadsScreen.dart';

import 'package:turbo_shark/screens/settingsScreen.dart';
import 'package:turbo_shark/user_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final Function(Widget) onScreenChanged;

  const CustomDrawer({Key? key, required this.onScreenChanged})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final UserPreferences userPreferences = UserPreferences();
    final isDarkmode = userPreferences.getTheme() == true;
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompactMode = screenWidth < 600;

    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: isCompactMode ? screenWidth * 0.75 : screenWidth * 0.16,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDarkmode ? Colors.black : Colors.blue.shade300,
            isDarkmode ? Colors.black : Colors.blue.shade700,
          ],
        )),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(isCompactMode),
            ...List.generate(drawerItems.length, (index) {
              final item = drawerItems[index];
              return _buildDrawerTile(
                context: context,
                icon: item.icon,
                text: item.text,
                isSelected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onScreenChanged(item.screen);
                },
                isCompactMode: isCompactMode,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(bool isCompactMode) {
    // (Keep your existing _buildDrawerHeader implementation)
    return DrawerHeader(
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
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(0.3)
            : Colors.white.withOpacity(0.1),
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
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
  final Widget screen;

  DrawerItemConfig({
    required this.icon,
    required this.text,
    this.screen = const DownloadScreen(),
  });
}

final List<DrawerItemConfig> drawerItems = [
  DrawerItemConfig(
    icon: Icons.download,
    text: 'Downloads',
    screen: DownloadScreen(),
  ),
  DrawerItemConfig(
    icon: Icons.history,
    text: 'History',
    // screen: HistoryScreen(),
  ),
  DrawerItemConfig(
    icon: Icons.settings,
    text: 'Settings',
    screen: SettingsScreen(),
  ),
  DrawerItemConfig(
    icon: Icons.help,
    text: 'Help',
    //  screen: HelpScreen(),
  ),
];
