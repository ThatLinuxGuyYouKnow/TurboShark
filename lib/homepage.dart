import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turbo_shark/screens/downloadsScreen.dart';
import 'package:turbo_shark/screens/settingsScreen.dart';
import 'package:turbo_shark/widgets/customDrawer.dart';
import 'package:turbo_shark/widgets/searchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentScreen = DownloadScreen();

  void _changeScreen(Widget newScreen) {
    setState(() {
      _currentScreen = newScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 700;

        return Scaffold(
          body: isWideScreen
              ? Row(
                  children: [
                    CustomDrawer(onScreenChanged: _changeScreen),
                    Expanded(child: _currentScreen),
                  ],
                )
              : _currentScreen,
          drawer: !isWideScreen
              ? CustomDrawer(onScreenChanged: _changeScreen)
              : null,
        );
      },
    );
  }
}
