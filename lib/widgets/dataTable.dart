import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/enums/downloadState.dart';
import 'package:turbo_shark/models/download.dart';
import 'package:turbo_shark/models/downloadProvider.dart';

class CustomDatatable extends StatelessWidget {
  CustomDatatable({super.key});

  @override
  Widget build(BuildContext context) {
    final downloads = Provider.of<DownloadProvider>(context).downloads;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columnSpacing: 24,
          headingRowHeight: 56,
          dataRowHeight: 64,
          headingTextStyle: GoogleFonts.ubuntu(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800]),
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.grey[200]!),
          columns: const [
            DataColumn(label: HeaderText('Filename')),
            DataColumn(label: HeaderText('Size')),
            DataColumn(label: HeaderText('Date')),
            DataColumn(label: HeaderText('Status')),
            DataColumn(label: HeaderText('Actions')),
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
                //DataCell(Text(
                //    formatFileSize(
                //         download.size), // Add a method for file size formatting
                //    style: GoogleFonts.ubuntu(fontSize: 14),
                //  )),
                //  DataCell(Text(
                //    formatDate(download.date), // Add a method for date formatting
                //    style: GoogleFonts.ubuntu(fontSize: 14),
                //  )),
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
                      onPressed: () => downloadFile(download),
                      icon: Icon(Icons.download_rounded, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () => deleteFile(download),
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
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

  void downloadFile(Download download) {
    // Implement download functionality
  }

  void deleteFile(Download download) {
    // Implement delete functionality
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
