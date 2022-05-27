import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/option.dart';
import 'package:voting_system/models/poll.dart';
import 'package:voting_system/services/socket_service.dart';
import 'package:voting_system/widgets/appbar_connection.dart';
import 'package:voting_system/widgets/dialog_platform.dart';
import 'package:voting_system/widgets/graph.dart';

class PollPage extends StatelessWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    Poll poll = socketService.poll;

    return Scaffold(
      appBar: AppBarConnection(title: poll.title),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: () => addNewOption(poll, context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Graph(options: poll.options),
          ),
          const Text('Options'),
          Expanded(
            child: ListView.builder(
              itemCount: poll.options.length,
              itemBuilder: (context, index) =>
                  _optionTile(pollId: poll.id, option: poll.options[index], context: context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile({
    required Option option,
    required String pollId,
    required BuildContext context,
  }) {
    // ! Mantener este widget como Widget Function para que se refresque al recibir emisiones del back
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(option.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        //TODO
      }, //=> socketService.emit('delete-option', {'id': option.id}),
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
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(option.title.substring(0, 2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(option.title),
            trailing: Text(
              option.votes.toString(),
              style: const TextStyle(fontSize: 20),
            ),
            onTap: () {
              socketService.emit('vote-option', {'pollId': pollId, 'optionId': option.id});

              print('option.id *******');
              print(option.id);
              print(option);
            },
          ),
          Container(
            color: Colors.red,
            child: const Text('PA'),
          )
        ],
      ),
    );
  }

  addNewOption(Poll poll, BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    final textController = TextEditingController();
    DialogPlatfom.showDialogPlatform(
      context: context,
      textController: textController,
      onPressed: () => {
        socketService.emit('add-option', {'pollId': poll.id, 'optionName': textController.text}),
        Navigator.pop(context),
      },
      title: 'title',
    );
  }
}
