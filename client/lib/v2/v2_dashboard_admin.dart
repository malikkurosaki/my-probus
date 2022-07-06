import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/skt.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'v2_ismobile_widget.dart';
import 'v2_routes.dart';
import 'v2_val.dart';
import 'package:timeago/timeago.dart' as timeago;

class V2DashboardAdmin extends StatelessWidget {
  const V2DashboardAdmin({Key? key}) : super(key: key);

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
          Visibility(
            visible: !V2Role.user().isMe(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "the issue has passed a week ago",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Date Is Empty"),
                  ),
                ),
                MaterialButton(
                    child: Text("Tekan Ja"),
                    onPressed: () {
                      Skt.socket.emit("client", "hahaha");
                    
                    }),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Need Your Handling",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          Obx(
            () => Column(
              children: [
                // Text(V2Val.homeControll.listIssueDashboard.value.val.toString()),
                Wrap(
                  children: [
                    for (final itm in V2Val.homeControll.listIssueDashboard.value.val)
                      SizedBox(
                        width: Get.width / (isMobile ? 0 : 3),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 30,
                                          child: Text(itm['idx'].toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Id Issue"),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              itm['name'].toString(),
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                            Text(itm['des'].toString()),
                                            Wrap(
                                              children: [
                                                (itm['dateSubmit'] ?? "").toString().isEmpty
                                                    ? SizedBox.shrink()
                                                    : Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Chip(
                                                          label:
                                                              Text(timeago.format(DateTime.parse(itm['dateSubmit']))),
                                                        ),
                                                      ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Chip(
                                                    label: Text(itm['Departement']['name'].toString()),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(
                                                    label: Text(itm['Product']['name'].toString()),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(
                                                    label: Text(itm['IssueType']['name'].toString()),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(
                                                    label: Text(itm['CreatedBy']['name'].toString()),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(label: Text(itm['IssuesStatus']['name'].toString())),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // todo : add button accept or reject
                                    // V2Val.homeControll.acceptOrRejectButton()
                                    V2Role().buttonStatusByRole(itm['id'])
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  MaterialButton(
                                    textColor: Colors.cyan,
                                    child: Text("Detail"),
                                    onPressed: () async {
                                      V2Val.detailControll.content.value.val = itm;
                                      V2Val.selectedIssueId.val = itm['id'];
                                      await V2Load.loadDiscutionByIssueId();
                                      Get.toNamed(V2Routes.issueDetail().key);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
