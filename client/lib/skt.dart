import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:my_probus/v2/v2_sound.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'v2/v2_config.dart';

class Skt {
  static final IO.Socket socket = IO.io("${V2Config.host}/notif");

  // static final skt = SocketIOClient(
  //   'http://localhost:3000',
  //   transports: [Transports.WEB_SOCKET],
  //   enableLog: true,
  //   autoConnect: false,
  // );

  static init()async{
    socket.onConnect((data) => {
      onConnect(socket)
    });
  }

  static onConnect(socket) {
    //debugPrint('connect');
    // socket.emit('msg', 'test');
    socket.off("server");
    socket.on("server", (data) async {
      debugPrint('server: $data');
      await V2Sound.playNotif();
      GetSnackBar(
        message: data['content'].toString(),
        title: "${data['title']} By : ${data['User']['name']}",
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        icon: Icon(
          Icons.notifications_active,
          color: Colors.cyan,
        ),
        onTap: (value) {},
      ).show();
    });
  }

  static notifWithIssue(
      {required String title, required String content, required String jenis}) {
    final dataNotif = {
      "usersId": V2Val.user.val['id'],
      "title": title,
      "content": content,
      "jenis": jenis,
    };
    Skt.socket.emit("client", dataNotif);
  }
}
