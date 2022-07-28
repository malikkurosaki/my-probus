import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_dev_client.dart';
import 'package:my_probus/v2/v2_dev_departement.dart';
import 'package:my_probus/v2/v2_dev_issue_status.dart';
import 'package:my_probus/v2/v2_dev_issue_type.dart';
import 'package:my_probus/v2/v2_dev_role.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'v2_dev_user.dart';
import 'v2_image_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class V2DevDevelopment extends StatelessWidget {
  const V2DevDevelopment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class V2Developer extends StatelessWidget {
  V2Developer({Key? key}) : super(key: key);
  final _index = 0.val("index").obs;

  final _listMenu = [
    {"name": "user", "target": V2DevUser()},
    {"name": "departement", "target": V2DevDepartement()},
    {"name": "role", "target": V2DevRole()},
    {"name": "Client", "target": V2DevClient()},
    {"name": "issue type", "target": V2DevIssueType()},
    {"name": "issue status", "target": V2DevIssueStatus()},
  ];

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              BackButton(
                onPressed: () => Get.toNamed(V2Routes.home().key),
              ),
              Text("Developer")
            ],
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !isMobile,
                  child: Drawer(
                    elevation: 0,
                    child: Obx(
                      () => ListView(
                        children: [
                          DrawerHeader(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                V2ImageWidget.logo(),
                              ],
                            ),
                          ),
                          for (final itm in _listMenu)
                            ListTile(
                              selected: _index.value.val == _listMenu.indexOf(itm),
                              title: Text(itm['name'].toString().toUpperCase()),
                              onTap: () {
                                _index.value.val = _listMenu.indexOf(itm);
                                _index.refresh();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.grey[100],
                    child: Obx(
                      () => IndexedStack(
                        index: _index.value.val,
                        children: [
                          ..._listMenu.map((itm) => itm['target'] as Widget),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    // final datanya = List.from(V2Val.listIssueDashboard.value.val);
    // var ini = {};
    // try {
    //   ini = groupBy(List<Map>.from(datanya), (x) => jsonDecode(jsonEncode(x))["Client"]['name']).map(
    //     (key, value) => MapEntry(
    //       key,
    //       groupBy(value, (x) => jsonDecode(jsonEncode(x))["Product"]['name'])
    //           .map(
    //             (key, value) => MapEntry(key, value),
    //           )
    //           .map(
    //               (key, value) => MapEntry(key, groupBy(value, (x) => jsonDecode(jsonEncode(x))['IssueType']['name']))),
    //     ),
    //   );

    //   print(ini);
    // } catch (e) {
    //   print(e);
    // }

    // return V2IsMobileWidget(
    //   isMobile: (isMobile, isTablet, isDesktop) => ListView(
    //     children: [
    //       Text("data"),
    //       Text(JsonEncoder.withIndent("    ").convert(ini)),
    //       Divider(),
    //       for (final client in ini.keys)
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 client.toString(),
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               for (final product in ini[client].keys)
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       product.toString(),
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     for (final issueType in ini[client][product].keys)
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 SizedBox(width: 100, child: Text("Type ")),
    //                                 Expanded(child: Text(issueType.toString())),
    //                               ],
    //                             ),
    //                             for (final issue in ini[client][product][issueType])
    //                               Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 children: [
    //                                   Row(
    //                                     children: [
    //                                       SizedBox(width: 100, child: Text("Title")),
    //                                       Expanded(child: Text(issue['name'].toString())),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       SizedBox(width: 100, child: Text("Description")),
    //                                       Expanded(child: Text(issue['des'].toString())),
    //                                     ],
    //                                   ),
    //                                 ],
    //                               ),
    //                           ],
    //                         ),
    //                       ),
    //                   ],
    //                 ),
    //                 Divider()
    //             ],
    //           ),
    //         )
    //     ],
    //   ),
    // );
  }
}
