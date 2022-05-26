import 'package:voting_system/models/option.dart';
import 'package:voting_system/models/user_auth.dart';

class Poll {
  String id;
  String title;
  String creatorId;
  List<User> activeUsers;
  List<Option> options;
  bool isEditable;
  String endDate;
  bool isMultipleChoice;
  bool isPrivateVote;

  Poll({
    required this.id,
    required this.title,
    required this.creatorId,
    required this.activeUsers,
    required this.options,
    required this.isEditable,
    required this.endDate,
    required this.isMultipleChoice,
    required this.isPrivateVote,
  });

  factory Poll.fromMap(Map<String, dynamic> obj) {
    return Poll(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      title: obj.containsKey('title') ? obj['title'] : 'no-title',
      creatorId: obj.containsKey('creatorId') ? obj['creatorId'] : 'no-creatorId',
      activeUsers: obj.containsKey('activeUsers')
          ? (obj['activeUsers'] as List).map((activeUser) => User.fromMap(activeUser)).toList()
          : [],
      options:
          obj.containsKey('options') ? (obj['options'] as List).map((option) => Option.fromMap(option)).toList() : [],
      isEditable: obj.containsKey('isEditable') ? obj['isEditable'] : 'no-isEditable',
      endDate: obj.containsKey('endDate') ? obj['endDate'] : null,
      isMultipleChoice: obj.containsKey('isMultipleChoice') ? obj['isMultipleChoice'] : 'no-isMultipleChoice',
      isPrivateVote: obj.containsKey('isPrivateVote') ? obj['isPrivateVote'] : 'no-isPrivateVote',
    );
  }
}
