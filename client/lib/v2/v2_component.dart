import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'v2_load.dart';
import 'v2_role.dart';
import 'v2_routes.dart';
import 'v2_val.dart';

class V2Component {
  static Drawer drawerFilter({Widget? child}) => Drawer(
        child: ListView(
          children: [
            Row(
              children: [
                BackButton(),
                Icon(Icons.filter_list),
                Text('Filter'),
              ],
            ),
            child!,
          ],
        ),
      );

  Widget listJobs(bool isMobile) => Obx(
        () => Column(
          children: [
            Wrap(
              children: [
                for (final itm in V2Val.listIssueDashboard.value.val)
                  Visibility(
                    visible: (V2Role.user().isMe() || V2Role.admin().isMe() || V2Role.moderator().isMe())
                        ? true
                        : itm['Departement']['id'].toString() == V2Val.user.val['departementsId'].toString(),
                    child: SizedBox(
                      width: Get.width / (isMobile ? 0 : 3),
                      height: 250,
                      child: Card(
                        elevation: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                itm['Client']['name'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Flexible(
                              child: Padding(
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
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              itm['des'].toString(),
                                              overflow: TextOverflow.ellipsis,
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
                                                                      .format(
                                                                          DateTime.parse(itm['dateSubmit'].toString()))
                                                                      .toString()),
                                                                ),
                                                                Expanded(
                                                                  child: Chip(
                                                                    // daysBetween
                                                                    backgroundColor: DateTime.now()
                                                                                .difference(DateTime.parse(
                                                                                    itm['dateSubmit'].toString()))
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
                                                                  ),
                                                                )
                                                              ],
                                                            )),
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
                                                    label: Text(itm['Product']['name'].toString(), overflow: TextOverflow.ellipsis,),
                                                  ),
                                                ),
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
                                    V2Role().buttonStatusByRole(itm['id'])
                                  ],
                                ),
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
                                    V2Val.selectedIssueId.value.val = itm['id'];
                                    V2Val.selectedIssueId.refresh();

                                    debugPrint(V2Val.selectedIssueId.value.val.toString());
                                    await V2Load.loadDiscutionByIssueId();
                                    Get.toNamed(V2Routes.issueDetail().key);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      );
}
