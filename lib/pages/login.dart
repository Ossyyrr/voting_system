import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/widgets/textfield_rounded.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    return Scaffold(
      // ! Si pongo el appbar se activa el provider antes de tiempo
      //      appBar: const AppBarConnection(title: 'Welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: authService.isAuthenticating
            ? null
            : () async {
                //final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
                final loginOk = await authService.login('test1@hotmail.com', '123456');
                FocusScope.of(context).unfocus();
                if (loginOk == true) {
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(loginOk),
                  ));
                }
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
              const Text('LOGIN'),
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
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                child: const Text('Registrarse'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
