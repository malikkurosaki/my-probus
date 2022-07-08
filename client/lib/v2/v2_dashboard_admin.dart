import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/skt.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:my_probus/v2/v2_template_dashboard.dart';
import 'v2_ismobile_widget.dart';
import 'v2_load.dart';
import 'v2_routes.dart';
import 'v2_val.dart';
import 'package:timeago/timeago.dart' as timeago;

class V2DashboardAdmin extends StatelessWidget {
  const V2DashboardAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2TemplateDashboard()
    ;
  }
}
