import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/pages/create_user.dart';
import 'package:voting_system/pages/home.dart';
import 'package:voting_system/services/shared_preferences_service.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);

    if (sharedPreferencesService.userName == 'no-name') {
      return const CreateUserPage();
    } else {
      return const HomePage();
    }
  }
}
