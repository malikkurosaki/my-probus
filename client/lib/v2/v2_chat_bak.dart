import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/v2/v2_future_widget.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_storage.dart';
import 'v2_api.dart';
import 'v2_config.dart';
import 'v2_val.dart';

class V2ChatBak extends StatefulWidget {
  const V2ChatBak({Key? key}) : super(key: key);
  @override
  State<V2ChatBak> createState() => _V2ChatBakState();
}

class _V2ChatBakState extends State<V2ChatBak> {
  bool _showDetail = false;
  Map _issueValue = {};
  List _listDiscution = [];
  final _scrollController = ScrollController();
  final _fokus = FocusNode();
  final _contentText = TextEditingController();

  bool _load = true;
  int berapa = 0;

  _onLoad() {
    if (_load) {
      V2Api.issueById().getByParams(V2Val.issueDetailId.value.val).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          _issueValue = data;
          setState(() {});

          print("terjadi pengulangan $berapa");
        }

        print("cek pengulangan $berapa");
      });

      V2Api.discutionByIssueId().getByParams(V2Val.issueDetailId.value.val).then((response) {
        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          _listDiscution = data;
          setState(() {});
        }
      });

      _load = false;
    }

    berapa++;
  }

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return FutureBuilder(
      future: _onLoad(),
      builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
      Text("loading ...")
      : V2IsMobileWidget(
                isMobile: (isMobile) => Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        _showDetail = true;
                        setState(() {});
                      }),
                      child: Container(
                        color: Colors.cyan,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24,
                                child: Text(
                                  _issueValue['idx'].toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _issueValue['name'].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      _issueValue['des'].toString(),
                                      style: TextStyle(color: Colors.grey.shade200, fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          V2ImageWidget.chatBgV2(width: double.infinity),
                          // ListView(
                          //         addAutomaticKeepAlives: true,
                          //         controller: _scrollController,
                          //         children: [
                          //           for (final itm in _listDiscution)
                          //             Builder(builder: (context) {
                          //               try {
                          //                 return _chatItem(isMobile, itm);
                          //               } catch (e) {
                          //                 return Text("loading");
                          //               }
                          //             })
                          //         ],
                          //       )
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.cyan,
                      elevation: 0,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final data = await _singleImageUploadHandler();
                                if (data != null) {
                                  final img = Map.from(jsonDecode(data));
                                  final con = {
                                    "content": "",
                                    "issuesId": _issueValue['id'],
                                    "usersId": V2Val.user.value.val["id"],
                                    "imagesId": img['data']['id']
                                  };

                                  final body = {"type": "image", "dataImage": jsonEncode(con)};
                                  final discution = await V2Api.discutionCreate().postData(body);

                                  _listDiscution.add(Map.from(jsonDecode(discution.body)));

                                  _fokus.requestFocus();

                                  _scrollController.animateTo(_scrollController.position.maxScrollExtent + 200,
                                      duration: Duration(milliseconds: 500), curve: Curves.ease);
                                } else {
                                  EasyLoading.showToast("hemmm ...");
                                }
                              },
                              icon: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                focusNode: _fokus,
                                controller: _contentText,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.cyan.shade300,
                                  filled: true,
                                  hintText: "Tulis sesuatu",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                onSubmitted: (value) async {
                                  if (_contentText.text.isEmpty) {
                                    EasyLoading.showToast("Tulis sesuatu");
                                    _fokus.requestFocus();
                                    return;
                                  }

                                  final con = {
                                    "content": _contentText.text,
                                    "issuesId": _issueValue['id'],
                                    "usersId": V2Storage.user.val["id"]
                                    //imagesId
                                  };

                                  final body = {"type": "text", "dataText": jsonEncode(con)};

                                  final discution = await V2Api.discutionCreate().postData(body);

                                  try {
                                    setState(() {});
                                    _listDiscution.add(Map.from(jsonDecode(discution.body)));
                                    _contentText.clear();
                                    _fokus.requestFocus();
                                    _scrollController.animateTo(_scrollController.position.maxScrollExtent + 50,
                                        duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  } catch (e) {
                                    print("hahaha");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
    )
    ;
  }

  Widget _chatItem(bool isMobile, Map itm) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: isMobile ? double.infinity : Get.width / 1.5,
            child: Row(
              mainAxisAlignment: (itm["User"]?['id'] ?? "a") == V2Storage.user.val['id']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: Get.width / (isMobile ? 2 : 3)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: (itm["User"]['id'] ?? "a") == V2Val.user.value.val['id']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            itm["User"]['name'].toString(),
                            style: TextStyle(color: Colors.cyan, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: itm['imagesId'] != null
                              ? CachedNetworkImage(
                                  imageUrl: V2Config.host + "/image/" + itm['Image']['name'].toString(),
                                  fit: BoxFit.cover,
                                )
                              : Text(itm['content'].toString()),
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

  Future<String?> _singleImageUploadHandler() async {
    final upload = http.MultipartRequest('POST', Uri.parse("${V2Config.host}/api/v2/upload-image-single"));
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      upload.files.add(http.MultipartFile.fromBytes("image", await image.readAsBytes(), filename: ".png"));
      final res = await upload.send().then((value) => value.stream.bytesToString());
      return res;
    } else {
      return null;
    }
  }
}
