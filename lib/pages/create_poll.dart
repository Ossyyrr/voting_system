import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:voting_system/services/socket_service.dart';

class CreatePollPage extends StatefulWidget {
  const CreatePollPage({Key? key}) : super(key: key);

  @override
  State<CreatePollPage> createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  String roomId = '';
  final textController = TextEditingController();
  final roomIdController = TextEditingController();

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on(
      'new-votation-page',
      (payload) => {
        print(payload),
        roomId = payload['votationPage']['salaId'],
        roomIdController.text = roomId,
        setState(() {}),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear sala')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('titulo: '),
            TextField(
              controller: textController,
            ),
            ElevatedButton(
                onPressed: () {
                  print('CREAR');

                  final socketService = Provider.of<SocketService>(context, listen: false);
                  socketService.emit('create-room', {'title': textController.text});
                },
                child: const Text('crear')),
            TextField(
              controller: roomIdController,
              onChanged: (v) {
                // Evita que se pueda cambiar, permite copiar desde la pantalla
                roomIdController.text = roomId;
              },
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // TODO Dynamic links
                Share.share(
                  'SALA: $roomId',
                  subject: 'Look what I made!',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
