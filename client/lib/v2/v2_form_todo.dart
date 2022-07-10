import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
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
          // Padding(
          //   padding: const EdgeInsets.all(60),
          //   child: RawKeyboardListener(
          //     focusNode: _fokusTitle,
          //     child: Text("halo"),
          //     onKey: (x) async {
          //       if (x.isControlPressed && x.character == "v" || x.isMetaPressed && x.character == "v") {
          //         final imageBytes = await Pasteboard.image;
          //         print(imageBytes?.length);
          //       }
          //     },
          //   ),
          // ),
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
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                        onDateChanged: (date) {
                          _tanggalDipilih.value.val = date.toString();
                          _tanggalDipilih.refresh();
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Obx(
                      () => Text(_tanggalDipilih.value.val),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.cyan,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
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
                                    onPressed: () {
                                      final body = {
                                        "title": _controllerTitle.text,
                                        "description": _controllerDescription.text,
                                        "date": _tanggalDipilih.value.val,
                                        "userId": V2Val.user.val['id'],
                                      };

                                      debugPrint(body.toString());

                                      // clear
                                      _controllerTitle.clear();
                                      _controllerDescription.clear();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(
                                          "Add",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: isMobile ? Get.width : 500,
                          child: Column(
                            children: [Text("ini adalah listnya")],
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
