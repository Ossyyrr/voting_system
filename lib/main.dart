import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system/pages/create_poll.dart';
import 'package:voting_system/pages/home.dart';
import 'package:voting_system/pages/init.dart';
import 'package:voting_system/pages/login.dart';
import 'package:voting_system/pages/poll.dart';
import 'package:voting_system/pages/register.dart';
import 'package:voting_system/services/auth_service.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/services/socket_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // resuelve: ERROR: Binding has not yet been initialized. Producido por usar async en el main()
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: _prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.prefs}) : super(key: key);
  final SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => SharedPreferencesService(prefs)),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'init',
        routes: {
          'init': (_) => const InitPage(),
          'login': (_) => const LoginPage(),
          'register': (_) => const RegistrerPage(),
          'home': (_) => const HomePage(),
          'poll': (_) => const PollPage(),
          'create-poll': (_) => const CreatePollPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
