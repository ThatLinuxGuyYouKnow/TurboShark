import 'package:flutter/material.dart';

class DownloadLocationDropdown extends StatelessWidget {
  final Function onNewLocationSelected;
  DownloadLocationDropdown({super.key, required this.onNewLocationSelected});

  Widget build(BuildContext context) {
    List<DropdownMenuItem> avalaibleDownloadLocations = [];
    return DropdownButton(
        items: avalaibleDownloadLocations, onChanged: onNewLocationSelected());
  }
}
