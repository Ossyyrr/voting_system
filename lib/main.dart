import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/pages/create_room.dart';
import 'package:voting_system/pages/votation.dart';
import 'package:voting_system/pages/welcome.dart';
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
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'welcome',
        routes: {
          'create': (_) => const CreateRoomPage(),
          'welcome': (_) => WelcomePage(),
          'votation': (_) => const VotationPage(),
        },
        home: const VotationPage(),
      ),
    );
  }
}
