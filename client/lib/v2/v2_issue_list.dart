import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'v2_load.dart';
import 'v2_role.dart';
import 'v2_routes.dart';
import 'v2_val.dart';

class V2IssueList extends StatelessWidget {
  const V2IssueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
        isMobile: (isMobile) => ListView(
              children: [
                Row(
                  children: [
                    BackButton(),
                    Text("list Issue"),
                  ],
                ),
                // Text(V2Val.listIssue.value.val.toString()),
                _item(isMobile)
              ],
            ));
  }

  Widget _item(bool isMobile) => Obx(
    () => 
    Wrap(
        children: [
          for (final itm in V2Val.listIssue.value.val)
            SizedBox(
              width: Get.width / (isMobile ? 0 : 3),
              child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     itm['Client']['name'].toString(),
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
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
                                  Text(
                                    itm['des'].toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      (itm['dateSubmit'] ?? "").toString().isEmpty
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Chip(
                                                  padding: const EdgeInsets.all(2.0),
                                                  label: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(DateFormat('dd/MM/yyyy')
                                                            .format(DateTime.parse(itm['dateSubmit'].toString()))
                                                            .toString()),
                                                      ),
                                                      Chip(
                                                        // daysBetween
                                                        backgroundColor: DateTime.now()
                                                                    .difference(
                                                                        DateTime.parse(itm['dateSubmit'].toString()))
                                                                    .inDays >
                                                                2
                                                            ? Colors.pink
                                                            : Colors.cyan,
                                                        label: Text(
                                                          timeago.format(
                                                            DateTime.parse(
                                                              itm['dateSubmit'],
                                                            ),
                                                          ),
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                      // todo : disini error
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Chip(
                                          label: Text((itm['Departement']?['name'] ?? "modul ...").toString()),
                                        ),
                                      ),

                                      // todo : disini error juga
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Chip(
                                          label: Text((itm['Product']?['name'] ?? "product ...").toString()),
                                        ),
                                      ),

                                      // todo : disini error
                                      (itm['IssueType']?['name'] ?? "").toString().isEmpty
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Chip(
                                                backgroundColor: itm['IssueType']?['name'].toString() == "bug"
                                                    ? Colors.orange
                                                    : Colors.grey.shade100,
                                                label: Text((itm['IssueType']?['name'] ?? "").toString()),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Chip(
                                          label: Text((itm['CreatedBy']?['name'] ?? "Create By ...").toString()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Chip(
                                            label: Text((itm['IssuesStatus']?['name'] ?? "status ...").toString())),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // todo : add button accept or reject
                          // V2Val.homeControll.acceptOrRejectButton()
                          // V2Role().buttonStatusByRole(itm['id'])
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
                            debugPrint(V2Val.selectedIssueId.val.toString());
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
      )
  )
  ;
}
