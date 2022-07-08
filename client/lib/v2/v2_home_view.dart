import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/v2/v2_home_detail_view.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_load.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:my_probus/v2/v2_list_menu.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class V2HomeView extends StatelessWidget {
  const V2HomeView({Key? key}) : super(key: key);

   _onLoad() async {
    await V2Val.homeControll.loadIssueDashboard();
    await V2Load.issuegetAll();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return V2IsMobileWidget(
        isMobile: (isMobile) => Scaffold(
              body: Row(
                children: [Visibility(visible: !isMobile, child: _drawer()), Expanded(child: V2Role().dashboardByRole)],
              ),
            ));
  }

  Widget _drawer() => Drawer(
        child: ListView(
          controller: ScrollController(),
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  V2ImageWidget.logo(),
                  
                ],
              ),
            ),
            for (final itm in V2Menu.all) itm,
            MaterialButton(
              color: Colors.grey.shade200,
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Get.dialog(AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    MaterialButton(
                      child: Text("Yes"),
                      onPressed: () {
                        
                        V2Val().logout();
                        Get.offAllNamed(V2Routes.root().key);
                      },
                    ),
                    MaterialButton(
                      child: Text("No"),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ));
              },
            )
          ],
        ),
      );

  // Widget _main(bool isMobile) =>
  //  ListView(
  //       controller: ScrollController(),
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               CircleAvatar(
  //                 backgroundColor: Colors.grey.shade200,
  //                 radius: 30,
  //                 child: Icon(
  //                   Icons.person,
  //                   color: Colors.cyan,
  //                   size: 30,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         V2Val.user.value.val['name'].toString(),
  //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                       ),
  //                       Text(
  //                         V2Val.user.value.val['Role']['name'].toString(),
  //                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                   onPressed: () async {
  //                     await V2Val.homeControll.loadIssueDashboard();
  //                     EasyLoading.showToast("Refreshed");
  //                   },
  //                   icon: Icon(Icons.refresh))
  //             ],
  //           ),
  //         ),
  //         Divider(
  //           color: Colors.cyan,
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(
  //                 "the issue has passed a week ago",
  //                 style: TextStyle(
  //                   fontSize: 24,
  //                 ),
  //               ),
  //             ),
  //             Card(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text("Date Is Empty"),
  //               ),
  //             )
  //           ],
  //         ),
  //         Divider(),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             "Need Your Handling",
  //             style: TextStyle(fontSize: 24, color: Colors.black),
  //           ),
  //         ),
  //         Obx(
  //           () => Column(
  //             children: [
  //               // Text(V2Val.homeControll.listIssueDashboard.value.val.toString()),
  //               Wrap(
  //                 children: [
  //                   for (final itm in V2Val.homeControll.listIssueDashboard.value.val)
  //                     SizedBox(
  //                       width: Get.width / (isMobile ? 0 : 3),
  //                       child: Card(
  //                         elevation: 0,
  //                         child: Column(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Column(
  //                                     children: [
  //                                       CircleAvatar(
  //                                         backgroundColor: Colors.grey.shade200,
  //                                         radius: 30,
  //                                         child: Text(itm['idx'].toString()),
  //                                       ),
  //                                       Padding(
  //                                         padding: const EdgeInsets.all(8.0),
  //                                         child: Text("Id Issue"),
  //                                       )
  //                                     ],
  //                                   ),
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(8.0),
  //                                       child: Column(
  //                                         mainAxisAlignment: MainAxisAlignment.start,
  //                                         crossAxisAlignment: CrossAxisAlignment.start,
  //                                         children: [
  //                                           Text(
  //                                             itm['name'].toString(),
  //                                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                                           ),
  //                                           Text(itm['des'].toString()),
  //                                           Wrap(
  //                                             children: [
  //                                               (itm['dateSubmit'] ?? "").toString().isEmpty
  //                                                   ? SizedBox.shrink()
  //                                                   : Chip(
  //                                                       label: Text(timeago.format(DateTime.parse(itm['dateSubmit']))),
  //                                                     ),
  //                                               Chip(label: Text(itm['Departement']['name'].toString())),
  //                                               Chip(label: Text(itm['Product']['name'].toString())),
  //                                               Chip(label: Text(itm['IssueType']['name'].toString())),
  //                                               Chip(label: Text(itm['CreatedBy']['name'].toString())),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // todo : add button accept or reject
  //                                   V2Role().buttonStatusByRole
  //                                 ],
  //                               ),
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               mainAxisSize: MainAxisSize.max,
  //                               children: [
  //                                 MaterialButton(
  //                                   textColor: Colors.cyan,
  //                                   child: Text("Detail"),
  //                                   onPressed: () async {
  //                                     V2Val.detailControll.content.value.val = itm;
  //                                     V2Val.homeControll.selectedIssueId.value.val = itm['id'];
  //                                     await V2Val.homeControll.loadDiscutionByIssueId();
  //                                     Get.toNamed(V2Routes.issueDetail().key);
  //                                   },
  //                                 ),
  //                               ],
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     );
}
