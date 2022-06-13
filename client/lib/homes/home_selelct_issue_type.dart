import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/val.dart';

class HomeSelectIssueType extends StatelessWidget {
  const HomeSelectIssueType(
      {Key? key,
      required this.listIssue,
      required this.listIssueStatusBackup,
      required this.selectedStatus,
      required this.seletctedCategory})
      : super(key: key);
  final Rx<ReadWriteValue<Map>> seletctedCategory;
  final Rx<ReadWriteValue<Map>> selectedStatus;
  final Rx<ReadWriteValue<List>> listIssue;
  final Rx<ReadWriteValue<List>> listIssueStatusBackup;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    seletctedCategory.value.val = Map<String, dynamic>.from({"id": "all", "name": "all"});
                    seletctedCategory.refresh();

                    listIssue.value.val = Val.issues.value.val;
                    listIssue.refresh();

                    listIssueStatusBackup.value.val = listIssue.value.val;
                    // _listIssueBackup.value.val = Val.issues.value.val;

                    selectedStatus.value.val = Map<String, dynamic>.from({"id": "all", "name": "all"});
                    selectedStatus.refresh();
                  },
                  child: Card(
                    // color: seletctedCategory.value.val['id'] == "all" ? Colors.green : Colors.white,
                    // elevation: seletctedCategory.value.val['id'] == "all" ? 2 : 0,
                    elevation: 0.0,
                    child: SizedBox(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "All".toUpperCase(),
                            style: TextStyle(
                              color: seletctedCategory.value.val['id'] == "all" ? Colors.green : Colors.grey,
                              fontSize: 16,
                              fontWeight: seletctedCategory.value.val['id'] == "all" ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (final cate in Val.issueTypes.value.val)
                  InkWell(
                    onTap: () {
                      seletctedCategory.value.val = Map<String, dynamic>.from(cate);
                      seletctedCategory.refresh();

                      final datanya = List.from(
                          Val.issues.value.val.where((e) => e['IssueType']['id'] == seletctedCategory.value.val['id']));
                      listIssue.value.val = datanya;
                      listIssue.refresh();

                      listIssueStatusBackup.value.val = listIssue.value.val;

                      selectedStatus.value.val = Map<String, dynamic>.from({"id": "all", "name": "all"});
                      selectedStatus.refresh();
                    },
                    child: Card(
                      // color: seletctedCategory.value.val['id'] == cate['id'] ? Colors.green : Colors.white,
                      // elevation: seletctedCategory.value.val['id'] == cate['id'] ? 2 : 0,
                      elevation: 0.0,
                      child: SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              cate['name'].toString().toUpperCase(),
                              style: TextStyle(
                                color: seletctedCategory.value.val['id'] == cate['id'] ? Colors.green : Colors.grey,
                                fontSize: 16,
                                fontWeight: seletctedCategory.value.val['id'] == cate['id'] ? FontWeight.bold : FontWeight.normal,
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
        ));
  }
}
