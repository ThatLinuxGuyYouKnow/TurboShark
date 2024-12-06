import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadLocationDropdown extends StatefulWidget {
  final Function(String) onNewLocationSelected;

  const DownloadLocationDropdown(
      {super.key, required this.onNewLocationSelected});

  @override
  _DownloadLocationDropdownState createState() =>
      _DownloadLocationDropdownState();
}

class _DownloadLocationDropdownState extends State<DownloadLocationDropdown> {
  List<DropdownMenuItem<String>> availableLocations = [];
  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    _fetchAvailableLocations();
  }

  Future<void> _fetchAvailableLocations() async {
    List<Directory?> directories = [
      await getDownloadsDirectory(), // Common downloads directory
      await getApplicationDocumentsDirectory(), // App-specific documents
      await getTemporaryDirectory(), // Temporary directory
    ];

    setState(() {
      availableLocations = directories
          .where((dir) => dir != null)
          .map((dir) => DropdownMenuItem(
                value: dir!.path,
                child: Text(dir.path),
              ))
          .toList();
      if (availableLocations.isNotEmpty) {
        selectedLocation = availableLocations.first.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10)),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        underline: SizedBox.shrink(),
        focusColor: Colors.white,
        items: availableLocations,
        value: selectedLocation,
        onChanged: (value) {
          print('attempting download');
          setState(() {
            selectedLocation = value!;
          });
          widget.onNewLocationSelected(selectedLocation!);
        },
        isExpanded: true,
      ),
    );
  }
}

class ConcurrentDownloadsSelector extends StatefulWidget {
  const ConcurrentDownloadsSelector({super.key});

  @override
  _ConcurrentDownloadsSelectorState createState() =>
      _ConcurrentDownloadsSelectorState();
}

class _ConcurrentDownloadsSelectorState
    extends State<ConcurrentDownloadsSelector> {
  final List<String> maxConcurrentDownloads = ['1', '2', '3', '4'];
  String? selectedValue; // Holds the currently selected value

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10)),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        underline: SizedBox.shrink(),
        focusColor: Colors.white,
        items: maxConcurrentDownloads
            .map((download) => DropdownMenuItem(
                  value: download,
                  child: Text(download),
                ))
            .toList(),
        value: selectedValue,
        hint: Text('Select downloads'), // Placeholder text
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          print('Selected: $value');
        },
        isExpanded: true, // Ensures full width of the dropdown
      ),
    );
  }
}

class DownloadPrioritySelector extends StatefulWidget {
  const DownloadPrioritySelector({super.key});

  @override
  _DownloadPrioritySelectorState createState() =>
      _DownloadPrioritySelectorState();
}

class _DownloadPrioritySelectorState extends State<DownloadPrioritySelector> {
  final List<String> maxConcurrentDownloads = ['Low', 'Normal', 'High'];
  String? selectedValue; // Holds the currently selected value

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        underline: SizedBox.shrink(), // Removes default underline
        focusColor: Colors.transparent,
        items: maxConcurrentDownloads
            .map(
              (download) => DropdownMenuItem(
                value: download,
                child: Text(
                  download,
                  style: TextStyle(fontSize: 16), // Styling for dropdown items
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        hint: Text(
          'Select Download Priority',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ), // Placeholder text
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          print('Selected: $value');
        },
        isExpanded: true, // Ensures the dropdown covers full width
        dropdownColor: Colors.white, // Dropdown menu background color
        icon: Icon(Icons.arrow_drop_down), // Custom dropdown icon
      ),
    );
  }
}
