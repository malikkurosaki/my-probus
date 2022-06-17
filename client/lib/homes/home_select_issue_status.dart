import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/src/read_write_value.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:my_probus/val.dart';

class HomeSelectIssueStatus extends StatelessWidget {
  const HomeSelectIssueStatus(
      {Key? key, required this.selectedStatus, required this.listIssue, required this.listIssueStatusBackup})
      : super(key: key);
  final Rx<ReadWriteValue> selectedStatus;
  final Rx<ReadWriteValue<List>> listIssue;
  final Rx<ReadWriteValue<List>> listIssueStatusBackup;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(8.0),
            child: Text("Issue Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      // color: selectedStatus.value.val['id'] == "all" ? Colors.blue : Colors.white,
                      // elevation: selectedStatus.value.val['id'] == "all" ? 2 : 0,
                      elevation: 0.0,
                      child: InkWell(
                        onTap: () {
                           selectedStatus.value.val = Map<String, dynamic>.from({"id": "all", "name": "all"});
                          selectedStatus.refresh();
          
                          listIssue.value.val = listIssueStatusBackup.value.val;
                          listIssue.refresh();
                        },
                        child: SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "All".toUpperCase(),
                                style: TextStyle(
                                  color: selectedStatus.value.val['id'] == "all" ? Colors.blue : Colors.grey,
                                  fontSize: 16,
                                  fontWeight: selectedStatus.value.val['id'] == "all" ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (final status in Val.issueStatuses.value.val)
                      Card(
                        // color: selectedStatus.value.val['id'] == status['id'] ? Colors.blue : Colors.white,
                        // elevation: selectedStatus.value.val['id'] == status['id'] ? 2 : 0,
                        elevation: 0.0,
                        child: InkWell(
                          onTap: () => updatStatus(status),
                          child: SizedBox(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  status['name'].toString().toUpperCase(),
                                  style: TextStyle(
                                    color: selectedStatus.value.val['id'] == status['id'] ? Colors.blue : Colors.grey,
                                    fontSize: 16,
                                    fontWeight:
                                        selectedStatus.value.val['id'] == status['id'] ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  updatStatus(Map status) {

    debugPrint(status.toString());
   
    selectedStatus.value.val = Map<String, dynamic>.from(status);
    selectedStatus.refresh();

    final datanya = List.from(listIssueStatusBackup.value.val
        .where((e) => e['issueStatusesId'].toString() == selectedStatus.value.val['id'].toString()));

    listIssue.value.val = datanya;
    listIssue.refresh();
  }
}
