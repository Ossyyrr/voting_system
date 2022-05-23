import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService with ChangeNotifier {
  late SharedPreferences _prefs;
  String _userName = 'no-name';

  String get userName => _prefs.getString('userName') ?? 'no-name';
  set userName(String name) => _saveUserName(name);

  SharedPreferencesService() {
    initConfig();
  }

  void initConfig() async {
    _prefs = await SharedPreferences.getInstance();
    _userName = _prefs.getString('userName') ?? 'no-name';
    notifyListeners();
  }

  Future<void> _saveUserName(String name) async {
    _userName = name;
    await _prefs.setString('userName', name);
    notifyListeners();
  }
}
