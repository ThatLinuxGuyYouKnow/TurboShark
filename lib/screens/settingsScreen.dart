import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        textContent: 'Settings',
      ),
    );
  }
}
