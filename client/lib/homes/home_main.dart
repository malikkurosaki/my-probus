import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeMain extends StatelessWidget {
  HomeMain({Key? key}) : super(key: key);
  final _lebarItem = 150.0;
  final _seletctedCategory = <String, dynamic>{"id": "all", "name": "all"}.val("_seletctedCategory").obs;
  final _listIssue = [].val("_listIssue").obs;
  final _listIssueBackup = [].val("_listIssueBackup").obs;
  final _search = "".val("_search").obs;

  _onLoad() async {
    await Conn().loadIssue();

    _listIssue.value.val = Val.issues.value.val;
    _listIssueBackup.value.val = Val.issues.value.val;
    _listIssue.refresh();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Obx(
          () => SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (e) {
                            _search.value.val = e;
                            _listIssue.value.val = _listIssueBackup.value.val;
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
                    )
                  ],
                ),
                Flexible(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FittedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  _seletctedCategory.value.val = Map.from({"id": "all", "name": "all"});
                                  _seletctedCategory.refresh();

                                  _listIssue.value.val.assignAll(Val.issues.value.val);
                                  _listIssue.refresh();

                                  _listIssueBackup.value.val.assignAll(Val.issues.value.val);
                                },
                                child: Card(
                                  elevation: _seletctedCategory.value.val['id'] == "all" ? 2 : 0,
                                  child: SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text("All".toUpperCase()),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              for (final cate in Val.issueTypes.value.val)
                                InkWell(
                                  onTap: () {
                                    _seletctedCategory.value.val = Map.from(cate);
                                    _seletctedCategory.refresh();

                                    _listIssue.value.val = List.from(Val.issues.value.val
                                        .where((e) => e['IssueType']['id'] == _seletctedCategory.value.val['id']));
                                    _listIssue.refresh();

                                    _listIssueBackup.value.val = List.from(_listIssue.value.val);
                                  },
                                  child: Card(
                                    elevation: _seletctedCategory.value.val['id'] == cate['id'] ? 2 : 0,
                                    child: SizedBox(
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(cate['name'].toString().toUpperCase()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Obx(
                          () => _listIssueView(_listIssue.value.val),
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

  Widget _listIssueView(List items) => RefreshIndicator(
        onRefresh: () async {
          await Conn().loadIssue(alert: true);
          _listIssue.value.val = Val.issues.value.val;
          _listIssueBackup.value.val = Val.issues.value.val;
          _listIssue.refresh();
        },
        child: ListView(
          controller: ScrollController(),
          children: [
            for (final e in items)
              InkWell(
                onTap: () {
                  Val.indexHome.value.val = 3;
                  Val.issueDetail.value.val = e;

                  Val.issueDetail.refresh();
                  Val.indexHome.refresh();
                },
                child: Card(
                    elevation: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e['IssueType']['name'].toString().toUpperCase(),
                                style: TextStyle(
                                  color: e['IssueType']['id'] == "1" ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(
                                    e['createdAt'].toString(),
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
                                  style: TextStyle(),
                                ),
                              ),

                              Wrap(
                                children: [
                                  SizedBox(
                                    width: _lebarItem,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.store,
                                          color: Colors.grey.shade600,
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
                                    width: _lebarItem,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.account_balance,
                                          color: Colors.grey.shade600,
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
                                    width: _lebarItem,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.propane_tank_rounded,
                                          color: Colors.grey.shade600,
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
                                    width: _lebarItem,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.grey.shade600,
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
                                Text((e?['IssuePriority']?['value']??"").toString())
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
                              e['Images'] == null || e['Images'].length < 0? Text(e['Images'].toString()):
                              Wrap(
                                children: [
                                  for(final img in List.from(e['Images']))
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade200),
                                      
                                    ),
                                    child: CachedNetworkImage(imageUrl: "${Conn.hostImage}/${img['name']}",)
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 100,
                        //   alignment: Alignment.center,
                        //   child: Text(e['Status']['name'].toString()),
                        // ),
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
        ),
      );
}
