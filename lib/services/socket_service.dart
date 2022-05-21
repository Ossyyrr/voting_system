import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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
  late String _deviceId;
  late Poll _poll;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
  String get deviceId => _deviceId;
  Poll get poll => _poll;

  set poll(Poll poll) {
    _poll = poll;
    notifyListeners();
  }

  SocketService() {
    getDeviceId();
    initConfig();
  }

  void initConfig() {
    print('INIT CONFIG');

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
  }

  void getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final map = deviceInfo.toMap();
    if (Platform.isIOS) _deviceId = map['identifierForVendor'];
    if (Platform.isAndroid) _deviceId = 'Device id: ' + map['androidId'];
    print('DEVICE_ID: ' + _deviceId);
  }
}
