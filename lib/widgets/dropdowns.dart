import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadLocationDropdown extends StatefulWidget {
  final Function(String) onNewLocationSelected;

  const DownloadLocationDropdown(
      {Key? key, required this.onNewLocationSelected})
      : super(key: key);

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
    return DropdownButton<String>(
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
    );
  }
}

class ConcurrentDownloadsSelector extends StatefulWidget {
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
    return DropdownButton<String>(
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
    );
  }
}
