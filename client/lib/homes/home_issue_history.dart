import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_probus/load.dart';

import 'package:my_probus/val.dart';

class HomeIssueHistory extends StatelessWidget {
  const HomeIssueHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Load().loadIssueHistory();

    return Container(
      child: Obx(() => ListView(
            children: [
              for (final item in Val.issueHistories.value.val)
                Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'].toString(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final item2 in item['IssueHistory'])
                              Card(
                                elevation: 0,
                                color: Colors.grey.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   item2.toString(),
                                      //   style: TextStyle(color: Colors.blue),
                                      // ),
                                      Text(
                                        item2['createdAt'].toString(),
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text(
                                        (item2['User']?['name'] ?? "null").toString(),
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text(
                                        (item2['IssueStatus']?['name'] ?? "null").toString(),
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
