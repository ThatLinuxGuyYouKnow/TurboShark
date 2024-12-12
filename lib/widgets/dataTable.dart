import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/dataHandling/localPersistence.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';
import 'package:turbo_shark/models/downloadProvider.dart';

class CustomDatatable extends StatelessWidget {
  const CustomDatatable({super.key});

  @override
  Widget build(BuildContext context) {
    final downloads = Provider.of<DownloadProvider>(context).downloads.reversed;
    final DownloadRepository downloadRepository = DownloadRepository();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 24,
        headingRowHeight: 56,
        dataRowMaxHeight: 64,
        headingTextStyle: GoogleFonts.ubuntu(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
        headingRowColor: WidgetStateProperty.resolveWith<Color>(
            (states) => Colors.blue[100]!.withOpacity(0.1)),
        columns: const [
          DataColumn(label: HeaderText('Filename')),
          DataColumn(label: HeaderText('Size')),
          DataColumn(label: HeaderText('Date')),
          DataColumn(label: HeaderText('Status')),
          DataColumn(label: HeaderText('Action')),
        ],
        rows: downloads.map((download) {
          return DataRow(
            cells: [
              DataCell(Row(
                children: [
                  Icon(Icons.insert_drive_file, color: Colors.grey[700]),
                  SizedBox(width: 8),
                  Text(
                    download.name,
                    style: GoogleFonts.ubuntu(fontSize: 14),
                  ),
                ],
              )),
              DataCell(Text(
                formatFileSize(download.size),
                style: GoogleFonts.ubuntu(fontSize: 14),
              )),
              DataCell(Text(
                formatDate(download.date),
                style: GoogleFonts.ubuntu(fontSize: 14),
              )),
              DataCell(Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(download.state),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  download.state.toString().split('.').last,
                  style: GoogleFonts.ubuntu(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      downloadRepository.deleteDownload(download.id);
                      print('delete download!');
                    },
                    icon: const Icon(Icons.delete, color: Colors.grey),
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  String formatFileSize(int sizeInBytes) {
    if (sizeInBytes >= 1e9) {
      return '${(sizeInBytes / 1e9).toStringAsFixed(1)} GB';
    } else if (sizeInBytes >= 1e6) {
      return '${(sizeInBytes / 1e6).toStringAsFixed(1)} MB';
    } else {
      return '${(sizeInBytes / 1e3).toStringAsFixed(1)} KB';
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Color getStatusColor(Downloadstate state) {
    switch (state) {
      case Downloadstate.done:
        return Colors.green;
      case Downloadstate.failed:
        return Colors.red;
      case Downloadstate.paused:
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w800),
    );
  }
}
