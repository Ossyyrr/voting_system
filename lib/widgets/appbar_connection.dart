import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system/services/shared_preferences_service.dart';
import 'package:voting_system/services/socket_service.dart';

class AppBarConnection extends StatelessWidget implements PreferredSizeWidget {
  const AppBarConnection({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Color backgroundColor = Colors.red;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final sharedPreferencesService = Provider.of<SharedPreferencesService>(context);

    return AppBar(
      foregroundColor: Colors.black87,
      // elevation: 1,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: socketService.serverStatus == ServerStatus.Online
              ? Icon(Icons.check_circle, color: Colors.blue[300])
              : Icon(Icons.connecting_airports_rounded, color: Colors.red[300]),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          child: Text(sharedPreferencesService.userName.substring(0, 2)),
        ),
      ),

      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black87),
      ),
      //  backgroundColor: Colors.white,
    );
  }
}
