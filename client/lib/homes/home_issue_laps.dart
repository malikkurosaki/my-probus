import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/homes/home_list_issue_view.dart';
import 'package:my_probus/homes/home_select_issue_status.dart';
import 'package:my_probus/homes/home_selelct_issue_type.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'home_issue_controller.dart';




class HomeIssueLaps extends StatelessWidget {
  const HomeIssueLaps({Key? key}) : super(key: key);

  // final Val.seletctedCategory = <String, dynamic>{"id": "all", "name": "all"}.val("Val.seletctedCategory").obs;
  // final Val.selectedStatus = <String, dynamic>{"id": "all", "name": "all"}.val("Val.selectedStatus").obs;

  

  @override
  Widget build(BuildContext context) {
    HomeIssueController.onLoad();
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
                            HomeIssueController.search.value.val = e;
                            HomeIssueController.listIssue.value.val = Val.issues.value.val;

                            HomeIssueController.listIssue.value.val = List.from(HomeIssueController.listIssue.value.val)
                                .where((x) =>
                                    x['name'].toString().toLowerCase().contains(e.toString().toLowerCase()) ||
                                    x['idx'].toString().toLowerCase().contains(e.toString().toLowerCase()))
                                .toList();
                            HomeIssueController.listIssue.refresh();
                          },
                          controller: TextEditingController(text: HomeIssueController.search.value.val),
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
                                DateFormat('dd MMMM yyyy').format(HomeIssueController.selectDate.value.val),
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
                            initialDate: HomeIssueController.selectDate.value.val,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );

                          HomeIssueController.selectDate.value.val = date!;
                          HomeIssueController.selectDate.refresh();

                          HomeIssueController.listIssue.value.val = Val.issues.value.val
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
                          listIssue: HomeIssueController.listIssue,
                          listIssueStatusBackup: HomeIssueController.listIssueStatusBackup,
                          selectedStatus: Val.selectedStatus,
                          seletctedCategory: Val.seletctedCategory),
                      HomeSelectIssueStatus(
                          selectedStatus: Val.selectedStatus,
                          listIssue: HomeIssueController.listIssue,
                          listIssueStatusBackup: HomeIssueController.listIssueStatusBackup),
                      Flexible(
                        child: HomeListIssueView(
                          listIssue: HomeIssueController.listIssue,
                          listIssueBackup: HomeIssueController.listIssueBackup,
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
