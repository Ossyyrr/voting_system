import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/pages/create_poll.dart';
import 'package:voting_system/pages/create_user.dart';
import 'package:voting_system/pages/home.dart';
import 'package:voting_system/pages/poll.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/services/socket_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => SharedPreferencesService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'create-user',
        routes: {
          'create-user': (_) => const CreateUserPage(),
          'home': (_) => const HomePage(),
          'poll': (_) => const PollPage(),
          'create-poll': (_) => const CreatePollPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
