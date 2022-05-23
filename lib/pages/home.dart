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
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    List<Poll> polls = socketService.polls;

    return Scaffold(
      appBar: const AppBarConnection(title: 'Polls'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: () => addNewPoll(socketService.deviceId),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: polls.length,
                  itemBuilder: (context, index) => _pollTile(polls[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pollTile(Poll poll) {
    final socketService = Provider.of<SocketService>(context);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(poll.title.substring(0, 1)),
              backgroundColor: Colors.blue[100],
            ),
            trailing: (socketService.deviceId == poll.creatorId)
                ? const Text(
                    'Creator',
                    style: TextStyle(fontSize: 12),
                  )
                : const SizedBox(),
            title: Text(poll.title),
            onTap: () async {
              socketService.emit('join-poll', {'pollId': poll.id});
              socketService.poll = poll;
              await Navigator.pushNamed(context, 'poll');
              socketService.emit('leave-poll', {'pollId': poll.id});
            },
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              ..._activeUsers(poll),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _activeUsers(Poll poll) {
    List<Widget> listActiveUsers = [];
    for (var user in poll.activeUsers) {
      listActiveUsers.add(Transform.scale(
        scale: 1.4,
        child: CircleAvatar(
          radius: 8,
          child: Text(
            user.name.substring(0, 2),
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ));
    }

    return listActiveUsers;
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
