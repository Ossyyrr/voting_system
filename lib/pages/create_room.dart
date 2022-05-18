import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear sala')),
      body: const Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
