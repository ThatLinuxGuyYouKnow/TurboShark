import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';
import 'package:turbo_shark/widgets/dataTable.dart';

class HistoryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(textContent: 'History'),
        body: CustomDatatable());
  }
}
