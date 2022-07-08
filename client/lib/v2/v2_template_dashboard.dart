import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'v2_component.dart';
import 'v2_filter_dashboard_button.dart';
import 'v2_ismobile_widget.dart';
import 'v2_print_report.dart';
import 'v2_role.dart';
import 'v2_val.dart';

class V2TemplateDashboard extends StatelessWidget {
  const V2TemplateDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => ListView(
        controller: ScrollController(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: Colors.cyan,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          V2Val.user.val['name'].toString(),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          V2Val.user.val['Role']['name'].toString(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    V2Val.clock,
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      await V2Val.homeControll.loadIssueDashboard();
                      EasyLoading.showToast("Refreshed");
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
          ),
          Divider(
            color: Colors.cyan,
          ),
          // Visibility(
          //   visible: !V2Role.user().isMe(),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "the issue has passed a week ago",
          //           style: TextStyle(
          //             fontSize: 24,
          //           ),
          //         ),
          //       ),
          //       Card(
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text("Date Is Empty"),
          //         ),
          //       ),
          //       Divider(),
          //     ],
          //   ),
          // ),
          Visibility(
            visible: !V2Role.user().isMe(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Need Your Handling",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  V2FilterDashboardButton(),
                  V2PrinstReportButton()
                ],
              ),
            ),
          ),
          V2Component().listJobs(isMobile)
        ],
      ),
    );
  }
}