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
  final _listDepartement = [].obs;
  final _listJabatan = [].obs;

  _loadJabatan() async {
    final data = await http.get(Uri.parse("${Config.host}/dev-jabatan"));
    final json = jsonDecode(data.body);
    _listJabatan.assignAll(json);
  }

  _loadDepartement() async {
    final data = await http.get(Uri.parse("${Config.host}/dev-departement"));
    final json = jsonDecode(data.body);
    _listDepartement.assignAll(json);
  }

  @override
  Widget build(BuildContext context) {
    _loadJabatan();
    _loadDepartement();
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => SafeArea(
        child: Material(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Set Jabatan > Module / Departement",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Obx(
                        () => ListView(
                          controller: ScrollController(),
                          children: [
                            for (final jabatan in _listJabatan)
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        jabatan["name"],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        for (final dep in _listDepartement)
                                          Builder(
                                            builder: (context) {
                                              bool selected = List.from(jabatan['JabatanDepartement'])
                                                  .map((e) => (e['Departement']?['id'] ?? "").toString())
                                                  .toList()
                                                  .contains(dep['id'].toString());
                                              return ListTile(
                                                leading: Icon(
                                                  Icons.check_box,
                                                  color: selected ? Colors.green : Colors.grey,
                                                ),
                                                title: Text(dep["name"]),
                                                onTap: () async {
                                                  EasyLoading.showInfo("Loading...");
                                                  selected = !selected;
                                                  final body = {
                                                    "id": dep["id"].toString(),
                                                    "jabatansId": jabatan["id"].toString(),
                                                    "departementsId": dep["id"].toString()
                                                  };

                                                  final setDep = await http.post(
                                                      Uri.parse("${Config.host}/dev-jabatan-departement"),
                                                      body: body);

                                                  if (setDep.statusCode == 201) {
                                                    await _loadJabatan();
                                                    await _loadDepartement();
                                                    EasyLoading.dismiss();
                                                  } else {
                                                    EasyLoading.showError("Error: ${setDep.statusCode}");
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isDesktop,
                child: SizedBox(
                  width: isMobile ? Get.width : 360,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Create / Edit Jabatan",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
              
                                      _loadJabatan();
                                      _loadDepartement();
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
                                                            leading: Icon(
                                                              Icons.edit,
                                                              color: Colors.cyan,
                                                            ),
                                                            title: TextFormField(
                                                              controller: conName,
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                                hintText: "Nama Jabatan",
                                                              ),
                                                            ),
                                                            trailing: InkWell(
                                                              onTap: () async {
                                                                final body = {
                                                                  "name": conName.text,
                                                                };
              
                                                                if (conName.text.isEmpty) {
                                                                  EasyLoading.showError(
                                                                      "Nama Jabatan tidak boleh kosong");
                                                                  return;
                                                                }
              
                                                                final data = await http.put(
                                                                    Uri.parse("${Config.host}/dev-jabatan/${itm['id']}"),
                                                                    body: body);
                                                                if (data.statusCode == 201) {
                                                                  EasyLoading.showSuccess("Berhasil mengubah jabatan");
                                                                  isEdit.value = "";
                                                                  _refresh.toggle();
                                                                } else {
                                                                  EasyLoading.showError("Gagal mengubah jabatan");
                                                                }
              
                                                                _loadJabatan();
                                                                _loadDepartement();
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(16.0),
                                                                child: Text("UPDATE"),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                      : ListTile(
                                                          onTap: () {
                                                            isEdit.value = itm['id'];
                                                          },
                                                          leading: Icon(
                                                            Icons.elevator_outlined,
                                                            color: Colors.green,
                                                          ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
