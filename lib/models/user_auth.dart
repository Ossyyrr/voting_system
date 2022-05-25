//     final userAuth = userAuthFromJson(jsonString);

import 'dart:convert';

UserAuth userAuthFromJson(String str) => UserAuth.fromJson(json.decode(str));

String userAuthToJson(UserAuth data) => json.encode(data.toJson());

class UserAuth {
  UserAuth({
    required this.name,
    required this.email,
    required this.online,
    required this.uid,
  });

  String name;
  String email;
  bool online;
  String uid;

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
        name: json["name"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
