import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/Option.dart';
import 'package:voting_system/services/socket_service.dart';
import 'package:voting_system/widgets/dialog_platform.dart';

// TODO Borrar pagina, no se usa

class VotationPage extends StatefulWidget {
  const VotationPage({Key? key}) : super(key: key);

  @override
  State<VotationPage> createState() => _VotationPageState();
}

class _VotationPageState extends State<VotationPage> {
  List<Option> options = [];

  @override
  void initState() {
    print('HOME PAGE');

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-options', _handleActiveOptions);

    super.initState();
  }

  _handleActiveOptions(dynamic payload) {
    print('active-options ****');
    print(payload);
    if ((payload is Map) && payload.containsKey('exist-room') && !payload['exist-room']) {
      print('LA SALA NO EXISTE');
    } else {
      options = (payload as List).map((option) => Option.fromMap(option)).toList();
      setState(() {});
    }
  }

  // @override
  // void dispose() {
  //   final socketService = Provider.of<SocketService>(context, listen: false);
  //   socketService.socket.off('active-options');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.blue[300],
          elevation: 1,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.Online
                  ? Icon(Icons.check_circle, color: Colors.blue[300])
                  : Icon(Icons.offline_bolt, color: Colors.red[300]),
            )
          ],
          centerTitle: true,
          title: const Text(
            'Votación',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: Graph(options: options),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) => _optionTile(options[index]),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          elevation: 1,
          onPressed: addNewOption,
        ));
  }

  Widget _optionTile(Option option) {
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

  addNewOption() {
    final textController = TextEditingController();
    DialogPlatfom.showDialogPlatform(
        context: context,
        textController: textController,
        onPressed: () => addOptionToList(textController.text),
        title: 'title');
  }

  void addOptionToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-option', {'name': name});
    }
    Navigator.pop(context);
  }
}
