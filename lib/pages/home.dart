import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/poll.dart';
import 'package:voting_system/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll> polls = [];

  @override
  void initState() {
    print('HOME PAGE');

    final socketService = Provider.of<SocketService>(context, listen: false);
    // Al establecer la conexión:
    socketService.socket.on('polls', _handleActiveOptions);

    super.initState();
  }

  _handleActiveOptions(dynamic payload) {
    print('Polls');
    print(payload);

    polls = (payload as List).map((option) => Poll.fromMap(option)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text('My polls'),
              Expanded(
                child: ListView.builder(
                  itemCount: polls.length,
                  itemBuilder: (context, index) => PollTile(poll: polls[index]),
                ),
              ),
              const Text('My votes'),
            ],
          ),
        ),
      ),
    );
  }
}

class PollTile extends StatelessWidget {
  const PollTile({
    Key? key,
    required this.poll,
  }) : super(key: key);
  final Poll poll;
  @override
  Widget build(BuildContext context) {
    return const Text('data');
    // return Dismissible(
    //   key: Key(poll.id),
    //   direction: DismissDirection.startToEnd,
    //   onDismissed: (_) {},
    //   background: Container(
    //     color: Colors.red,
    //     alignment: Alignment.centerLeft,
    //     padding: const EdgeInsets.all(12),
    //     child: const Text(
    //       'Borrar',
    //       style: TextStyle(color: Colors.white, fontSize: 12),
    //     ),
    //   ),
    //   child: ListTile(
    //     leading: CircleAvatar(
    //       child: Text(poll.title.substring(0, 2)),
    //       backgroundColor: Colors.blue[100],
    //     ),
    //     title: Text(poll.title),
    //     trailing: const Text(
    //       'poll.votes.toString()',
    //       style: TextStyle(fontSize: 20),
    //     ),
    //     onTap: () {},
    //   ),
    // );
  }
}
