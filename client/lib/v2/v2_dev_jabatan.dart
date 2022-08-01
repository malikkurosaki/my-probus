import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class V2DevJabatan extends StatelessWidget {
  V2DevJabatan({Key? key}) : super(key: key);
  final _conName = TextEditingController();
  final _refresh = false.obs;

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => SafeArea(
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 500,
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                controller: _conName,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: "Nama Jabatan",
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_conName.text.isEmpty) {
                                EasyLoading.showError("Nama Jabatan tidak boleh kosong");
                                return;
                              }

                              final body = {
                                "name": _conName.text,
                              };

                              final data = await http.post(Uri.parse("${Config.host}/dev-jabatan"), body: body);

                              if (data.statusCode == 201) {
                                EasyLoading.showSuccess("Berhasil menambahkan jabatan");
                                _conName.clear();
                                _refresh.toggle();
                              } else {
                                EasyLoading.showError("Gagal menambahkan jabatan");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                "ADD",
                              ),
                            ),
                          ),
                        ],
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
                          future: http.get(Uri.parse("${Config.host}/dev-jabatan")),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Text("loading ...");
                            final datanya = jsonDecode(snapshot.data!.body);
                            final isEdit = "".obs;

                            return SizedBox(
                              width: 500,
                              child: Obx(
                                () => ListView(
                                  controller: ScrollController(),
                                  children: [
                                    // Text(datanya.toString()),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (final itm in datanya)
                                          isEdit.value == itm['id']
                                              ? Builder(builder: (context) {
                                                final conName = TextEditingController(text: itm['name']);
                                                return ListTile(
                                                  leading: Icon(Icons.edit, color: Colors.cyan,),
                                                  title: TextFormField(
                                                    controller: conName,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      border: OutlineInputBorder(borderSide: BorderSide.none),
                                                      hintText: "Nama Jabatan",
                                                    ),
                                                  ),
                                                  trailing: InkWell(
                                                    onTap: ()async{
                                                      final body = {
                                                        "name": conName.text,
                                                      };

                                                      if (conName.text.isEmpty) {
                                                        EasyLoading.showError("Nama Jabatan tidak boleh kosong");
                                                        return;
                                                      }

                                                      final data = await http.put(Uri.parse("${Config.host}/dev-jabatan/${itm['id']}"), body: body);
                                                      if (data.statusCode == 201) {
                                                        EasyLoading.showSuccess("Berhasil mengubah jabatan");
                                                        isEdit.value = "";
                                                        _refresh.toggle();
                                                      } else {
                                                        EasyLoading.showError("Gagal mengubah jabatan");
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Text("EDIT"),
                                                    ),
                                                  ),
                                                );
                                              })
                                              : ListTile(
                                                  onTap: () {
                                                    isEdit.value = itm['id'];
                                                  },
                                                  leading: Icon(Icons.elevator_outlined, color: Colors.green,),
                                                  title: Text(itm['name'].toString()),
                                                )
                                      ],
                                    )
                                  ],
                                ),
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
          ),
        ),
      ),
    );
  }
}
