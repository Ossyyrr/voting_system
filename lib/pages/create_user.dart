import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/widgets/textfield_rounded.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    return Scaffold(
      // ! Si pongo el appbar se activa el provider antes de tiempo
      //      appBar: const AppBarConnection(title: 'Welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final authService = Provider.of<AuthService>(context, listen: false);
          sharedPreferencesService.userName = nameCtrl.text;
          authService.login('test5@hotmail.com', '123456');
          //  Navigator.pushReplacementNamed(context, 'home');

          //  authService.autenticando
          //     ? () => {}
          //     : () async {
          //         FocusScope.of(context).unfocus();

          //         final loginOk = await authService.login(
          //             emailCtrl.text.trim(), passCtrl.text.trim());

          //         if (loginOk) {
          //           socketServie.connect();
          //           Navigator.pushReplacementNamed(context, 'usuarios');
          //         } else {
          //           // Mostara alerta
          //           mostrarAlerta(context, 'Login incorrecto',
          //               'Revise sus credenciales nuevamente');
          //         }
          //       },
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
              TextFieldRounded(
                icon: Icons.mail_outline,
                placeholder: 'Name',
                textController: nameCtrl,
              ),
              TextFieldRounded(
                icon: Icons.mail_outline,
                placeholder: 'Correo',
                keyboardType: TextInputType.emailAddress,
                textController: emailCtrl,
              ),
              TextFieldRounded(
                icon: Icons.lock_outline,
                placeholder: 'Contraseña',
                textController: passCtrl,
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
