import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/themeState.dart';
import 'package:turbo_shark/user_preferences.dart';

class AutoResumeSwitch extends StatefulWidget {
  const AutoResumeSwitch({super.key});

  @override
  _AutoResumeSwitchState createState() => _AutoResumeSwitchState();
}

class _AutoResumeSwitchState extends State<AutoResumeSwitch> {
  bool isAutoResumeEnabled = false; // State to track the switch's value

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Auto Resume Downloads',
          style: GoogleFonts.ubuntu(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        Switch(
          value: isAutoResumeEnabled,
          onChanged: (value) {
            setState(() {
              isAutoResumeEnabled = value;
            });
            print('Auto Resume: $isAutoResumeEnabled');
          },
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }
}

class DarkModeSwitch extends StatefulWidget {
  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  final UserPreferences userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    final darkModeState = Provider.of<LiveTheme>(context);
    final isDarkMode = darkModeState.isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          isDarkMode ? 'Light Mode' : 'Dark Mode',
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            // Toggle theme based on the new value
            darkModeState.changeTheme(isDarkMode: value);
          },
          activeColor: Colors.black,
          inactiveThumbColor: Colors.blue,
          inactiveTrackColor: Colors.blue.withOpacity(0.5),
        ),
      ],
    );
  }
}
