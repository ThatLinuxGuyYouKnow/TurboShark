import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Datatable extends StatelessWidget {
  Datatable({super.key});
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(label: Text('Filename')),
      DataColumn(label: Text('Size')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('Actions'))
    ], rows: []);
  }
}

class DatatableHeaderText extends StatelessWidget {
  DatatableHeaderText({super.key, required this.text});
  final String text;
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.ubuntu());
  }
}
