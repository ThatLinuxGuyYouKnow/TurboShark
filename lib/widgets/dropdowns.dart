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
        selectedLocation = availableLocations.first.value as String?;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: availableLocations,
      value: selectedLocation,
      onChanged: (value) {
        print('attempting download');
        setState(() {
          selectedLocation = value!;
        });
        widget.onNewLocationSelected(value!);
      },
    );
  }
}
