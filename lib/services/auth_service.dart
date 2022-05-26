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

  Future register(String name, String email, String password) async {
    isAuthenticating = true;

    final data = {'name': name, 'email': email, 'password': password};

    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.statusCode);
    print(resp.body);

    isAuthenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.usuarioDb;
      print(resp.body);

      //  Guardar token
      await _saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future login(String email, String password) async {
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
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn(String token) async {
    final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
    final resp = await http.get(uri, headers: {'Content-Type': 'application/json', 'x-token': token});

    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.usuarioDb;
      //  Guardar nuevo token
      await _saveToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }

  Future logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
  }
}
