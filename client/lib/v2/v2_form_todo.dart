import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_load.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:pasteboard/pasteboard.dart';
import 'v2_routes.dart';

class V2FormTodo extends StatelessWidget {
  V2FormTodo({Key? key}) : super(key: key);
  final _tanggalDipilih = DateTime.now().toString().val("V2FormTodo_tanggalDipilih").obs;
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _fokusTitle = FocusNode();

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Drawer(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: BackButton(
                          onPressed: () => Get.toNamed(V2Routes.home().key),
                        ),
                      ),
                      DrawerHeader(
                        child: V2ImageWidget.logo(),
                      ),
                      CalendarDatePicker(
                        initialDate: DateTime.parse(_tanggalDipilih.value.val),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                        onDateChanged: (date) async {
                          _tanggalDipilih.value.val = date.toString();
                          _tanggalDipilih.refresh();

                          debugPrint(_tanggalDipilih.value.val);

                          await V2Load.loadTodo(_tanggalDipilih.value.val);
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  focusNode: _fokusTitle,
                                  controller: _controllerTitle,
                                  maxLength: 50,
                                  maxLines: 1,
                                  decoration: InputDecoration(hintText: "Title", labelText: "Totle"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _controllerDescription,
                                  maxLength: 1200,
                                  maxLines: 10,
                                  decoration: InputDecoration(hintText: "Description", labelText: "Description"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  color: Colors.cyan,
                                  onPressed: () async {
                                    final body = {
                                      "usersId": V2Val.user.val['id'],
                                      "title": _controllerTitle.text,
                                      "content": _controllerDescription.text,
                                      "createdAt": _tanggalDipilih.value.val
                                    };

                                    // debugPrint(body.toString());

                                    final kirim = await V2Api.todoCreate().postData(body);
                                    debugPrint(kirim.body.toString());

                                    // clear
                                    _controllerTitle.clear();
                                    _controllerDescription.clear();

                                    await V2Load.loadTodo(_tanggalDipilih.value.val);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: isMobile ? Get.width : 500,
                        height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Obx(() => ListView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          DateFormat("EEEE, dd MMMM yyyy")
                                              .format(DateTime.parse(_tanggalDipilih.value.val)),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      for (final td in V2Val.listTodo.value.val)
                                        Card(
                                          child: ListTile(
                                            title: Text(td['title'].toString()),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(td['content'].toString()),
                                                Text(td['createdAt'].toString()),
                                              ],
                                            ),
                                            trailing: PopupMenuButton(
                                              icon: Icon(Icons.check_box_outline_blank),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: "open",
                                                  child: Text("open"),
                                                ),
                                                PopupMenuItem(
                                                  value: "close",
                                                  child: Text("close"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
