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
  // TODO _existRoom
  bool _existRoom = true;
  ServerStatus get serverStatus => _serverStatus;
  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
  bool get existRoom => _existRoom;

  SocketService() {
    // initConfig();
  }

  void initConfig(String sala) {
    // Dart client
    // TODO URL
    // String socketUrl = 'https://voting-system-ossyyrr.herokuapp.com/';
    String socketUrl = Platform.isAndroid ? 'http://192.168.1.134:3000' : 'http://localhost:3000';
    print('init config');

    _socket = IO.io(
        socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .setExtraHeaders({
              'foo': 'bar',
              'sala': sala,
            })
            .build());

    _socket.onConnect((_) {
      print('connect');
      _socket.emit('mensaje', 'cliente de flutter conectado');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    _socket.on('exist-room', (payload) {
      print('exist-room');
      print(payload);
      _existRoom = payload['exist-room'];
      notifyListeners();
      print(_existRoom);
    });

    print('_existRoom');
    print(_existRoom);

    //socket.on('event', (data) => print(data));
    //socket.on('fromServer', (_) => print(_));
  }
}
