import 'package:get_storage/get_storage.dart';

class UserPreferences {
  final box = GetStorage();

  Future<bool> getTheme() async {
    await GetStorage.init('user-data');

    final output = box.read('dark-mode');

    return output is bool ? output : false;
  }

  Future<void> updateTheme({required bool setToDarkMode}) async {
    await GetStorage.init('user-data');

    await box.write('dark-mode', setToDarkMode);
  }

  setUserPreferredDownloadLocation({required String location}) async {
    await GetStorage.init('user-data');

    await box.write('download-location', location);
  }

  Future<String?> getUserPreferredDownloadLocation() async {
    await GetStorage.init('user-data');

    return box.read('download-location');
  }

  setUserPreferredConcurrentDownloads(
      {required int concurrentDownloads}) async {
    await GetStorage.init('user-data');
    await box.write('concurrent-downloads', concurrentDownloads);
  }

  Future<int> getUserPreferredConcurrentDownloads() async {
    await GetStorage.init('user-data');
    return box.read('concurrent-downloads');
  }
}
