//     final userAuth = userAuthFromJson(jsonString);

import 'dart:convert';

UserAuth userAuthFromJson(String str) => UserAuth.fromJson(json.decode(str));

String userAuthToJson(UserAuth data) => json.encode(data.toJson());

class UserAuth {
  UserAuth({
    required this.nombre,
    required this.email,
    required this.online,
    required this.uid,
  });

  String nombre;
  String email;
  bool online;
  String uid;

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
        nombre: json["nombre"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
