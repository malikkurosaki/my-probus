import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/input.dart';
import 'package:my_probus/homes/priority.dart';
import 'package:my_probus/homes/select_client.dart';
import 'package:my_probus/homes/select.dart';
import 'package:my_probus/homes/ambil_gambar.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_builder/responsive_builder.dart';

// final _controllers = {
//   'issueType': TextEditingController(),
//   'client': TextEditingController(),
//   'product': TextEditingController(),
//   'departement': TextEditingController(),
//   'issuePriority': TextEditingController(),
//   'name': TextEditingController(),
//   'des': TextEditingController()
// };

class HomeRequestForm extends StatelessWidget {
  HomeRequestForm({Key? key, required this.sizingInformation}) : super(key: key);
  final SizingInformation sizingInformation;
  // final _controller = {
  //   'title': TextEditingController(),
  //   'description': TextEditingController(),
  // };

  final _issueType = {}.val('form_issueType').obs;
  final _client = {}.val('form_client').obs;
  final _product = {}.val('form_product').obs;
  final _departement = {}.val('form_departement').obs;
  final _issuePriority = {}.val('form_issuePriority').obs;

  final _name = TextEditingController();
  final _des = TextEditingController();
  final _isNameOk = false.obs;
  final _isDesOk = false.obs;
  final _files = [].val('HomeRequestForm_files').obs;

  _onLoad() async {
    // Conn().loadDepartement();
    debugPrint("bergoang");
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      child: Obx(
        () => ListView(
          controller: ScrollController(),
          children: [
            SizedBox(
              height: 200,
              child: CachedNetworkImage(
                imageUrl: '${Conn().host}/images/contribution.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(sizingInformation.isMobile ? 0 : 20),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: '${Conn().host}/images/form.png',
                            fit: BoxFit.cover,
                            height: 70,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Form Pengajuan",
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Isi form pengajuan untuk mengajukan request ataupun mengajukan bugs, pastikan data yang anda isi benar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Select(
                      subtitle: 'Pilih jenis issue yang akan anda ajukan',
                      value: _issueType.value.val,
                      title: 'Select Issue Type',
                      onSelect: (value) {
                        debugPrint(value.toString());
                        _issueType.value.val = value;
                        _issueType.refresh();
                      },
                      item: Val.issueTypes.value.val,
                    ),
                    Select(
                      subtitle: 'Pilih client yang akan anda ajukan',
                      value: _client.value.val,
                      title: 'Select Client',
                      onSelect: (value) {
                        _client.value.val = value;
                        _client.refresh();
                      },
                      item: Val.clients.value.val,
                    ),
                    Select(
                      subtitle: 'Pilih product yang akan anda ajukan',
                      value: _product.value.val,
                      onSelect: (value) {
                        _product.value.val = value;
                        _product.refresh();
                      },
                      item: Val.products.value.val,
                      title: 'Select Product',
                    ),
                    Select(
                      subtitle: 'Pilih module yang akan anda tujukan untuk request / bug yang akan anda ajukan',
                      value: _departement.value.val,
                      onSelect: (value) {
                        _departement.value.val = value;
                        _departement.refresh();
                      },
                      item: Val.departements.value.val,
                      title: 'Select Module',
                    ),
                    AmbilGambar(
                      values: _files,
                    ),

                    // InputImage(),
                    // Priority(
                    //   subtitle: 'pilih tingkat prioritas yang sesuai untuk menggambarkan issue anda',
                    //   value: _issuePriority.value.val,
                    //   item: Val.issuePriorities.value.val,
                    //   onSelect: (value) {
                    //     _issuePriority.value.val = value;
                    //     _issuePriority.refresh();
                    //   },
                    //   title: 'Select Priority',
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Icon(
                                Icons.check_box,
                                color: _isNameOk.value ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  onChanged: (value) => _isNameOk.value = value.length > 10,
                                  maxLength: 120,
                                  controller: _name,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: InputBorder.none,
                                    labelText: 'Title',
                                    hintText: 'masukkan title dari issue anda',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'berisi judul secara singkat yang cocok menggambarkan issue anda',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Icon(
                                Icons.check_box,
                                color: _isDesOk.value ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  onChanged: (value) => _isDesOk.value = value.length > 10,
                                  controller: _des,
                                  maxLength: 1000,
                                  maxLines: 10,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelText: 'description',
                                      border: InputBorder.none,
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: 'cetitakan dengan singkat tentang issue anda'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'berisi deskripsi secara singkat yang cocok menggambarkan issue anda',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () async {
                          final bodyData = {
                            "name": _name.text,
                            "des": _des.text,
                            "issueTypesId": _issueType.value.val['id'],
                            "clientsId": _client.value.val['id'],
                            "productsId": _product.value.val['id'],
                            "usersId": Val.user.value.val['id'],
                            // "issuePrioritiesId": _issuePriority.value.val['id'],
                            "departementsId": _departement.value.val['id'],
                            "issueStatusesId": "1",
                          };

                          if (bodyData.values.contains("")) {
                            EasyLoading.showError("Mohon Lengkapi Semua Datanya");

                            return;
                          }

                          // debugPrint(bodyData.toString());

                          final body = {
                            "data": jsonEncode(bodyData),
                            "files": jsonEncode(_files.value.val),
                          };
                          

                          final issue = await Conn().issuePost(body);
                          
                          if (issue.statusCode == 201) {
                            await Get.dialog(
                              AlertDialog(
                                title: Text("Success"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: '${Conn().host}/images/jempol.png',
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                    Text("Halo ${Val.user.value.val['name']},  Issue anda berhasil dikirimkan ",
                                        style:
                                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                                    Text("Terimakasih atas kontribusinya",
                                        style:
                                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                                  ],
                                ),
                                actions: [
                                  MaterialButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  )
                                ],
                              ),
                            );

                            _name.clear();
                            _des.clear();
                            _issueType.value.val = {};
                            _client.value.val = {};
                            _product.value.val = {};
                            // _issuePriority.value.val = {};
                            _departement.value.val = {};
                            _issueType.refresh();
                            _client.refresh();
                            _product.refresh();
                            // _issuePriority.refresh();
                            _departement.refresh();
                            _isNameOk.value = false;
                            _isDesOk.value = false;
                            _files.value.val = [];
                            _files.refresh();

                            // EasyLoading.showSuccess("Data Berasil Ditambahkan, terima kasih Atas Kontribusinya");

                          } else {
                            debugPrint(issue.body.toString());
                            EasyLoading.showError("Gagal ${issue.statusCode}");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              'AJUKAN',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
