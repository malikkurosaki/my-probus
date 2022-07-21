
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'v2/v2_404.dart';
import 'v2/v2_load.dart';
import 'v2/v2_routes.dart';
import 'v2/v2_sound.dart';
import 'package:http/http.dart' as http;
import 'package:sse/client/sse_client.dart';


void main() async {
  debugPrint("load sound");
  await V2Sound.init();
  debugPrint("load sound done");

  debugPrint("load storage");
  await GetStorage.init();
  debugPrint("load storage done");
  debugPrint("load properties");
  await V2Load.propertiesAll();
  debugPrint("load properties done");
  debugPrint("run");

  // final sse = SseClient("http://localhost:3001/sse");
  

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
