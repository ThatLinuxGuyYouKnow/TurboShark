import 'package:flutter/material.dart';
import 'package:turbo_shark/user_preferences.dart';

class LiveTheme extends ChangeNotifier {
  bool? _isDarkMode;
  bool get isDarkMode => _isDarkMode ?? false;

  UserPreferences userPreferences = UserPreferences();
  getTheme() async {
    _isDarkMode = await userPreferences.getTheme();
    notifyListeners();
  }

  changeTheme({required bool isDarkMode}) {
    _isDarkMode = isDarkMode;
    userPreferences.updateTheme(setToDarkMode: isDarkMode);
    notifyListeners();
  }
}
