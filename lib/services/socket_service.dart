import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  final ServerStatus _serverStatus = ServerStatus.Connecting;
  get serverStatus => _serverStatus;
  SocketService() {
    initConfig();
  }

  void initConfig() async {
    // Dart client
    String socketUrl = Platform.isAndroid ? 'http://192.168.1.134:3000' : 'http://localhost:3000';
    print('init config');

    IO.Socket socket = IO.io(
        'http://192.168.1.134:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .build());

    socket.onConnect((_) {
      print('connect');
      socket.emit('mensaje', 'test desde flutter');
    });

    //socket.on('event', (data) => print(data));
    socket.onDisconnect((_) {
      print('disconnect');
    });
    //socket.on('fromServer', (_) => print(_));
  }
}
