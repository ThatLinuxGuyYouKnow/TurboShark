import 'package:flutter/material.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Auto Resume Downloads',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Switch(
          value: isAutoResumeEnabled,
          onChanged: (value) {
            setState(() {
              isAutoResumeEnabled = value;
            });
            print('Auto Resume: $isAutoResumeEnabled');
          },
          activeColor: Colors.green,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }
}
