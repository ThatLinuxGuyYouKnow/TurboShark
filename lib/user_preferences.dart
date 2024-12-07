import 'package:get_storage/get_storage.dart';

class UserPreferences {
  updateTheme() async {
    await GetStorage.init('user-data');
    final box = GetStorage();
    box.write('dark-mode', false);
  }
}
