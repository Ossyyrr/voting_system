import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:voting_system/global/enviroments.dart';
import 'package:voting_system/models/option.dart';
import 'package:voting_system/models/poll.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;

  late IO.Socket _socket;
  late List<Poll> _polls = [];
  late Poll _poll;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
  List<Poll> get polls => _polls;
  Poll get poll => _poll;

  set polls(List<Poll> polls) {
    _polls = polls;
    notifyListeners();
  }

  set poll(Poll poll) {
    _poll = poll;
    notifyListeners();
  }

  SocketService() {
    //   initConfig();
  }

  void initConfig(String userID) {
    print('INIT CONFIG');

    _socket = IO.io(
        Enviroment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            //   .enableForceNew()
            .setExtraHeaders({
              'datos': 'mis datos',
              'userid': userID, // TODO Pasar getDeviceId a sharedPreferenceService y usarlo aki
            })
            .build());

    _socket.onConnect((_) {
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //socket.on('event', (data) => print(data));
    //socket.on('fromServer', (_) => print(_));

    _socket.on('active-options', (dynamic payload) {
      _poll.options = (payload as List).map((option) => Option.fromMap(option)).toList();
      notifyListeners();
    });

    _socket.on('polls', (dynamic payload) {
      _polls = (payload as List).map((option) => Poll.fromMap(option)).toList();
      notifyListeners();
    });
  }
}
