import 'package:get_storage/get_storage.dart';

class UserPreferences {
  final GetStorage box = GetStorage('user-data');

  Future<bool> getTheme() async {
    final output = box.read('dark-mode');

    return output is bool ? output : false;
  }

  Future<void> updateTheme({required bool setToDarkMode}) async {
    await box.write('dark-mode', setToDarkMode);
  }

  setUserPreferredDownloadLocation({required String location}) async {
    await box.write('download-location', location);
  }

  Future<String?> getUserPreferredDownloadLocation() async {
    return box.read('download-location');
  }

  setUserPreferredConcurrentDownloads(
      {required int concurrentDownloads}) async {
    await box.write('concurrent-downloads', concurrentDownloads);
  }

  Future<int> getUserPreferredConcurrentDownloads() async {
    return box.read('concurrent-downloads');
  }
}
