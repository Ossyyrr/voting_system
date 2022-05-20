import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;
  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    initConfig();
  }

  void initConfig() {
    print('INIT CONFIG');
    // Dart client
    // TODO URL
    // String socketUrl = 'https://voting-system-ossyyrr.herokuapp.com/';
    String socketUrl = Platform.isAndroid ? 'http://192.168.1.134:3000' : 'http://localhost:3000';
    print('init config');

    _socket = IO.io(
        socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            //   .enableForceNew()
            .setExtraHeaders({
              'datos': 'mis datos',
            })
            .build());

    // _socket
    //   ..disconnect()
    //   ..connect();

    _socket.onConnect((_) {
      print('connect');
      //  _socket.emit('connect', 'cliente de flutter conectado');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      print('disconnect flutter');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //socket.on('event', (data) => print(data));
    //socket.on('fromServer', (_) => print(_));
  }
}
