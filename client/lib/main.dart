import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/root_page.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/skt.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  // IO.Socket socket = IO.io(Conn().host);
  // socket.onConnect(
  //   (_) {
  //     Skt.onConnect(socket);
  //     // debugPrint('connect');
  //     // socket.emit('msg', 'test');
  //   },
  // );
  // socket.on('event', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));

  GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Probus',
      initialRoute: '/',
      defaultTransition: Transition.noTransition,
      getPages: Routes.listRoute,
      builder: EasyLoading.init(),
      home: DoubleBack(child: RootPage()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Probus',
        initialRoute: '/',
        defaultTransition: Transition.noTransition,
        getPages: Routes.listRoute,
        builder: EasyLoading.init(),
      );
}
