import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/models/band.dart';
import 'package:voting_system/services/socket_service.dart';
import 'package:voting_system/widgets/dialog_platform.dart';
import 'package:voting_system/widgets/graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    print('HOME PAGE');

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);

    super.initState();
  }

  _handleActiveBands(dynamic payload) {
    print('active-bands ****');
    print(payload);
    if ((payload is Map) && payload.containsKey('exist-room') && !payload['exist-room']) {
      print('LA SALA NO EXISTE');
    } else {
      bands = (payload as List).map((band) => Band.fromMap(band)).toList();
      setState(() {});
    }
  }

  // @override
  // void dispose() {
  //   final socketService = Provider.of<SocketService>(context, listen: false);
  //   socketService.socket.off('active-bands');
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Graph(bands: bands),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, index) => _bandTile(bands[index]),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          elevation: 1,
          onPressed: addNewBand,
        ));
  }

  Widget _bandTile(Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => socketService.emit('delete-band', {'id': band.id}),
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
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => socketService.emit('vote-band', {'id': band.id}),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    DialogPlatfom.showDialogPlatform(
        context: context,
        textController: textController,
        onPressed: () => addBandToList(textController.text),
        title: 'title');
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }
}
