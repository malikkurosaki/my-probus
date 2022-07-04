import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/skt.dart';
import 'package:my_probus/v2/v2_404.dart';
import 'package:my_probus/v2/v2_config.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'root_page.dart';

void main() {
  IO.Socket socket = IO.io(V2Config.host);
  socket.onConnect(
    (_) {
      Skt.onConnect(socket);
      // debugPrint('connect');
      // socket.emit('msg', 'test');
    },
  );
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));

  GetStorage.init();
  runApp(V2MainApp());
}

class V2MainApp extends StatelessWidget {
  const V2MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Probus',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/root",
      debugShowCheckedModeBanner: false,
      getPages: V2Routes.all,
      defaultTransition: Transition.noTransition,
      builder: EasyLoading.init(),
      unknownRoute: GetPage(
        name: '/unknown',
        page: () => V2404(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Probus',
      initialRoute: '/',
      defaultTransition: Transition.noTransition,
      getPages: Routes.listRoute,
      builder: EasyLoading.init(),
      home: DoubleBack(child: RootPage()),
    );
  }
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
