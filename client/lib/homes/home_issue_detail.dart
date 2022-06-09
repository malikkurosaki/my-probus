import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/val.dart';

class HomeIssueDetail extends StatelessWidget {
  HomeIssueDetail({Key? key}) : super(key: key);
  final _contentController = TextEditingController();
  final _scrollController = ScrollController();

  _onload() async {
    Val.discussion.value.val = [];
    Val.discussion.refresh();

    Conn().loadDiscution();
  }

  @override
  Widget build(BuildContext context) {
    _onload();

    return Material(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView(
              controller: _scrollController,
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Val.indexHome.value.val = 0;
                        Val.indexHome.refresh();
                      },
                    )
                  ],
                ),
                Text(Val.issueDetail.value.val["name"].toString()),
                Text(Val.issueDetail.value.val["des"].toString()),
                Text(Val.issueDetail.value.val["IssueType"].toString()),
                Text(Val.issueDetail.value.val["IssuesStatus"].toString()),
                Text(Val.issueDetail.value.val["Client"].toString()),
                Text(Val.issueDetail.value.val["Product"].toString()),
                Text(Val.issueDetail.value.val["CreatedBy"].toString()),
                Text(Val.issueDetail.value.val["IssueRejecteds"].toString()),
                Text(Val.issueDetail.value.val["createdAt"].toString()),
                Text(Val.issueDetail.value.val["IssueAccepts"].toString()),
                Text(Val.issueDetail.value.val["IssueForwardedTo"].toString()),
                Text(Val.issueDetail.value.val["IssuePriority"].toString()),
                Text(Val.issueDetail.value.val["Departement"].toString()),
                Text(Val.issueDetail.value.val["Discussion"].toString()),
                Val.issueDetail.value.val['Images'] == null || Val.issueDetail.value.val['Images'].length < 0
                    ? Text(Val.issueDetail.value.val['Images'].toString())
                    : Wrap(
                        children: [
                          for (final img in List.from(Val.issueDetail.value.val['Images']))
                            Container(
                                margin: EdgeInsets.all(5),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "${Conn.hostImage}/${img['name']}",
                                ))
                        ],
                      ),
                Obx(() => Column(
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
                                        : CachedNetworkImage(imageUrl: "${Conn.hostImage}/${dis['Image'][0]['name']}"),
                                    Text(DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(dis['createdAt']))),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ))
              ],
            ),
          ),
          // chat input area
          Container(
            margin: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 16),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      _submit();
                    },
                    textInputAction: TextInputAction.send,
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Type your message here",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _submit() async {
    if (_contentController.text.isEmpty) {
      EasyLoading.showError("Please type your message");
      return;
    }

    final body = {
      "content": _contentController.text,
      "issuesId": Val.issueDetail.value.val["id"],
      "usersId": Val.user.value.val['id']
    };

    final discus = await Conn.discusPost(body);

    if (discus.statusCode == 201) {
      final dis = List.from(Val.discussion.value.val);
      dis.add(json.decode(discus.body)['data']);
      Val.discussion.value.val = dis;
      Val.discussion.refresh();
      _contentController.clear();

      // scroll to bottom
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 70,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}
