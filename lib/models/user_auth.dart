//     final userAuth = userAuthFromJson(jsonString);

import 'dart:convert';

User userAuthFromJson(String str) => User.fromMap(json.decode(str));

String userAuthToJson(User data) => json.encode(data.toMap());

class User {
  User({
    required this.name,
    required this.email,
    required this.online,
    required this.uid,
    required this.avatarId,
    required this.votedPolls,
    required this.myPolls,
  });

  String name;
  String email;
  bool online;
  String uid;
  String avatarId;
  List<String> votedPolls;
  List<String> myPolls;

  factory User.fromMap(Map<String, dynamic> obj) => User(
        name: obj.containsKey('name') ? obj['name'] : 'no-name',
        email: obj.containsKey('email') ? obj['email'] : 'no-email',
        online: obj.containsKey('online') ? obj['online'] : false,
        uid: obj.containsKey('uid') ? obj['uid'] : 'no-id',
        avatarId: obj.containsKey('avatarId') ? obj['avatarId'] : 'no-avatarId',
        votedPolls: obj.containsKey('votedPolls') ? obj['votedPolls'].cast<String>() : [],
        myPolls: obj.containsKey('myPolls') ? obj['myPolls'].cast<String>() : [],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'online': online,
        'uid': uid,
        'avatarId': avatarId,
        'votedPolls': votedPolls,
        'myPolls': myPolls,
      };
}
