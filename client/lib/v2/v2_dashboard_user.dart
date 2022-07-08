import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/v2/v2_role.dart';
import 'package:my_probus/v2/v2_template_dashboard.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'v2_ismobile_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'v2_load.dart';
import 'v2_routes.dart';

class V2DashboardUser extends StatelessWidget {
  const V2DashboardUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2TemplateDashboard();
  }
}
