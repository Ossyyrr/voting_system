import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService with ChangeNotifier {
  late SharedPreferences _prefs;
  late String _userName;
  late String _token;
  late String _deviceId;

  String get userName => _userName;
  String get deviceId => _deviceId;
  String get token => _token;

  set userName(String name) => _saveUserName(name);
  set token(String token) => _saveToken(token);

  SharedPreferencesService(SharedPreferences perfs) {
    _prefs = perfs;
    initConfig();
  }

  void initConfig() async {
    _userName = _prefs.getString('userName') ?? '';
    _deviceId = _prefs.getString('deviceId') ?? '';
    _token = _prefs.getString('token') ?? '';
    _getDeviceId();
    notifyListeners();
    print('USERNAME: ' + _userName);
    print('TOKEN: ' + _token);
  }

  Future<void> _saveUserName(String name) async {
    _userName = name;
    await _prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    _token = token;
    await _prefs.setString('token', token);
    notifyListeners();
  }

  void _getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final map = deviceInfo.toMap();
    if (Platform.isIOS) _deviceId = map['identifierForVendor'];
    if (Platform.isAndroid) _deviceId = map['androidId'];
    await _prefs.setString('deviceId', _deviceId);
    print('DEVICE_ID: ' + _deviceId);
  }
}
