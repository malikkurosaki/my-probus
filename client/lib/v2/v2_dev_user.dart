import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';
import 'v2_ismobile_widget.dart';
import 'package:get/get.dart';

class V2DevUser extends StatelessWidget {
  V2DevUser({Key? key}) : super(key: key);
  final _refresh = false.obs;

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) {
        return Column(
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
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              child: Obx(() => Column(
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
                                ? Container()
                                : Obx(
                                    () => ListView(
                                      controller: ScrollController(),
                                      children: [
                                        for (final itm in jsonDecode((snapshot.data!.body)))
                                          edit.value == itm['id']
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
                                                                          controller:
                                                                              TextEditingController(text: itm['name']),
                                                                        ),
                                                                        Divider(),
                                                                        TextFormField(
                                                                          onChanged: (value) => body['email'] = value,
                                                                          decoration: InputDecoration(
                                                                            border: InputBorder.none,
                                                                            fillColor: Colors.grey[200],
                                                                            filled: true,
                                                                          ),
                                                                          controller:
                                                                              TextEditingController(text: itm['email']),
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
                                                      ),
                                                    ),
                                                  ],
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
                          }),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        );
      },
    );
  }
}
