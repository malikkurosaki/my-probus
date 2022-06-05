import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/priority.dart';
import 'package:my_probus/homes/select_client.dart';
import 'package:my_probus/homes/select.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeRequestForm extends StatelessWidget {
  HomeRequestForm({Key? key, required this.sizingInformation}) : super(key: key);
  final SizingInformation sizingInformation;
  // final _controller = {
  //   'title': TextEditingController(),
  //   'description': TextEditingController(),
  // };

  final _controllers = {
    'issueType': TextEditingController(),
    'client': TextEditingController(),
    'product': TextEditingController(),
    'departement': TextEditingController(),
    'issuePriority': TextEditingController(),
    'name': TextEditingController(),
    'des': TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          // Container(
          //   color: Colors.grey.shade100,
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       BackButton(),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           "Form Request",
          //           style: TextStyle(
          //             fontSize: 30,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            height: 200,
            child: CachedNetworkImage(imageUrl: '${Conn.host}/images/contribution.png', fit: BoxFit.cover,)
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Form Pengajuan",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                
                Text("Isi form pengajuan untuk mengajukan request ataupun mengajukan bugs, pastikan data yang anda isi benar",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Select(
            title: 'Select Issue Type',
            onSelect: (value) {
              debugPrint(value.toString());
              _controllers['issueType']!.text = value['id'];
            },
            item: Val.issueTypes.value.val,
          ),
          Select(
              title: 'Select Client',
              onSelect: (value) {
                _controllers['client']!.text = value['id'];
              },
              item: Val.clients.value.val),
          Select(
              onSelect: (value) {
                _controllers['product']!.text = value['id'];
              },
              item: Val.products.value.val,
              title: 'Select Product'),
          Select(
              onSelect: (value) {
                _controllers['departement']!.text = value['id'];
              },
              item: Val.departements.value.val,
              title: 'Select Departement'),
          Priority(
            item: Val.issuePriorities.value.val,
            onSelect: (value) {
              _controllers['issuePriority']!.text = value['id'];
            },
            title: 'Select Priority',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controllers['name'],
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                labelText: 'Title',
                hintText: 'masukkan title dari issue anda',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controllers['des'],
              maxLength: 1000,
              maxLines: 10,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'description',
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'cetitakan dengan singkat tentang issue anda'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () async{
                final data = {};
                _controllers.forEach((key, value) {
                  data[key] = value.text;
                });

                if (data.values.contains("")) {
                  EasyLoading.showError("Mohon Lengkapi Semua Datanya");
                  debugPrint(data.toString());
                  return;
                }

                final bodyData = {
                  "name": data['name'],
                  "des": data['des'],
                  "issueTypesId": data['issueType'],
                  "clientsId": data['client'],
                  "productsId": data['product'],
                  "usersId": Val.user.value.val['id'],
                  "issuePrioritiesId": data['issuePriority'],
                  "departementsId": data['departement'],
                };
                
                debugPrint(bodyData.toString());

                final issue = await Conn.issuePost(bodyData);

                try {
                  final berasil = jsonDecode(issue.body)['success'];
                  EasyLoading.showSuccess("Data Berasil Ditambahkan, terima kasih Atas Kontribusinya");
                } catch (e) {
                  EasyLoading.showError("Data Gagal Ditambahkan");
                }


              },
              child: Container(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'AJUKAN',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
