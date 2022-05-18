import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/socket_service.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('NAME '),
              // TextField(),
              const Text('Entrar en Sala: '),
              TextField(
                controller: textController,
              ),

              MaterialButton(
                onPressed: () async {
                  print('TEXTO:     ' + textController.text);
                  final socketService = Provider.of<SocketService>(context, listen: false);
                  socketService.initConfig(textController.text);

                  Navigator.pushNamed(context, 'votation');
                },
                child: const Text('ENTRAR'),
                textColor: Colors.blue,
              ),
              Container(
                width: 370,
                height: 10,
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
              ElevatedButton(
                onPressed: () {
                  final socketService = Provider.of<SocketService>(context, listen: false);

                  socketService.initConfig('no-sala');

                  Navigator.pushNamed(context, 'create');
                },
                child: const Text('CREAR SALA'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
