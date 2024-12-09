import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CurrentDownloadLocationProvider extends ChangeNotifier {
  String get downloadLocation =>
      getCurrentDonwloadLocation() ?? _defaultDownloadLocation;
  String _defaultDownloadLocation = getDownloadsDirectory().toString();
  String? getCurrentDonwloadLocation() {}
}
