import 'package:voting_system/models/poll.dart';

class User {
  String id;
  String name;
  String avatarId;
  List<Poll> votedPolls;
  List<Poll> myPolls;

  User({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.votedPolls,
    required this.myPolls,
  });

  factory User.fromMap(Map<String, dynamic> obj) => User(
        id: obj.containsKey('id') ? obj['id'] : 'no-id',
        name: obj.containsKey('name') ? obj['name'] : 'no-name',
        avatarId: obj.containsKey('avatarId') ? obj['avatarId'] : 'no-avatarId',
        votedPolls: obj.containsKey('votedPolls') ? obj['votedPolls'] : [],
        myPolls: obj.containsKey('myPolls') ? obj['myPolls'] : [],
      );
}
