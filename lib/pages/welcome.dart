import 'package:flutter/material.dart';
import 'package:voting_system/widgets/appbar_connection.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: const AppBarConnection(title: 'Welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
        child: const Icon(Icons.arrow_forward_ios),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 50,
              ),
              Text('NAME '),
              TextField(),
              // const Spacer(),
              // const Text('Entrar en Sala: '),
              // const TextField),
              // MaterialButton(
              //   onPressed: () async {
              //     print('TEXTO:     ' + textController.text);
              //     final socketService = Provider.of<SocketService>(context, listen: false);
              //     socketService.initConfig(textController.text);

              //     Navigator.pushNamed(context, 'votation');
              //   },
              //   child: const Text('ENTRAR'),
              //   textColor: Colors.blue,
              // ),
              // const Spacer(),
              // ElevatedButton(
              //   onPressed: () {
              //     final socketService = Provider.of<SocketService>(context, listen: false);

              //     socketService.initConfig('no-sala');

              //     Navigator.pushNamed(context, 'create');
              //   },
              //   child: const Text('CREAR SALA'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
