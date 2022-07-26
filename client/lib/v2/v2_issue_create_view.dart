import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/skt.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_issue_type.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_select_date.dart';
import 'package:my_probus/v2/v2_select_future.dart';
import 'package:my_probus/v2/v2_select_image.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class V2IssueCreateView extends StatelessWidget {
  V2IssueCreateView({Key? key}) : super(key: key);
  final _date = DateTime.now().toString().val("V2IssueCreate_date").obs;
  final _image = [].val("V2IssueCreate_image").obs;
  final _type = {}.val("V2IssueCreat_type").obs;
  final _client = {}.val("V2IssueCreate_client").obs;
  final _product = {}.val("V2IssueCreate_product").obs;
  final _module = {}.val("V2IssueCreate_module").obs;
  final _title = "".val("V2IssueCreate_title").obs;
  final _description = "".val("V2IssueCreate_description").obs;
  final _refresh = false.obs;
  final _imgFocusNode = FocusNode();

  _clearContent() async {
    _date.value.val = DateTime.now().toString();
    _image.value.val = [];
    _type.value.val = {};
    _client.value.val = {};
    _product.value.val = {};
    _module.value.val = {};
    _title.value.val = "";
    _description.value.val = "";

    _refresh.toggle();
    await 0.1.delay();
    _refresh.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () => Get.offNamed(V2Routes.home().key),
                ),
              ],
            ),
            Flexible(
              child: Row(
                children: [
                  // Center(child: V2ImageWidget.logo()),
                  // // backdrop filter
                  // BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  //   child: Container(
                  //     color: Colors.black.withOpacity(0.5),
                  //   ),
                  // ),
                  Visibility(
                    visible: !isMobile,
                    child: Drawer(
                      elevation: 0,
                      child: ListView(
                        children: [
                          DrawerHeader(
                              child: Column(
                            children: [
                              V2ImageWidget.logo(),
                            ],
                          )),
                          ListTile(
                            leading: Icon(Icons.clear_all_outlined, color: Colors.cyan),
                            title: Text("Clear Content"),
                            onTap: () => _clearContent(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => _refresh.value
                          ? ListView()
                          : Card(
                            color: Colors.grey[100],
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: ListView(
                                        controller: ScrollController(keepScrollOffset: false),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Create Issue",
                                              style: TextStyle(
                                                fontSize: isMobile ? 30 : 40,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                          
                                          // select date
                                          V2SelectDate(value: _date),
                          
                                          V2SelectImage(values: _image),
                          
                                          // select type
                                          // _selectFuture(V2Api.type().getData(), "Select Type"),
                                          V2SelectFuture(
                                              hint: "Select Type", sources: V2Val.listType.value.val, value: _type),
                          
                                          // select client
                                          // _selectFuture(V2Api.client().getData(), "Select Client"),
                                          V2SelectFuture(
                                              hint: "Select Client ",
                                              sources: V2Val.listClient.value.val,
                                              value: _client),
                          
                                          // select product
                                          // _selectFuture(V2Api.products().getData(), "Select Product"),
                                          V2SelectFuture(
                                              hint: "Select Product",
                                              sources: V2Val.listProduct.value.val,
                                              value: _product),
                          
                                          // module
                                          // _selectFuture(V2Api.modules().getData(), "Select Module"),
                                          V2SelectFuture(
                                              hint: "Select Module", sources: V2Val.listModule.value.val, value: _module),
                          
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 18),
                                            child: TextFormField(
                                              onChanged: (value) => _title.value.val = value,
                                              controller: TextEditingController(text: _title.value.val),
                                              maxLength: 120,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                hintText: "Title",
                                                label: Text("Title"),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 18),
                                            child: TextFormField(
                                              onChanged: (value) => _description.value.val = value,
                                              controller: TextEditingController(text: _description.value.val),
                                              maxLength: 5000,
                                              maxLines: 10,
                                              decoration: InputDecoration(
                                                hintText: "Description",
                                                label: Text("Description"),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: MaterialButton(
                                              color: Colors.cyan,
                                              child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    "Create",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                              onPressed: () async {
                                                EasyLoading.showInfo("loading ...");

                                                final data = {
                                                  "name": _title.value.val,
                                                  "des": _description.value.val,
                                                  "issueTypesId": _type.value.val['id'],
                                                  "issueStatusesId": "1",
                                                  "clientsId": _client.value.val['id'],
                                                  "productsId": _product.value.val['id'],
                                                  "usersId": V2Val.user.val['id'],
                                                  "departementsId": _module.value.val['id'],
                                                  "dateSubmit": _date.value.val,
                                                };
                                                final body = {
                                                  "data": jsonEncode(data),
                                                  "images": jsonEncode(_image.value.val),
                                                };
                          
                                                if (body.values.contains("")) {
                                                  Get.dialog(AlertDialog(
                                                    title: Text("Isi Semua Jangan Ada Yang Kosong Ya ..."),
                                                    content: V2ImageWidget.kecewa(),
                                                    actions: [
                                                      MaterialButton(child: Text("OK"), onPressed: () => Get.back())
                                                    ],
                                                  ));
                                                  return;
                                                }
                          
                                                final issue = await V2Api.issueCreate().postData(body);
                                                if (issue.statusCode == 200) {
                                                  await Get.dialog(AlertDialog(
                                                    title: Text("Terimakasih Atas Kontribusinya"),
                                                    content: V2ImageWidget.jempol(height: 200),
                                                    actions: [
                                                      MaterialButton(child: Text("OK"), onPressed: () => Get.back())
                                                    ],
                                                  ));
                          
                                                  V2Val.homeControll.loadIssueDashboard();
                          
                                                  //  Skt.notifWithIssue(
                                                  //   title: "new message",
                                                  //   content: "new Image Message",
                                                  //   jenis: "msg",
                                                  // );
                          
                                                  _clearContent();

                                                  EasyLoading.dismiss();
                                                } else {
                                                  EasyLoading.showError(issue.body.toString());
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                          ),
                    ),
                  ),
                  Visibility(
                    visible: isDesktop,
                    child: Drawer(
                      elevation: 0,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Note"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _selectFuture(Future<http.Response> future, String hint) =>

}
