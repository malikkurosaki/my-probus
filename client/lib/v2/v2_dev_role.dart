import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';
import 'package:get/get.dart';

class V2DevRole extends StatelessWidget {
  V2DevRole({Key? key}) : super(key: key);
  final _textController = TextEditingController();
  final _refresh = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: 360,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: _textController,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                            )),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_textController.text.isEmpty) {
                            EasyLoading.showError("tidak memungkinkan nama kosong");
                            return;
                          }

                          EasyLoading.showInfo('Loading...');

                          http.post(Uri.parse('${Config.host}/dev-role'), body: {"name": _textController.text}).then(
                              (data) {
                            if (data.statusCode == 201) {
                              EasyLoading.dismiss();
                              EasyLoading.showSuccess("success");
                              _refresh.toggle();
                            } else {
                              EasyLoading.showError("failed");
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Flexible(
          child: Obx(
            () => Column(
              children: [
                Visibility(
                  visible: false,
                  child: Text(_refresh.value.toString()),
                ),
                Flexible(
                  child: FutureBuilder<http.Response>(
                    future: http.get(Uri.parse('${Config.host}/dev-role')),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text("loading ...");
                      final datanya = jsonDecode(snapshot.data!.body);
                      final apa = "".obs;
                      final roleName = "".obs;
                      return Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(datanya.toString()),
                            for (final itm in datanya)
                              apa.value == itm['id']
                                  ? Row(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: SizedBox(
                                              width: 360,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("edit"),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (value) => roleName.value = value,
                                                          controller: TextEditingController(text: itm['name']),
                                                          decoration: InputDecoration(
                                                            filled: true,
                                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                                            hintText: 'name',
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          EasyLoading.showInfo('Loading...');
                                                          http.put(Uri.parse('${Config.host}/dev-role/${apa.value}'),
                                                              body: {"name": roleName.value}).then((data) {
                                                            if (data.statusCode == 201) {
                                                              EasyLoading.dismiss();
                                                              EasyLoading.showSuccess("success");
                                                              _refresh.toggle();
                                                            } else {
                                                              EasyLoading.showError("failed");
                                                            }
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16),
                                                          child: Text(
                                                            "SAVE",
                                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : ListTile(
                                      onTap: () {
                                        apa.value = itm['id'];
                                      },
                                      leading: Icon(
                                        Icons.add_moderator_rounded,
                                        color: Colors.cyan,
                                      ),
                                      title: Text(itm['name']),
                                    )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
