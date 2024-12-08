import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/models/download.dart';
import 'package:turbo_shark/models/downloadProvider.dart';

class CustomDatatable extends StatelessWidget {
  CustomDatatable({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the downloads from the provider
    final downloads = Provider.of<DownloadProvider>(context).downloads;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: double.infinity, // Makes the table fill the available width
        child: DataTable(
          columnSpacing: 16, // Adjust spacing between columns
          columns: const [
            DataColumn(label: DatatableHeaderText(text: 'File Name')),
            DataColumn(label: DatatableHeaderText(text: 'Progress')),
            DataColumn(label: DatatableHeaderText(text: 'State')),
          ],
          rows: downloads.map((download) {
            return DataRow(cells: [
              DataCell(Text(download.name)),
              DataCell(
                  Text('${(download.progress * 100).toStringAsFixed(1)}%')),
              DataCell(Text(download.state.toString().split('.').last)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class DatatableHeaderText extends StatelessWidget {
  const DatatableHeaderText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
