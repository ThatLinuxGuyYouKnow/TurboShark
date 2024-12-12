import 'package:flutter/material.dart';
import 'package:turbo_shark/user_preferences.dart';

class LiveTheme extends ChangeNotifier {
  bool _isDarkMode = false;
  final UserPreferences userPreferences = UserPreferences();

  bool get isDarkMode => _isDarkMode;

  LiveTheme() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    _isDarkMode = await userPreferences.getTheme();
    notifyListeners();
  }

  void changeTheme({required bool isDarkMode}) {
    _isDarkMode = isDarkMode;
    userPreferences.updateTheme(setToDarkMode: isDarkMode);
    notifyListeners();
  }
}
