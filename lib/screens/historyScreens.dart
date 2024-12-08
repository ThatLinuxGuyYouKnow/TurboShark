import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class HistoryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(textContent: 'History'),
    );
  }
}
