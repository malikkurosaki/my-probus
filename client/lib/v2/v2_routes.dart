import 'package:get/route_manager.dart';
import 'package:my_probus/v2/v2_root_view.dart';

import 'v2_home_view.dart';
import 'v2_login_view.dart';

class V2Routes{
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';

  static List <GetPage> listRoute = <GetPage>[
    GetPage(
      name: root,
      page: () => V2RootView(),
    ),
    GetPage(
      name: login,
      page: () => V2LoginView(),
    ),
    GetPage(
      name: home,
      page: () => V2HomeView(),
    ),

  ];
}