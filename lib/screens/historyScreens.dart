import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';
import 'package:turbo_shark/widgets/dataTable.dart';

//TODO:Might be reasonable to place the datatable widget within this same file
class HistoryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: CustomAppbar(textContent: 'History'),
        body: const CustomDatatable());
  }
}
