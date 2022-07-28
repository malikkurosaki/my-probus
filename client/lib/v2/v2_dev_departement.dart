import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';

class V2DevDepartement extends StatelessWidget {
  V2DevDepartement({Key? key}) : super(key: key);

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
                              focusColor: Colors.blue,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'name'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_textController.text.isEmpty) {
                            EasyLoading.showError("tidak memungkinkan nama kosong");
                            return;
                          }

                          EasyLoading.showInfo('Loading...');

                          http.post(Uri.parse('${Config.host}/dev-departement'),
                              body: {"name": _textController.text}).then((data) {
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
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => Flexible(
            child: Column(
              children: [
                Visibility(
                  visible: false,
                  child: Text(_refresh.value.toString()),
                ),
                Flexible(
                  child: FutureBuilder<http.Response>(
                    future: http.get(Uri.parse(Config.host + '/dev-departement')),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text("loading ...");
                      final datanya = jsonDecode(snapshot.data!.body);
                      final apa = "".obs;
                      final namaClient = "".obs;
                      return Obx(
                        () => ListView(
                          controller: ScrollController(),
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
                                                    child: Text("Edit"),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (value) => namaClient.value = value,
                                                          controller: TextEditingController(text: itm['name']),
                                                          decoration: InputDecoration(
                                                            filled: true,
                                                            focusColor: Colors.blue,
                                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                                            hintText: 'name',
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (namaClient.value.isEmpty) {
                                                            EasyLoading.showError("tidak memungkinkan nama kosong");
                                                            return;
                                                          }
                                                          EasyLoading.showInfo('Loading...');
                                                          final response = await http.put(
                                                              Uri.parse('${Config.host}/dev-departement/${itm['id']}'),
                                                              body: {"name": namaClient.value});
                                                          if (response.statusCode == 201) {
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
                                                            "SAVE",
                                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : ListTile(
                                      leading: Icon(
                                        Icons.store,
                                        color: Colors.cyan,
                                      ),
                                      title: Text(itm['name'].toString()),
                                      onTap: () {
                                        apa.value = itm['id'].toString();
                                      },
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
