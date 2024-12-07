import 'package:get_storage/get_storage.dart';

class UserPreferences {
  getTheme() async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    return box.read('dark-mode') ?? false;
  }

  updateTheme() async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    box.write('dark-mode', false);
  }
}
