import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/home_list_issue_view.dart';
import 'package:my_probus/homes/home_select_issue_status.dart';
import 'package:my_probus/homes/home_selelct_issue_type.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeIssueLaps extends StatelessWidget {
  HomeIssueLaps({Key? key}) : super(key: key);

  // final Val.seletctedCategory = <String, dynamic>{"id": "all", "name": "all"}.val("Val.seletctedCategory").obs;
  // final Val.selectedStatus = <String, dynamic>{"id": "all", "name": "all"}.val("Val.selectedStatus").obs;

  final _listIssue = [].val("HomeMain_listIssue").obs;
  final _listIssueBackup = [].val("HomeMain_listIssueBackup").obs;
  final _listIssueStatusBackup = [].val("HomeMain_listIssueStatusBackup").obs;
  final _selectDate = DateTime.now().val("HomeMain_selectDate").obs;

  final _search = "".val("HomeMain_search").obs;

  onLoad() async {
    await Load().loadIssue();

    _listIssue.value.val = Val.issues.value.val;
    // _listIssueBackup.value.val = Val.issues.value.val;
    _listIssueStatusBackup.value.val = _listIssue.value.val;
    _listIssue.refresh();

    final types = List.from(
      Val.issues.value.val.where(
        (e) => e['IssueType']['id'] == Val.seletctedCategory.value.val['id'],
      ),
    );

    if (types.isNotEmpty) {
      _listIssue.value.val = types;
      _listIssue.refresh();
    }

    final statuses = List.from(
      _listIssueStatusBackup.value.val.where(
        (e) => e['issueStatusesId'].toString() == Val.selectedStatus.value.val['id'].toString(),
      ),
    );

    if (statuses.isNotEmpty) {
      _listIssue.value.val = statuses;
      _listIssue.refresh();
    }

    // debugPrint("_listIssue.value.val: ${_listIssue.value.val}");
  }

  @override
  Widget build(BuildContext context) {
    onLoad();
    return Material(
      color: Colors.grey.shade100,
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Obx(
          () => SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (e) {
                            _search.value.val = e;
                            _listIssue.value.val = Val.issues.value.val;

                            _listIssue.value.val = List.from(_listIssue.value.val)
                                .where((x) =>
                                    x['name'].toString().toLowerCase().contains(e.toString().toLowerCase()) ||
                                    x['idx'].toString().toLowerCase().contains(e.toString().toLowerCase()))
                                .toList();
                            _listIssue.refresh();
                          },
                          controller: TextEditingController(text: _search.value.val),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            // labelText: 'Search',
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    // select date button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        elevation: 0.0,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('dd MMMM yyyy').format(_selectDate.value.val),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.cyan,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectDate.value.val,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );

                          _selectDate.value.val = date!;
                          _selectDate.refresh();

                          _listIssue.value.val = Val.issues.value.val
                              .where((element) =>
                                  DateFormat('dd MMMM yyyy').format(DateTime.parse(element['createdAt'])) ==
                                  DateFormat('dd MMMM yyyy').format(date))
                              .toList();
                        },
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: Column(
                    children: [
                      // issue type
                      HomeSelectIssueType(
                          listIssue: _listIssue,
                          listIssueStatusBackup: _listIssueStatusBackup,
                          selectedStatus: Val.selectedStatus,
                          seletctedCategory: Val.seletctedCategory),
                      HomeSelectIssueStatus(
                          selectedStatus: Val.selectedStatus,
                          listIssue: _listIssue,
                          listIssueStatusBackup: _listIssueStatusBackup),
                      Flexible(
                        child: HomeListIssueView(
                          listIssue: _listIssue,
                          listIssueBackup: _listIssueBackup,
                          lebarItem: 150.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
