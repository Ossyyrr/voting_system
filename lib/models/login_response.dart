//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:voting_system/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.usuarioDb,
    required this.token,
  });

  bool ok;
  User usuarioDb;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuarioDb: User.fromMap(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuarioDb.toMap(),
        "token": token,
      };
}
