import 'package:get_storage/get_storage.dart';

class UserPreferences {
  getTheme() async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    return box.read('dark-mode') ?? false;
  }

  ///set to true to set to dark mode
  updateTheme({required bool setToDarkMode}) async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    box.write('dark-mode', setToDarkMode);
  }
}
