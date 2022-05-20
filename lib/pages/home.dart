import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/poll.dart';
import 'package:voting_system/services/socket_service.dart';
import 'package:voting_system/widgets/appbar_connection.dart';
import 'package:voting_system/widgets/dialog_platform.dart';

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
    print('polls **************');
    print(polls);
    return Scaffold(
      appBar: const AppBarConnection(title: 'Home'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: () => addNewPoll('UserIdXXX'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text('My polls'),
              Expanded(
                child: ListView.builder(
                  itemCount: polls.length,
                  itemBuilder: (context, index) => _pollTile(polls[index]),
                ),
              ),
              const Text('My votes'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pollTile(Poll poll) {
    return Dismissible(
      key: Key(poll.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        //TODO
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(12),
        child: const Text(
          'Borrar',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(poll.title.substring(0, 1)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(poll.title),
        onTap: () => Navigator.pushNamed(context, 'poll', arguments: poll),
      ),
    );
  }

  addNewPoll(String userId) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    final textController = TextEditingController();
    DialogPlatfom.showDialogPlatform(
      context: context,
      textController: textController,
      onPressed: () => {
        socketService.emit('add-poll', {'creatorId': userId, 'pollName': textController.text}),
        Navigator.pop(context),
      },
      title: 'Add New Poll',
    );
  }
}
