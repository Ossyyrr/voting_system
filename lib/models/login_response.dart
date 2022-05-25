//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:voting_system/models/user_auth.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.usuarioDb,
    required this.token,
  });

  bool ok;
  UserAuth usuarioDb;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuarioDb: UserAuth.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarioDB": usuarioDb.toJson(),
        "token": token,
      };
}
