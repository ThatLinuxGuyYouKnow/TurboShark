import 'package:get_storage/get_storage.dart';

class UserPreferences {
  Future<bool?> getTheme() async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    return box.read('dark-mode');
  }

  Future<void> updateTheme({required bool setToDarkMode}) async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    await box.write('dark-mode', setToDarkMode);
  }
}
