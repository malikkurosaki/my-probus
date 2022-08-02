import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';
import 'v2_ismobile_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class V2DevUser extends StatelessWidget {
  V2DevUser({Key? key}) : super(key: key);
  final _refresh = false.obs;
  final _conName = TextEditingController();

  final _listUser = [].obs;
  final _listJabatan = [].obs;

  _loadJabatan() async {
    final jabatan = await http.get(Uri.parse(Config.host + '/dev-jabatan'));
    final json = jsonDecode(jabatan.body);
    _listJabatan.assignAll((json));
  }

  _loadUser() async {
    final user = await http.get(Uri.parse(Config.host + '/dev-user'));
    final json = jsonDecode(user.body);
    _listUser.assignAll((json));
  }

  @override
  Widget build(BuildContext context) {
    _loadUser();
    _loadJabatan();
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Set User Jabatan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView(
                        controller: ScrollController(),
                        children: [
                          for (final usr in _listUser)
                            Builder(
                              builder: (context) {
                                final visible = false.val(usr['name'].toString()).obs;
                                return Obx(
                                  () => Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.account_circle,
                                            size: 32,
                                            color: Colors.cyan,
                                          ),
                                          title: Text(
                                            usr['name'].toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              visible.value.val = !visible.value.val;
                                              visible.refresh();

                                              debugPrint(visible.value.toString());
                                            },
                                            icon: Icon(Icons.arrow_drop_down),
                                            
                                          ),
                                          subtitle: Wrap(
                                            children: [
                                              for (final jab in usr['UserJabatan'])
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Chip(
                                                  label: Text(jab['Jabatan']['name'].toString()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: visible.value.val,
                                          child: Column(
                                            children: [
                                              for (final jbt in _listJabatan)
                                                Builder(
                                                  builder: (context) {
                                                    final selected = List.from(usr['UserJabatan'])
                                                        .map((e) => e['jabatansId'])
                                                        .toList()
                                                        .contains(jbt['id']);



                                                    return ListTile(
                                                      leading: Icon(
                                                        Icons.check_box,
                                                        color: selected ? Colors.green : Colors.grey,
                                                      ),
                                                      title: Text(jbt['name'].toString()),
                                                      onTap: () async {
                                                        final body = {"jabatansId": jbt['id'], "usersId": usr['id']};
                                                        final data = await http.post(
                                                            Uri.parse('${Config.host}/dev-user-jabatan'),
                                                            body: body);

                                                        if (data.statusCode == 201) {
                                                          await _loadUser();
                                                          await _loadJabatan();
                                                          EasyLoading.showInfo("success");
                                                        } else {
                                                          EasyLoading.showError("faied");
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  )
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
                      child: Text("Create User",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _conName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: 'type here add user',
                                ),
                              ),
                            ),
                            MaterialButton(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'ADD',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () async {
                                final body = <String, String>{
                                  "name": _conName.text,
                                };
            
                                if (body.values.contains("")) {
                                  EasyLoading.showError("tidak boleh kosong");
                                  return;
                                }
            
                                final data = await http.post(Uri.parse(Config.host + '/dev-user'), body: body);
                                if (data.statusCode == 201) {
                                  EasyLoading.showSuccess("Success");
                                  _conName.clear();
                                  _refresh.toggle();
                                  return;
                                }
            
                                EasyLoading.showError("Failed");
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Obx(
                        () => Column(
                          children: [
                            Visibility(
                              visible: false,
                              child: Text(_refresh.value.toString()),
                            ),
                            Expanded(
                              child: FutureBuilder<http.Response>(
                                future: http.get(Uri.parse('${Config.host}/dev-user')),
                                builder: ((context, snapshot) {
                                  final edit = "".obs;
                                  final body = <String, dynamic>{"name": "", "email": ""}.obs;
            
                                  return !snapshot.hasData
                                      ? Row(
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        )
                                      : Builder(
                                          builder: (context) {
                                            final datanya = List.from(jsonDecode(snapshot.data!.body));
                                            datanya.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
                                            return Obx(
                                              () => ListView(
                                                controller: ScrollController(),
                                                children: [
                                                  for (final itm in datanya)
                                                    edit.value == itm['id']
                                                        ? Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(2.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text("Edit"),
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              onChanged: (value) => body['name'] = value,
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                fillColor: Colors.grey[200],
                                                                                filled: true,
                                                                              ),
                                                                              controller: TextEditingController(
                                                                                  text: itm['name']),
                                                                            ),
                                                                            Divider(),
                                                                            TextFormField(
                                                                              onChanged: (value) => body['email'] = value,
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                fillColor: Colors.grey[200],
                                                                                filled: true,
                                                                              ),
                                                                              controller: TextEditingController(
                                                                                  text: itm['email']),
                                                                            ),
                                                                            // Divider(),
                                                                            // TextFormField(
                                                                            //   decoration: InputDecoration(
                                                                            //     border: InputBorder.none,
                                                                            //     fillColor: Colors.grey[200],
                                                                            //     filled: true,
                                                                            //   ),
                                                                            //   controller: TextEditingController(text: itm['password']),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          MaterialButton(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(14.0),
                                                                              child: Text(
                                                                                'SAVE',
                                                                                style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onPressed: () async {
                                                                              EasyLoading.showInfo('Saving...');
                                                                              final upd = await http.put(
                                                                                Uri.parse(
                                                                                    '${Config.host}/dev-user/${itm['id']}'),
                                                                                body: {
                                                                                  "name": body['name'],
                                                                                  "email": body['email'],
                                                                                },
                                                                              );
            
                                                                              if (upd.statusCode == 201) {
                                                                                _refresh.toggle();
                                                                                EasyLoading.dismiss();
                                                                                EasyLoading.showSuccess('Success');
                                                                                return;
                                                                              }
            
                                                                              EasyLoading.dismiss();
                                                                              EasyLoading.showError('Error');
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : ListTile(
                                                            leading: Icon(Icons.person, color: Colors.cyan),
                                                            title: Text(itm['name']),
                                                            subtitle: Text(itm['email']),
                                                            onTap: () {
                                                              edit.value = itm['id'];
                                                              body.value = itm;
                                                            },
                                                          )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                }),
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
        );
      },
    );
  }
}
