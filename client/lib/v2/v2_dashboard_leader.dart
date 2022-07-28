import 'package:flutter/material.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_template_dashboard.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_val.dart';

class V2DashboardLeader extends StatelessWidget {
  const V2DashboardLeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(V2Val.user.val.toString()),
        Flexible(
          child: V2TemplateDashboard(
            body: Container(
              width: Get.width,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Accept,  menerima dan akan dilanjutkan ke moderator ( user ayu)",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Reject,  menolak dan akan ditolak / sudah terselesaikan",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Approve, menerima dan akan diterima dilanjutkan ke adamin ( user ahmad )",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
