import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'skt.dart';
import 'v2/v2_404.dart';
import 'v2/v2_routes.dart';
import 'v2/v2_sound.dart';

void main() {
  V2Sound.init();
  Skt.init();
  // Skt.socket.onConnect(
  //   (_) {
  //     Skt.onConnect(Skt.socket);
  //     // debugPrint('connect');
  //     // socket.emit('msg', 'test');
  //   },
  // );


print("ini ada ddimana");

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

// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My Probus',
//       initialRoute: '/',
//       defaultTransition: Transition.noTransition,
//       getPages: Routes.listRoute,
//       builder: EasyLoading.init(),
//       home: DoubleBack(child: RootPage()),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp();
}
