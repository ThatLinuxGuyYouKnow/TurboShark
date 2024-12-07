import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class darkModeSwitch extends StatefulWidget {
  @override
  State<darkModeSwitch> createState() => _darkModeSwitchState();
}

class _darkModeSwitchState extends State<darkModeSwitch> {
  final UserPreferences userPreferences = UserPreferences();

  Widget build(BuildContext context) {
    bool isDarkMode = userPreferences.getTheme();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          isDarkMode ? 'Switch to' + 'Dark Mode' : 'Switch to light mode',
          style: GoogleFonts.ubuntu(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
            print('Auto Resume: $isDarkMode');
          },
          activeColor: Colors.black,
          inactiveThumbColor: Colors.blue,
          inactiveTrackColor: Colors.blue.withOpacity(0.5),
        ),
      ],
    );
  }
}
