import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_probus/regitter_page.dart';

import 'homes/home_page.dart';
import 'login_page.dart';
import 'root_page.dart';

class Routes {
  String _key = "";

  Routes.root() : _key = "/";
  Routes.login() : _key = "/login";
  Routes.register() : _key = "/register";
  Routes.home() : _key = "/home";

  static final listRoute = [
    GetPage(name: Routes.root()._key, page: () => RootPage()),
    GetPage(name: Routes.login()._key, page: () => LoginPage()),
    GetPage(name: Routes.register()._key, page: () => RegisterPage()),
    GetPage(name: Routes.home()._key, page: () => HomePage()),
  ];

  go() => Get.toNamed(_key);
  goOff() => Get.offNamed(_key);
}
