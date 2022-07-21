import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'v2_image_widget.dart';

class V2History extends StatelessWidget {
  V2History({Key? key}) : super(key: key);
  final _listHistory = [].obs;

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => Row(
        children: [
          Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(
                        onPressed: () => Get.toNamed(V2Routes.home().key),

                      ),
                      V2ImageWidget.logo(),
                    ],
                  ),
                ),
                for (final ls in V2Val.listStatus.value.val)
                  ListTile(
                    title: Text(ls['name'].toString().toUpperCase()),
                    onTap: () async {
                      final data = await V2Api.issueHistory().getByParams(ls['id'].toString());
                      _listHistory.assignAll(List.from(jsonDecode(data.body)));
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView(
                children: [
                  Text("ini dimana"),
                  Text(_listHistory.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
