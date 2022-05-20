import 'package:voting_system/models/Option.dart';

class Poll {
  String id;
  String title;
  String creatorId;
  List<Option> options;
  bool isEditable;
  DateTime endDate;
  bool isMultipleChoice;
  bool isPrivateVote;

  Poll({
    required this.id,
    required this.title,
    required this.creatorId,
    required this.options,
    required this.isEditable,
    required this.endDate,
    required this.isMultipleChoice,
    required this.isPrivateVote,
  });

  factory Poll.fromMap(Map<String, dynamic> obj) => Poll(
        id: obj.containsKey('id') ? obj['id'] : 'no-id',
        title: obj.containsKey('title') ? obj['title'] : 'no-title',
        creatorId: obj.containsKey('creatorId') ? obj['creatorId'] : 'no-creatorId',
        options: obj.containsKey('options') ? obj['options'] : [],
        isEditable: obj.containsKey('isEditable') ? obj['isEditable'] : 'no-isEditable',
        endDate: obj.containsKey('endDate') ? obj['endDate'] : 'no-endDate',
        isMultipleChoice: obj.containsKey('isMultipleChoice') ? obj['isMultipleChoice'] : 'no-isMultipleChoice',
        isPrivateVote: obj.containsKey('isPrivateVote') ? obj['isPrivateVote'] : 'no-isPrivateVote',
      );
}
