import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/home_issue_laps.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/pref.dart';
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
      child: Obx(
        () => listIssue.value.val.isEmpty
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
                    Card(
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          Val.indexHome.value.val = 4;
                          Val.selectedPage.value.val = "Issue Detail";
                          Val.issueDetail.value.val = e;

                          Val.issueDetail.refresh();
                          Val.indexHome.refresh();
                          Val.selectedPage.refresh();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 120,
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      e['idx'].toString(),
                                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        (e?['IssueType']?['name'] ?? "empty data").toString().toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
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
                                  )
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
                                      (e['name'] ?? "null").toString().toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    child: SizedBox(
                                      width: lebarItem,
                                      child: Text(
                                        timeago
                                            .format(
                                              DateTime.parse(
                                                e['createdAt'].toString(),
                                              ),
                                            )
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
                                              color: Colors.brown.shade300,
                                            ),
                                            Expanded(
                                              child: Text(
                                                (e['Client']?['name'] ?? "null").toString().toUpperCase(),
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
                                            Icon(Icons.account_tree_sharp, color: Colors.green.shade300),
                                            Expanded(
                                              child: Text(
                                                (e['Departement']?['name'] ?? "null").toString(),
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
                                              color: Colors.cyan.shade300,
                                            ),
                                            Expanded(
                                              child: Text(
                                                (e['Product']?['name'] ?? "null").toString(),
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
                                              color: Colors.teal.shade300,
                                            ),
                                            Expanded(
                                              child: Text(
                                                (e['CreatedBy']?['name'] ?? "null").toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: lebarItem,
                                        child: Visibility(
                                          visible: ((e['IssuePriority']?['value'] ?? 0) as int).isGreaterThan(0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add_moderator_sharp,
                                                color: Colors.purple.shade300,
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
                                            Icon(
                                              Icons.add_chart_sharp,
                                              color: Colors.indigo.shade300,
                                            ),
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
                                    ],
                                  ),
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
                                                ),
                                              )
                                          ],
                                        ),
                                  Visibility(
                                    visible: Pref().isSuperAdmin,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Card(
                                          elevation: 0,
                                          color: Colors.grey.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Operation",
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                ),
                                                Row(
                                                  children: [
                                                    MaterialButton(
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.edit),
                                                            Text("Edit"),
                                                          ],
                                                        ),
                                                        onPressed: () {}),
                                                    MaterialButton(
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.delete),
                                                            Text("Delete"),
                                                          ],
                                                        ),
                                                        onPressed: () {}),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Revision Status",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          for (final stt in Val.issueStatuses.value.val)
                                                            Visibility(
                                                              visible: (stt['id'] ?? "") != e['IssuesStatus']['id'],
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(4),
                                                                child: MaterialButton(
                                                                  elevation: 0,
                                                                  color: Colors.white,
                                                                  child: Text(
                                                                    stt['name'].toString(),
                                                                    style: TextStyle(color: Colors.cyan),
                                                                  ),
                                                                  onPressed: () {
                                                                    final note = TextEditingController();
                                                                    Get.dialog(AlertDialog(
                                                                      title: Text("Are you sure?"),
                                                                      content: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                              "Are you sure to change status to ${stt['name']}?"),
                                                                          TextField(
                                                                            controller: note,
                                                                            decoration: InputDecoration(
                                                                              hintText: "Note",
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        MaterialButton(
                                                                          child: Text("Cancel"),
                                                                          onPressed: () => Get.back(),
                                                                        ),
                                                                        MaterialButton(
                                                                          child: Text("Yes"),
                                                                          onPressed: () async {
                                                                            if (note.text.isEmpty) {
                                                                              EasyLoading.showError("Please fill note");
                                                                              return;
                                                                            }

                                                                            final body = {
                                                                              "issueId": e['id'],
                                                                              "issueStatusesId": stt['id'],
                                                                              "note": note.text,
                                                                            };

                                                                            final ptc =
                                                                                await Conn().issuePatchStatus(body);
                                                                            debugPrint(ptc.body);

                                                                            await HomeIssueLaps().onLoad();

                                                                            if (ptc.statusCode == 200) {
                                                                              // await Load().loadIssue();
                                                                              Get.back();
                                                                              EasyLoading.showSuccess("Success");
                                                                            } else {
                                                                              Get.back();
                                                                              EasyLoading.showError("Failed");
                                                                            }
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ));
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
