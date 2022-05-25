import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';

  // TODO URL
  static String socketUrl = Platform.isAndroid ? 'http://192.168.1.134:3000' : 'http://localhost:3000';
  //String socketUrl = 'https://voting-system-ossyyrr.herokuapp.com/';

}
