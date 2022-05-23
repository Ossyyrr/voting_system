import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService with ChangeNotifier {
  late SharedPreferences _prefs;
  late String _userName;

  String get userName => _prefs.getString('userName') ?? '';
  set userName(String name) => _saveUserName(name);

  SharedPreferencesService(SharedPreferences perfs) {
    _prefs = perfs;
    initConfig();
  }

  void initConfig() async {
    _userName = _prefs.getString('userName') ?? '';
    notifyListeners();
    print('USERNAME: ' + _userName);
  }

  Future<void> _saveUserName(String name) async {
    _userName = name;
    await _prefs.setString('userName', name);
    notifyListeners();
  }
}
