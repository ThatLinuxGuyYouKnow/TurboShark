import 'package:flutter/material.dart';
import 'package:turbo_shark/widgets/appbar.dart';

class HistoryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(textContent: 'History'),
      body: DataTable(
        columns: [
          DataColumn(label: Text('Filename')),
          DataColumn(label: Text('Size')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('file1.txt')),
              DataCell(Text('10 KB')),
              DataCell(Text('2023-04-15')),
              DataCell(Text('Completed')),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete action
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Handle open action
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Add more rows as needed
        ],
      ),
    );
  }
}
