import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CurrentDownloadLocationProvider extends ChangeNotifier {
  String? _currentDownloadLocation;

  String get downloadLocation =>
      _currentDownloadLocation ?? _defaultDownloadLocation;

  final String _defaultDownloadLocation = getDownloadsDirectory().toString();

  void setCurrentDownloadLocation(String newLocation) {
    _currentDownloadLocation = newLocation;
    notifyListeners();
  }

  String? getCurrentDonwloadLocation() {
    return _currentDownloadLocation;
  }
}
