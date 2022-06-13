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

class HomeMain extends StatelessWidget {
  HomeMain({Key? key}) : super(key: key);

  final _seletctedCategory = <String, dynamic>{"id": "all", "name": "all"}.val("_seletctedCategory").obs;
  final _selectedStatus = <String, dynamic>{"id": "all", "name": "all"}.val("_selectedStatus").obs;

  final _listIssue = [].val("HomeMain_listIssue").obs;
  final _listIssueBackup = [].val("HomeMain_listIssueBackup").obs;
  final _listIssueStatusBackup = [].val("HomeMain_listIssueStatusBackup").obs;
  final _selectDate = DateTime.now().val("HomeMain_selectDate").obs;

  final _search = "".val("HomeMain_search").obs;

  _onLoad() async {
    await Load().loadIssue();

    _listIssue.value.val = Val.issues.value.val;
    // _listIssueBackup.value.val = Val.issues.value.val;
    _listIssueStatusBackup.value.val = _listIssue.value.val;
    _listIssue.refresh();

    // debugPrint("_listIssue.value.val: ${_listIssue.value.val}");
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
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
                                .where((x) => x['name'].toString().toLowerCase().contains(e.toString().toLowerCase()))
                                .toList();
                            _listIssue.refresh();
                          },
                          controller: TextEditingController(text: _search.value.val),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            labelText: 'Search',
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
                          selectedStatus: _selectedStatus,
                          seletctedCategory: _seletctedCategory),
                      HomeSelectIssueStatus(
                          selectedStatus: _selectedStatus,
                          listIssue: _listIssue,
                          listIssueStatusBackup: _listIssueStatusBackup),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: FittedBox(
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         InkWell(
                      //           onTap: () {
                      //             _seletctedCategory.value.val = Map.from({"id": "all", "name": "all"});
                      //             _seletctedCategory.refresh();

                      //             _listIssue.value.val = Val.issues.value.val;
                      //             _listIssue.refresh();

                      //             _listIssueStatusBackup.value.val = _listIssue.value.val;
                      //             // _listIssueBackup.value.val = Val.issues.value.val;

                      //             _selectedStatus.value.val = Map.from({"id": "all", "name": "all"});
                      //             _selectedStatus.refresh();
                      //           },
                      //           child: Card(
                      //             color: _seletctedCategory.value.val['id'] == "all"
                      //                 ? Colors.green.shade100
                      //                 : Colors.white,
                      //             elevation: _seletctedCategory.value.val['id'] == "all" ? 2 : 0,
                      //             child: SizedBox(
                      //               width: 150,
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Center(
                      //                   child: Text("All".toUpperCase()),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         for (final cate in Val.issueTypes.value.val)
                      //           InkWell(
                      //             onTap: () {
                      //               _seletctedCategory.value.val = Map.from(cate);
                      //               _seletctedCategory.refresh();

                      //               final datanya = List.from(Val.issues.value.val
                      //                   .where((e) => e['IssueType']['id'] == _seletctedCategory.value.val['id']));
                      //               _listIssue.value.val = datanya;
                      //               _listIssue.refresh();

                      //               _listIssueStatusBackup.value.val = _listIssue.value.val;
                      //               // _listIssueBackup.value.val = List.from(_listIssue.value.val);

                      //               // debugPrint(datanya.toString());

                      //               _selectedStatus.value.val = Map.from({"id": "all", "name": "all"});
                      //               _selectedStatus.refresh();
                      //             },
                      //             child: Card(
                      //               color: _seletctedCategory.value.val['id'] == cate['id']
                      //                   ? Colors.green.shade100
                      //                   : Colors.white,
                      //               elevation: _seletctedCategory.value.val['id'] == cate['id'] ? 2 : 0,
                      //               child: SizedBox(
                      //                 width: 150,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Center(
                      //                     child: Text(cate['name'].toString().toUpperCase()),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // issue status

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: FittedBox(
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         InkWell(
                      //           onTap: () {
                      //             _selectedStatus.value.val = Map.from({"id": "all", "name": "all"});
                      //             _selectedStatus.refresh();

                      //             _listIssue.value.val = _listIssueStatusBackup.value.val;
                      //             _listIssue.refresh();

                      //             // _listIssueBackup.value.val = Val.issues.value.val;
                      //           },
                      //           child: Card(
                      //             color: _selectedStatus.value.val['id'] == "all" ? Colors.blue.shade100 : Colors.white,
                      //             elevation: _selectedStatus.value.val['id'] == "all" ? 2 : 0,
                      //             child: SizedBox(
                      //               width: 150,
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Center(
                      //                   child: Text("All".toUpperCase()),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         for (final status in Val.issueStatuses.value.val)
                      //           InkWell(
                      //             onTap: () {
                      //               debugPrint(status['id'].toString());
                      //               debugPrint(_listIssueStatusBackup.value.val
                      //                   .map((e) => e['issueStatusesId'].toString())
                      //                   .toString());

                      //               _selectedStatus.value.val = Map.from(status);
                      //               _selectedStatus.refresh();

                      //               final datanya = List.from(_listIssueStatusBackup.value.val.where((e) =>
                      //                   e['issueStatusesId'].toString() == _selectedStatus.value.val['id'].toString()));

                      //               _listIssue.value.val = datanya;
                      //               _listIssue.refresh();

                      //               // _listIssueBackup.value.val = List.from(_listIssue.value.val);
                      //             },
                      //             child: Card(
                      //               color: _selectedStatus.value.val['id'] == status['id']
                      //                   ? Colors.blue.shade100
                      //                   : Colors.white,
                      //               elevation: _selectedStatus.value.val['id'] == status['id'] ? 2 : 0,
                      //               child: SizedBox(
                      //                 width: 150,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Center(
                      //                     child: Text(status['name'].toString().toUpperCase()),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

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

  // Widget _listIssueView(List items) =>
  // RefreshIndicator(
  //       onRefresh: () async {
  //         await Load().loadIssue(alert: true);
  //         _listIssue.value.val = Val.issues.value.val;
  //         _listIssueBackup.value.val = Val.issues.value.val;
  //         _listIssue.refresh();
  //       },
  //       child: ListView(
  //         controller: ScrollController(),
  //         children: [
  //           // Text(JsonEncoder.withIndent('  ').convert(items)),
  //           for (final e in items)
  //             InkWell(
  //               onTap: () {
  //                 Val.indexHome.value.val = 4;
  //                 Val.issueDetail.value.val = e;

  //                 Val.issueDetail.refresh();
  //                 Val.indexHome.refresh();
  //               },
  //               child: Card(
  //                   elevation: 0,
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(10),
  //                         width: 100,
  //                         height: 100,
  //                         alignment: Alignment.topLeft,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Text(
  //                               e['IssueType']['name'].toString().toUpperCase(),
  //                               style: TextStyle(
  //                                 color: e['IssueType']['id'] == "1"
  //                                     ? Colors.pink
  //                                     : e['IssueType']['id'] == "2"
  //                                         ? Colors.green
  //                                         : e['IssueType']['id'] == "3"
  //                                             ? Colors.blue
  //                                             : Colors.orange,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             Text(
  //                               DateFormat('dd/MM/yyyy').format(
  //                                 DateTime.parse(
  //                                   e['createdAt'].toString(),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(vertical: 8),
  //                               child: Text(
  //                                 (e['name'] ?? "kosong").toString().toUpperCase(),
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: TextStyle(),
  //                               ),
  //                             ),

  //                             Wrap(
  //                               children: [
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.store,
  //                                         color: Colors.grey.shade600,
  //                                       ),
  //                                       Expanded(
  //                                         child: Text(
  //                                           e['Client']['name'].toString().toUpperCase(),
  //                                           overflow: TextOverflow.ellipsis,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.account_balance,
  //                                         color: Colors.grey.shade600,
  //                                       ),
  //                                       Expanded(
  //                                         child: Text(
  //                                           e['Departement']['name'].toString(),
  //                                           overflow: TextOverflow.ellipsis,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.propane_tank_rounded,
  //                                         color: Colors.grey.shade600,
  //                                       ),
  //                                       Expanded(
  //                                         child: Text(
  //                                           e['Product']['name'].toString(),
  //                                           overflow: TextOverflow.ellipsis,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.account_circle,
  //                                         color: Colors.grey.shade600,
  //                                       ),
  //                                       Expanded(
  //                                         child: Text(
  //                                           e['CreatedBy']['name'].toString(),
  //                                           overflow: TextOverflow.ellipsis,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Row(
  //                                     children: [
  //                                       for (final str in List.generate(5, (index) => (index + 1)))
  //                                         Icon(
  //                                           Icons.star,
  //                                           color: ((e?['IssuePriority']?['value'] ?? 0) < str)
  //                                               ? Colors.grey.shade100
  //                                               : Colors.orange,
  //                                         ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 // Text(JsonEncoder.withIndent("  ").convert(e))
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(8),
  //                                     child: Text(
  //                                       (e['IssuesStatus']?['name'] ?? "null").toString().toUpperCase(),
  //                                       style: TextStyle(
  //                                         color: Colors.green,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: _lebarItem,
  //                                   child: Container(
  //                                       alignment: Alignment.topLeft,
  //                                       padding: EdgeInsets.all(8),
  //                                       child: Visibility(
  //                                         visible: List.from(e['Discussion']).isNotEmpty,
  //                                         child: Icon(Icons.message, color: Colors.blue),
  //                                       )),
  //                                 )
  //                                 // Visibility(
  //                                 //   visible: e['IssuePriority']['value'] > 1,
  //                                 //   child: Icon(
  //                                 //     Icons.info,
  //                                 //     color: Colors.orange,
  //                                 //   ),
  //                                 // ),
  //                               ],
  //                             ),
  //                             // Row(
  //                             //   children: [
  //                             //     for (var i in List.generate(e['IssuePriority']['value'], (index) => index))
  //                             //       Icon(
  //                             //         Icons.star,
  //                             //         color: Colors.grey.shade600,
  //                             //       ),
  //                             //   ],
  //                             // ),
  //                             e['Images'] == null || e['Images'].length < 0
  //                                 ? Text(e['Images'].toString())
  //                                 : Wrap(
  //                                     children: [
  //                                       for (final img in List.from(e['Images']))
  //                                         Container(
  //                                             margin: EdgeInsets.all(5),
  //                                             width: 150,
  //                                             height: 150,
  //                                             decoration: BoxDecoration(
  //                                               border: Border.all(color: Colors.grey.shade200),
  //                                             ),
  //                                             child: CachedNetworkImage(
  //                                               imageUrl: "${Conn().hostImage}/${img['name']}",
  //                                             ))
  //                                     ],
  //                                   )
  //                           ],
  //                         ),
  //                       ),
  //                       // Container(
  //                       //   width: 100,
  //                       //   height: 100,
  //                       //   alignment: Alignment.center,
  //                       //   child: Text(e['Status']['name'].toString()),
  //                       // ),
  //                     ],
  //                   )
  //                   // ListTile(
  //                   //   leading: Text(e['IssueType']['name'].toString()),
  //                   //   title: Text(e['name']?? "kosong"),
  //                   //   subtitle: Row(
  //                   //     children: [
  //                   //       for(var i in List.generate(e['IssuePriority']['value'], (index) => index))
  //                   //       Icon(Icons.star)
  //                   //     ]
  //                   //   ),
  //                   //   onTap: () {},
  //                   // ),
  //                   ),
  //             )
  //         ],
  //       ),
  //     );
}
