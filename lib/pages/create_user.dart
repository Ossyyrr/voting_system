import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);
    final textController = TextEditingController();

    return Scaffold(
      // ! Si pongo el appbar se activa el provider antes de tiempo
      //      appBar: const AppBarConnection(title: 'Welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final authService = Provider.of<AuthService>(context, listen: false);
          sharedPreferencesService.userName = textController.text;
          authService.login('test5@hotmail.com', '123456');
          //  Navigator.pushReplacementNamed(context, 'home');
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
              ),
              const Text('NAME '),
              TextField(
                controller: textController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
