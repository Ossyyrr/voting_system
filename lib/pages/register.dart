import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/widgets/textfield_rounded.dart';

class RegistrerPage extends StatelessWidget {
  const RegistrerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    return Scaffold(
      // ! Si pongo el appbar se activa el provider antes de tiempo
      //      appBar: const AppBarConnection(title: 'Welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: authService.isAuthenticating
            ? null
            : () async {
                //   final loginOk=   authService.login(nameCtrl.text,emailCtrl.text.trim(), passCtrl.text.trim());
                final loginOk = await authService.register('pepe', 'test1@hotmail.com', '123456');
                FocusScope.of(context).unfocus();
                if (loginOk == true) {
                  sharedPreferencesService.userName = nameCtrl.text;

                  Navigator.pushReplacementNamed(context, 'home');
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(loginOk),
                ));
              },
        child: authService.isAuthenticating
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : const Icon(Icons.arrow_forward_ios),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Registro'),
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
              TextButton(onPressed: () => Navigator.pushReplacementNamed(context, 'login'), child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
