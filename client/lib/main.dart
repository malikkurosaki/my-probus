import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/root_page.dart';
import 'package:my_probus/routes.dart';

import 'homes/home_page.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
  GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'GetX',
    initialRoute: '/',
    defaultTransition: Transition.noTransition,
    getPages: Routes.listRoute,
    builder: EasyLoading.init(),
  );
}





