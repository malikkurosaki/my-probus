import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_config.dart';

class V2DevClient extends StatelessWidget {
  V2DevClient({Key? key}) : super(key: key);
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
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _textController,
                              decoration: InputDecoration(
                                  filled: true,
                                  focusColor: Colors.blue,
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: 'name'),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              EasyLoading.showInfo('Loading...');
                              if (_textController.text.isEmpty) {
                                EasyLoading.showError("请先清空");
                                return;
                              }

                              final data = await http
                                  .post(Uri.parse('${Config.host}/dev-client'), body: {"name": _textController.text});
                              if (data.statusCode == 201) {
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess("success");
                                _refresh.toggle();
                              } else {
                                EasyLoading.showError("failed");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "ADD",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan),
                              ),
                            ),
                          )
                        ],
                      ),
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
                Visibility(visible: false, child: Text(_refresh.value.toString())),
                Flexible(
                  child: FutureBuilder<http.Response>(
                    future: http.get(Uri.parse(Config.host + '/dev-client')),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      final datanya = jsonDecode(snapshot.data!.body);
                      final apa = "".obs;
                      final namaClient = "".obs;
                      debugPrint("load data");
                      return Obx(
                        () => ListView(
                          controller: ScrollController(),
                          children: [
                            for (final itm in datanya)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  apa.value == itm['id']
                                      ? Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: SizedBox(
                                              width: 360,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("Edit"),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (value) {
                                                            namaClient.value = value;
                                                          },
                                                          controller: TextEditingController(text: itm['name']),
                                                          decoration: InputDecoration(
                                                            fillColor: Colors.grey[200],
                                                            filled: true,
                                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final edit = await http.put(
                                                              Uri.parse('${Config.host}/dev-client/${itm['id']}'),
                                                              body: {"name": namaClient.value});
                                                          if (edit.statusCode == 201) {
                                                            EasyLoading.showSuccess("berhasil");
                                                            apa.value = "";
                                                            _refresh.toggle();
                                                          } else {
                                                            EasyLoading.showError("gagal");
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16.0),
                                                          child: Text(
                                                            "SAVE",
                                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : ListTile(
                                          onTap: () {
                                            apa.value = itm['id'];

                                            debugPrint(apa.value);
                                          },
                                          leading: Icon(
                                            Icons.home_filled,
                                            color: Colors.cyan,
                                          ),
                                          title: Text(itm['name'].toString()),
                                        )
                                ],
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
