import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/services/socket_service.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);

    // TODO Cambiar initConfig a la home??
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.initConfig(sharedPreferencesService.deviceId);

    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return const Center(
              child: Text('Cargando'),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final isAuth = await authService.isLoggedIn(sharedPreferencesService.token);
    print('isAuth: ' + isAuth.toString());
    if (isAuth) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
