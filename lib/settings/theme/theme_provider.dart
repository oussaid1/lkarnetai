import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme
final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

class AppThemeState extends ChangeNotifier {
  final String key = "isDark";
  SharedPreferences? _preferences;
  late bool _darkMode = false;

  bool get darkMode => _darkMode;

  AppThemeState() {
    _darkMode = true;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences!.getBool(key) ?? true;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}

// Theme
final notificationStateNotifier =
    ChangeNotifierProvider((ref) => NotificationState());

class NotificationState extends ChangeNotifier {
  final String key = "notificationActive";
  SharedPreferences? _preferences;
  late bool _notificationActive = false;

  bool get shouldNotify => _notificationActive;

  NotificationState() {
    _notificationActive = true;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setBool(key, _notificationActive);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _notificationActive = _preferences!.getBool(key) ?? true;
    notifyListeners();
  }

  toggleChangeTheme() {
    _notificationActive = !_notificationActive;
    _savePreferences();
    notifyListeners();
  }
}
