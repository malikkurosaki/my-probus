import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeListIssueView extends StatelessWidget {
  const HomeListIssueView({Key? key, required this.listIssue, required this.listIssueBackup, required this.lebarItem})
      : super(key: key);
  final Rx<ReadWriteValue<List>> listIssue;
  final Rx<ReadWriteValue<List>> listIssueBackup;
  // final List items;
  final double lebarItem;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Load().loadIssue(alert: true);
        listIssue.value.val = Val.issues.value.val;
        listIssueBackup.value.val = Val.issues.value.val;
        listIssue.refresh();
      },
      child: Obx(() => listIssue.value.val.isEmpty
          ? Center(
              child: CachedNetworkImage(
              imageUrl: Conn().host + "/images/kosong.png",
              fit: BoxFit.cover,
              height: lebarItem,
              width: lebarItem,
            ))
          : ListView(
              controller: ScrollController(),
              children: [
                // Text(JsonEncoder.withIndent('  ').convert(items)),
                for (final e in listIssue.value.val)
                  InkWell(
                    onTap: () {
                      Val.indexHome.value.val = 4;
                      Val.selectedPage.value.val = "Issue Detail";
                      Val.issueDetail.value.val = e;

                      Val.issueDetail.refresh();
                      Val.indexHome.refresh();
                      Val.selectedPage.refresh();
                    },
                    child: Card(
                        elevation: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 120,
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    elevation: 0.0,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e['IssueType']['name'].toString().toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0.0,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(
                                            e['createdAt'].toString(),
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      (e['name'] ?? "kosong").toString().toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.blue,
                                    child: Container(
                                      width: lebarItem,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        timeago
                                            .format(
                                              DateTime.parse(
                                                e['createdAt'].toString(),
                                              ),
                                            )
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      SizedBox(
                                        width: lebarItem,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.store,
                                              color: Colors.blue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e['Client']['name'].toString().toUpperCase(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.account_tree_sharp,
                                              color: Colors.blue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e['Departement']['name'].toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.propane_tank_rounded,
                                              color: Colors.blue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e['Product']['name'].toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.account_circle,
                                              color: Colors.blue,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e['CreatedBy']['name'].toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Visibility(
                                          visible: ((e['IssuePriority']?['value']??0) as int).isGreaterThan(0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add_moderator_sharp,
                                                color: Colors.blue,
                                              ),
                                              for (final str in List.generate(5, (index) => (index + 1)))
                                                Icon(
                                                  Icons.star,
                                                  color: ((e['IssuePriority']?['value'] ?? 0) < str)
                                                      ? Colors.grey.shade100
                                                      : Colors.orange,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Text(JsonEncoder.withIndent("  ").convert(e))
                                      SizedBox(
                                        width: lebarItem,
                                        child: Row(
                                          children: [
                                            Icon(Icons.add_chart_sharp, color: Colors.blue),
                                            Text(
                                              (e['IssuesStatus']?['name'] ?? "null").toString().toUpperCase(),
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Visibility(
                                          visible: List.from(e['Discussion']).isNotEmpty,
                                          child: Row(
                                            children: [
                                              Icon(Icons.message, color: Colors.blue),
                                              Expanded(child: Text("Chat Available"))
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Visibility(
                                      //   visible: e['IssuePriority']['value'] > 1,
                                      //   child: Icon(
                                      //     Icons.info,
                                      //     color: Colors.orange,
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  // Row(
                                  //   children: [
                                  //     for (var i in List.generate(e['IssuePriority']['value'], (index) => index))
                                  //       Icon(
                                  //         Icons.star,
                                  //         color: Colors.grey.shade600,
                                  //       ),
                                  //   ],
                                  // ),
                                  e['Images'] == null || e['Images'].length < 0
                                      ? Text(e['Images'].toString())
                                      : Wrap(
                                          children: [
                                            for (final img in List.from(e['Images']))
                                              Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey.shade200),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: "${Conn().hostImage}/${img['name']}",
                                                  ))
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            // Container(
                            //   width: 100,
                            //   height: 100,
                            //   alignment: Alignment.center,
                            //   child: Text(e['Status']['name'].toString()),
                            // ),
                            // day ago
                          ],
                        )
                        // ListTile(
                        //   leading: Text(e['IssueType']['name'].toString()),
                        //   title: Text(e['name']?? "kosong"),
                        //   subtitle: Row(
                        //     children: [
                        //       for(var i in List.generate(e['IssuePriority']['value'], (index) => index))
                        //       Icon(Icons.star)
                        //     ]
                        //   ),
                        //   onTap: () {},
                        // ),
                        ),
                  )
              ],
            )),
    );
  }
}
