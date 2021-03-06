class Option {
  String id;
  String title;
  int votes;
  List<String> votedBy;

  Option({
    required this.id,
    required this.title,
    required this.votes,
    required this.votedBy,
  });

  factory Option.fromMap(Map<String, dynamic> obj) => Option(
        id: obj.containsKey('id') ? obj['id'] : 'no-id',
        title: obj.containsKey('title') ? obj['title'] : 'no-title',
        votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes',
        votedBy: obj.containsKey('votedBy') ? obj['votedBy'].cast<String>() : [],
      );
}
