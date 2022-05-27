import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO Reorganizar esta clase
class SharedPreferencesService with ChangeNotifier {
  late SharedPreferences _prefs;
  //late String _deviceId;

  //String get deviceId => _deviceId;
  String get token => _prefs.getString('token') ?? '';

  set userName(String name) => _saveUserName(name);
  set token(String token) => _saveToken(token);

  SharedPreferencesService(SharedPreferences perfs) {
    _prefs = perfs;
    initConfig();
  }

  void initConfig() async {
    // await _prefs.remove('token');
    //  _deviceId = _prefs.getString('deviceId') ?? '';
    // _getDeviceId();
    notifyListeners();
    // await _prefs.remove('token');
    print('TOKEN: ' + token);
  }

  Future<void> _saveUserName(String name) async {
    await _prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    await _prefs.setString('token', token);
    notifyListeners();
  }

  // void _getDeviceId() async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   final deviceInfo = await deviceInfoPlugin.deviceInfo;
  //   final map = deviceInfo.toMap();
  //   if (Platform.isIOS) _deviceId = map['identifierForVendor'];
  //   if (Platform.isAndroid) _deviceId = map['androidId'];
  //   await _prefs.setString('deviceId', _deviceId);
  //   print('DEVICE_ID: ' + _deviceId);
  // }
}
