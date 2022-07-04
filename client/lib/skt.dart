import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Skt{

  static onConnect(Socket socket){
    GetSnackBar(icon: Icon(Icons.abc), title: "Apa ini",);
    debugPrint('connect');
    socket.emit('msg', 'test');

    socket.on("issue", (data) {
      debugPrint(data);

    });

    
  }


}