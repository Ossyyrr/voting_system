import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voting_system/global/enviroments.dart';
import 'package:voting_system/models/login_response.dart';
import 'package:voting_system/models/user_auth.dart';

class AuthService with ChangeNotifier {
  late UserAuth user;

  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.usuarioDb;

      //  await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }
}
