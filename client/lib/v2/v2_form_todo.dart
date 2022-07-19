import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  _onLoad() {
    _tanggalDipilih.value.val = DateTime.now().toLocal().toString();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
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
                      Obx(
                        () => CalendarDatePicker(
                          initialDate: DateTime.parse(_tanggalDipilih.value.val),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                          onDateChanged: (date) async {
                            _tanggalDipilih.value.val = date.toLocal().toString();
                            _tanggalDipilih.refresh();

                            await V2Load.loadTodo(_tanggalDipilih.value.val);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Create New Todo",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      focusNode: _fokusTitle,
                                      controller: _controllerTitle,
                                      maxLength: 50,
                                      maxLines: 1,
                                      decoration: InputDecoration(hintText: "Title", labelText: "Title"),
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

                                        if (body.values.contains("")) {
                                          EasyLoading.showError("Please fill all field");
                                          return;
                                        }

                                        // debugPrint(body.toString());

                                        final kirim = await V2Api.todoCreate().postData(body);

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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: isMobile ? Get.width : 500,
                        height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Obx(
                                () => ListView(
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
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      try {
                                                        final dl = await V2Api.todoDelete().deleteData(td['id']);
                                                        debugPrint(dl.body);
                                                        await V2Load.loadTodo(_tanggalDipilih.value.val);
                                                      } catch (e) {
                                                        debugPrint(e.toString());
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.pink,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              title: Text(td['title'].toString()),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(td['content'].toString()),

                                                  // Text(td['status'].toString()),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        DateFormat("dd MMMM yyyy")
                                                            .format(DateTime.parse(td['createdAt'].toString())),
                                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              trailing: PopupMenuButton(
                                                icon: td['status'] == "open"
                                                    ? Icon(Icons.check_box_outline_blank)
                                                    : Icon(
                                                        Icons.check_box,
                                                        color: Colors.green,
                                                      ),
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
                                                onSelected: (value) async {
                                                  final dataBody = {"id": td['id'], "status": value};
                                                  await V2Api.todoChangeStatus().postData(dataBody);
                                                  await V2Load.loadTodo(_tanggalDipilih.value.val);
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.all(16),
                                                child: iconUpdate(td),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
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

  Widget iconUpdate(td) => IconButton(
        onPressed: () {
          final dateSource = td['createdAt'].toString().obs;
          final title = TextEditingController(text: td['title']);
          final content = TextEditingController(text: td['content']);

          Get.dialog(
            SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CalendarDatePicker(
                      initialDate: DateTime.parse(dateSource.value),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                      onDateChanged: (date) async {
                        dateSource.value = date.toLocal().toString();
                        debugPrint(dateSource.value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: title,
                    maxLength: 1200,
                    decoration: InputDecoration(hintText: "Title", labelText: "Title"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: content,
                    maxLength: 1200,
                    maxLines: 10,
                    decoration: InputDecoration(hintText: "Description", labelText: "Description"),
                  ),
                ),
                 
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () async {
                      final body = {
                        "id": td['id'],
                        "title": title.text,
                        "content": content.text,
                        "createdAt": dateSource.value,
                      };

                      if (body.values.contains("")) {
                        EasyLoading.showError("Please fill all field");
                        return;
                      }

                      final kirim = await V2Api.todoUpdate().postData(body);
                      if (kirim.statusCode == 201) {
                        _tanggalDipilih.value.val = dateSource.value;
                        _tanggalDipilih.refresh();

                        await V2Load.loadTodo(_tanggalDipilih.value.val);
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        icon: Icon(
          Icons.edit,
          color: Colors.blue,
        ),
      );
}
