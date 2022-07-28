import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'v2_load.dart';
import 'v2_role.dart';
import 'v2_routes.dart';
import 'v2_val.dart';

class V2IssueList extends StatelessWidget {
  V2IssueList({Key? key}) : super(key: key);

  final _listIssue = V2Val.listIssue.value.val.obs;

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => Scaffold(
        appBar: !isMobile
            ? null
            : AppBar(
                title: Text('Issue List'),
              ),
        drawer: !isMobile? null: _drawer(),
        body:Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () => Get.toNamed(V2Routes.home().key),
                ),
                Text("list Issue"),
              ],
            ),
            // Text(V2Val.listIssue.value.val.toString()),
            Flexible(
              child: Row(
                children: [
                  _drawer(),
                  Expanded(child: Container(
                    alignment: Alignment.topLeft,
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: _item(isMobile),),
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Drawer _drawer() => Drawer(
    elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
              child: V2ImageWidget.logo(),
            ),
           for(final stt in V2Val.listStatus.value.val)
           ListTile(
            leading: Icon(Icons.contactless_sharp, color: Colors.cyan,),
            title: Text(stt['name'].toString().toUpperCase()),
            onTap: (){
              _listIssue.assignAll(V2Val.listIssue.value.val);

            // debugPrint(_listIssue.toString());
              _listIssue.removeWhere((x) => x['IssuesStatus']['id'] != stt['id']);
            },
           )
          ],
        ),
      );

  Widget _item(bool isMobile) => Obx(() => Wrap(
        children: [
          for (final itm in _listIssue)
            SizedBox(
              width: Get.width / (isMobile ? 0 : 3),
              height: 200,
              child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     itm['Client']['name'].toString(),
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 30,
                                  child: Text(itm['idx'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Id Issue"),
                                ),
                                IconButton(
                                    onPressed: () async {

                                      EasyLoading.showInfo("Loading...");
                                      final dl = await V2Api.issueDelete().deleteData(itm['id']);
                                      debugPrint("delete issue: " + itm['id'].toString());
                                      await V2Load.issuegetAll();
                                      EasyLoading.dismiss();

                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.pink,
                                    ))
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itm['name'].toString(),
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      itm['des'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Flexible(
                                      child: Wrap(
                                        children: [
                                          (itm['dateSubmit'] ?? "").toString().isEmpty
                                              ? SizedBox.shrink()
                                              : Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(
                                                      padding: const EdgeInsets.all(2.0),
                                                      label: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(DateFormat('dd/MM/yyyy')
                                                                .format(DateTime.parse(itm['dateSubmit'].toString()))
                                                                .toString()),
                                                          ),
                                                          Chip(
                                                            // daysBetween
                                                            backgroundColor: DateTime.now()
                                                                        .difference(
                                                                            DateTime.parse(itm['dateSubmit'].toString()))
                                                                        .inDays >
                                                                    2
                                                                ? Colors.pink
                                                                : Colors.cyan,
                                                            label: Text(
                                                              timeago.format(
                                                                DateTime.parse(
                                                                  itm['dateSubmit'],
                                                                ),
                                                              ),
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                          // todo : disini error
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Chip(
                                              label: Text((itm['Departement']?['name'] ?? "modul ...").toString()),
                                            ),
                                          ),
                                    
                                          // todo : disini error juga
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Chip(
                                              label: Text((itm['Product']?['name'] ?? "product ...").toString()),
                                            ),
                                          ),
                                    
                                          // todo : disini error
                                          (itm['IssueType']?['name'] ?? "").toString().isEmpty
                                              ? SizedBox.shrink()
                                              : Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Chip(
                                                    backgroundColor: itm['IssueType']?['name'].toString() == "bug"
                                                        ? Colors.orange
                                                        : Colors.grey.shade100,
                                                    label: Text((itm['IssueType']?['name'] ?? "").toString()),
                                                  ),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Chip(
                                              label: Text((itm['CreatedBy']?['name'] ?? "Create By ...").toString()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Chip(
                                                label: Text((itm['IssuesStatus']?['name'] ?? "status ...").toString())),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // todo : add button accept or reject
                            // V2Val.homeControll.acceptOrRejectButton()
                            // V2Role().buttonStatusByRole(itm['id'])
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MaterialButton(
                          textColor: Colors.cyan,
                          child: Text("Detail"),
                          onPressed: () async {

                            EasyLoading.showInfo("Loading...");
                            V2Val.detailControll.content.value.val = itm;
                            V2Val.selectedIssueId.value.val = itm['id'];
                            debugPrint(V2Val.selectedIssueId.value.val.toString());
                            await V2Load.loadDiscutionByIssueId();
                            Get.toNamed(V2Routes.issueDetail().key);
                            EasyLoading.dismiss();

                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ));
}
