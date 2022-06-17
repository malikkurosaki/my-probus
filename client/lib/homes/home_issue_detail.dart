import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/components/button_status.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/priority.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/models/model_issue_histories.dart';
import 'package:my_probus/models/model_issue_statuses.dart';
import 'package:my_probus/models/model_issues.dart';
import 'package:my_probus/models/model_status.dart';
import 'package:my_probus/pref.dart';
import 'package:my_probus/val.dart';




class HomeIssueDetail extends StatelessWidget {
  HomeIssueDetail({Key? key}) : super(key: key);
  final _contentController = TextEditingController();
  final _scrollController = ScrollController();
  // final _contentKey = GlobalKey<FormState>();
  final _contentFocus = FocusNode();
  final _priority = {}.val("HomeIssueDetail_priority").obs;
  final _noteController = "".val("HomeIssueDetail_note").obs;

  Future _onload() async {
    Val.discussion.value.val = [];
    Val.discussion.refresh();

    Load().loadDiscution();
  }

  Widget _ketDetail(String title, String value) => Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(8.0),
              child: title == "Priority"
                  ? Row(
                      children: [
                        for (final p in List.generate(5, (index) => index))
                          Icon(
                            Icons.star,
                            color: p >= int.parse(value) ? Colors.grey.shade100 : Colors.orange,
                          ),
                      ],
                    )
                  : Text(value, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ),
          )
        ],
      );

  // leader button action (accept, reject)
  Widget _leaderButton() => 
  Visibility(
        visible: Pref().isLeader && Val.issueDetail.value.val['issueStatusesId'] == '1',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text("Accept", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  final noteText = 
                  Get.dialog(
                    AlertDialog(
                      title: Text("Accept"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to accept this issue?"),
                          // pilih prioritas
                          Priority(
                              title: "Please Select Priority".toUpperCase(),
                              item: Val.issuePriorities.value.val,
                              value: _priority,
                              subtitle: "berikan prioritas untuk issue ini"),
                          TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              filled: true,
                              hintText: ""
                            ),
                          )
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            if (_priority.value.val.isEmpty) {
                              EasyLoading.showError("Please Select Priority");
                              return;
                            }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": "2",
                              "note": "",
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              MaterialButton(
                color: Colors.pink,
                child: Text("Reject", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Reject"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to reject this issue?"),
                          // pilih prioritas
                          TextFormField(
                            onChanged: (value) => _noteController.value.val = value,
                            controller: TextEditingController(text: _noteController.value.val),
                            maxLength: 100,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Reason",
                              hintText: "Please enter reason",
                            ),
                          )
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            if (_noteController.value.val.isEmpty) {
                              EasyLoading.showError("Please enter reason");
                              return;
                            }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              // "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": "3",
                              "note": _noteController.value.val,
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  // moderator button action (approve, decline)
  Widget _moderatorButton() => Visibility(
        visible: Pref().isModerator && Val.issueDetail.value.val['issueStatusesId'] == '2',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text("Approve", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Approve"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to accept this issue?"),
                          // pilih prioritas
                          Priority(
                              title: "Please Select Priority".toUpperCase(),
                              item: Val.issuePriorities.value.val,
                              value: _priority,
                              subtitle: "berikan prioritas untuk issue ini")
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            if (_priority.value.val.isEmpty) {
                              EasyLoading.showError("Please Select Priority");
                              return;
                            }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": "4",
                              "note": "",
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              MaterialButton(
                color: Colors.pink,
                child: Text(
                  "Decline",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Reject"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to reject this issue?"),
                          // pilih prioritas
                          TextFormField(
                            onChanged: (value) => _noteController.value.val = value,
                            controller: TextEditingController(text: _noteController.value.val),
                            maxLength: 100,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Reason",
                              hintText: "Please enter reason",
                            ),
                          )
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            if (_noteController.value.val.isEmpty) {
                              EasyLoading.showError("Please enter reason");
                              return;
                            }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              // "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": "5",
                              "note": _noteController.value.val,
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  // admin button action (progress, pending)
  Widget _adminButton() => Visibility(
        visible: Pref().isAdmin && Val.issueDetail.value.val['issueStatusesId'] == '4',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Text("Progress", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Progress"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to progress this issue?"),
                          // pilih prioritas
                          // Priority(
                          //     title: "Please Select Priority".toUpperCase(),
                          //     item: Val.issuePriorities.value.val,
                          //     value: _priority,
                          //     subtitle: "berikan prioritas untuk issue ini")
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            // if (_priority.value.val.isEmpty) {
                            //   EasyLoading.showError("Please Select Priority");
                            //   return;
                            // }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              // "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": ModelStatus.progress().id,
                              "note": "",
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              MaterialButton(
                color: Colors.pink,
                child: Text("Pending", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Pending"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Are you sure to pending this issue?"),
                          // pilih prioritas
                          // Priority(
                          //     title: "Please Select Priority".toUpperCase(),
                          //     item: Val.issuePriorities.value.val,
                          //     value: _priority,
                          //     subtitle: "berikan prioritas untuk issue ini")
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            if (_priority.value.val.isEmpty) {
                              EasyLoading.showError("Please Select Priority");
                              return;
                            }

                            final body = {
                              "issueId": Val.issueDetail.value.val['id'],
                              // "issuePriorityId": _priority.value.val['id'],
                              "issueStatusesId": ModelStatus.pending().id,
                              "note": "",
                            };

                            final ptc = await Conn().issuePatchStatus(body);
                            debugPrint(ptc.body);

                            if (ptc.statusCode == 200) {
                              await Load().loadIssue();
                              Get.back();
                              EasyLoading.showSuccess("Success");
                            } else {
                              EasyLoading.showError("Failed");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget _detailBar() => Row(
        children: [
          BackButton(
            onPressed: () {
              Val.indexHome.value.val = 0;
              Val.selectedPage.value.val = "Issue Laps";
              Val.selectedPage.refresh();
              Val.indexHome.refresh();
            },
          ),
          Expanded(
            child: Stack(
              children: [
                _moderatorButton(),
                // _leaderButton(),
                ButtonStatus(
                  visibleFor:Pref().isLeader, 
                  paramA: ModelStatus.accepted(), 
                  paramB: ModelStatus.rejected(), 
                  issueId: Val.issueDetail.value.val['id'],
                ),
                _adminButton(),
              ],
            ),
          ),
        ],
      );

  Widget _panelDetail() => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: Pref().isAdmin,
              child: Text("Adimin section"),
            ),
            _ketDetail("type", (Val.issueDetail.value.val["IssueType"]?['name'] ?? "null").toString()),

            _ketDetail("Title", (Val.issueDetail.value.val["name"] ?? "null").toString()),

            _ketDetail("Description", Val.issueDetail.value.val["des"].toString()),

            _ketDetail("Client", (Val.issueDetail.value.val["Client"]?['name'] ?? "null").toString()),

            _ketDetail("Created By", (Val.issueDetail.value.val["CreatedBy"]?['name'] ?? "null").toString()),

            _ketDetail("Create At",
                DateFormat('dd MMMM yyyy').format(DateTime.parse(Val.issueDetail.value.val['createdAt'])).toString()),

            Val.issueDetail.value.val["IssuePriority"] == null
                ? const SizedBox.shrink()
                : _ketDetail("Priority", Val.issueDetail.value.val["IssuePriority"]['value'].toString()),

            _ketDetail("Module", (Val.issueDetail.value.val["Departement"]?['name'] ?? "null").toString()),
            // Text(Val.issueDetail.value.val["IssueRejecteds"].toString()),
            // Text(Val.issueDetail.value.val["IssueAccepts"].toString()),
            // Text(Val.issueDetail.value.val["IssueForwardedTo"].toString()),
            // Text(Val.issueDetail.value.val["Discussion"].toString()),
            Val.issueDetail.value.val['Images'] == null || Val.issueDetail.value.val['Images'].length < 0
                ? Text(Val.issueDetail.value.val['Images'].toString())
                : Wrap(
                    children: [
                      for (final img in List.from(Val.issueDetail.value.val['Images']))
                        InkWell(
                          onTap: () {
                            Get.dialog(Material(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BackButton(),
                                  Flexible(
                                    child: CachedNetworkImage(
                                      imageUrl: "${Conn().hostImage}/${img['name']}",
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: "${Conn().hostImage}/${img['name']}",
                            ),
                          ),
                        )
                    ],
                  ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _onload();

    return Material(
      color: Colors.blueGrey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Container(
              color: Colors.grey.shade200,
              child: _detailBar(),
            ),
          ),
          Flexible(
            child: ListView(
              controller: _scrollController,
              children: [
                _panelDetail(),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final dis in Val.discussion.value.val)
                        Align(
                          alignment:
                              dis['User']['id'] == Val.user.value.val['id'] ? Alignment.topRight : Alignment.topLeft,
                          child: Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: dis['User']['id'] == Val.user.value.val['id']
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(dis['User']['name'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: dis['User']['id'] == Val.user.value.val['id']
                                              ? Colors.blue
                                              : Colors.black)),
                                  List.from(dis['Image'] ?? []).isEmpty
                                      ? Text(dis['content'].toString())
                                      : CachedNetworkImage(imageUrl: "${Conn().hostImage}/${dis['Image'][0]['name']}"),
                                  Text(DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(dis['createdAt']))),
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
          ),
          // chat input area
          Container(
            padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 16),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _contentFocus,
                    onSubmitted: (value) {
                      _submit(context);
                    },
                    textInputAction: TextInputAction.send,
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      // enabledBorder: OutlineInputBorder(),
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _submit(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _submit(BuildContext context) async {
    if (_contentController.text.isEmpty) {
      EasyLoading.showError("Please type your message");
      return;
    }

    final body = {
      "content": _contentController.text,
      "issuesId": Val.issueDetail.value.val["id"],
      "usersId": Val.user.value.val['id']
    };

    final discus = await Conn().discusPost(body);

    if (discus.statusCode == 201) {
      final dis = List.from(Val.discussion.value.val);
      dis.add(json.decode(discus.body)['data']);
      Val.discussion.value.val = dis;
      Val.discussion.refresh();
      _contentController.clear();

      // focus to input box
      _contentFocus.requestFocus();

      // scroll to bottom
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent + 70,
      //   duration: Duration(milliseconds: 500),
      //   curve: Curves.ease,
      // );
      if (_scrollController.position.maxScrollExtent > 0) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 70,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }
  }
}
