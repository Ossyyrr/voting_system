import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voting_system/global/enviroments.dart';

class AuthService with ChangeNotifier {
  // final usuario;

  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print('resp ********');
    print(resp.statusCode);
    print(resp.body);
  }
}
