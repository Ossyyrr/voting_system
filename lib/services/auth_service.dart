import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system/global/enviroments.dart';
import 'package:voting_system/models/login_response.dart';
import 'package:voting_system/models/user_auth.dart';

class AuthService with ChangeNotifier {
  late UserAuth user;
  bool _isAuthenticating = false;
  bool get isAuthenticating => _isAuthenticating;
  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    isAuthenticating = true;
    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    isAuthenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.usuarioDb;
      print(resp.body);

      //  Guardar token
      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }
}
