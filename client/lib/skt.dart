import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Skt{

  static onConnect(Socket socket){
    debugPrint('connect');
    socket.emit('msg', 'test');
  }


}