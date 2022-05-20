import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/option.dart';
import 'package:voting_system/models/poll.dart';
import 'package:voting_system/services/socket_service.dart';
import 'package:voting_system/widgets/appbar_connection.dart';
import 'package:voting_system/widgets/dialog_platform.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  @override
  Widget build(BuildContext context) {
    Poll poll = ModalRoute.of(context)!.settings.arguments as Poll;

    return Scaffold(
      appBar: AppBarConnection(title: poll.title),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewOption,
      ),
      body: Column(
        children: [
          const Text('Options'),
          Expanded(
            child: ListView.builder(
              itemCount: poll.options.length,
              itemBuilder: (context, index) => OptionTile(option: poll.options[index]),
            ),
          ),
        ],
      ),
    );
  }

  addNewOption() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    final textController = TextEditingController();
    DialogPlatfom.showDialogPlatform(
        context: context,
        textController: textController,
        onPressed: () => {
              // TODO

              socketService.emit('add-option', {'name': textController.text}),
              Navigator.pop(context),
            },
        title: 'title');
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({
    Key? key,
    required this.option,
  }) : super(key: key);

  final Option option;

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(option.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => socketService.emit('delete-option', {'id': option.id}),
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
          child: Text(option.title.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(option.title),
        trailing: Text(
          option.votes.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => socketService.emit('vote-option', {'id': option.id}),
      ),
    );
  }
}
