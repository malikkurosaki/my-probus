import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'v2_image_widget.dart';

class V2IssueHistory extends StatelessWidget {
  V2IssueHistory({Key? key}) : super(key: key);
  final _listHistory = [].obs;

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => Column(
        children: [
          Row(
            children: [
              BackButton(
                onPressed: () => Get.toNamed(V2Routes.home().key),
              ),
            ],
          ),
          Flexible(
            child: Container(
              color: Colors.grey[100],
              child: Row(
                children: [
                  Visibility(
                    visible: !isMobile,
                    child: Drawer(
                      elevation: 0,
                      child: ListView(
                        children: [
                          DrawerHeader(
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                V2ImageWidget.logo(),
                              ],
                            ),
                          ),
                          for (final ls in V2Val.listStatus.value.val)
                            ListTile(
                              title: Text(ls['name'].toString().toUpperCase()),
                              onTap: () async {

                                
                                EasyLoading.showInfo("loading...");
                                final data = await V2Api.issueHistory().getByParams(ls['id'].toString());
                                _listHistory.assignAll(List.from(jsonDecode(data.body)));
                                EasyLoading.dismiss();


                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView(
                        children: [
                          // Text("ini dimana"),
                          // Text(_listHistory.toString()),
                          for (final item in _listHistory)
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(item['createdAt']))),
                                    Text(item['IssueStatus']['name'].toString().toUpperCase()),
                                    Text(item['Issue']['name'].toString().toUpperCase()),
                                    Text(item['User']['name'].toString().toUpperCase()),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isDesktop ,
                    child: Drawer(
                      elevation: 0,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Note"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
