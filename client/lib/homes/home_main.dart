import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  _onLoad() async {
    await 1.delay();
    Conn().loadIssue();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Obx(
          () => ListView(
            children: Val.issues.value.val.map(
              (e) {
                return Card(
                  elevation: 0,
                    child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(e['IssueType']['name'].toString().toUpperCase()),
                          Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(e['createdAt'].toString()))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((e['name'] ?? "kosong").toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.store, color: Colors.grey.shade600,),
                              Text(e['Client']['name'].toString().toUpperCase(),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.account_balance,
                                color: Colors.grey.shade600,
                              ),
                              Text(e['Departement']['name'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.account_circle,
                                color: Colors.grey.shade600,
                              ),
                              Text(e['CreatedBy']['name'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              for (var i in List.generate(e['IssuePriority']['value'], (index) => index))
                                Icon(Icons.star,
                                  color: Colors.grey.shade600,
                                ),
                                Visibility(
                                  visible: e['IssuePriority']['value'] > 3,
                                  child: Chip(label: Text("please pay attention", style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue, ),
                                )
                            ],
                          ),

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
                    );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
