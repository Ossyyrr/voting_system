import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return const Center(
              child: Text(
                'Utilizamos servidores gratuitos, por favor, aguarde unos segundos...',
                textAlign: TextAlign.center,
              ),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      final isAuth = await authService.isLoggedIn(sharedPreferencesService.token);
      print('isAuth: ' + isAuth.toString());
      if (isAuth) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } catch (e) {
      Future.delayed(const Duration(seconds: 2), () async {
        print('2 seconds.');
        await checkLoginState(context);
      });
    }
  }
}
