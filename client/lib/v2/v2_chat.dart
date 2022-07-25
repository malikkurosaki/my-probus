import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/skt.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pasteboard/pasteboard.dart';
import 'v2_api.dart';
import 'v2_config.dart';
import 'v2_load.dart';
import 'v2_val.dart';

class V2Chat extends StatelessWidget {
  V2Chat({Key? key}) : super(key: key);
  final _scrollController = ScrollController();
  final _fokus = FocusNode();
  final _contentText = TextEditingController();
  // final _focusImg = FocusNode();

  @override
  Widget build(BuildContext context) {
    // _onLoad();
    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => Column(
        children: [
          Obx(
            () => InkWell(
              onTap: () {
                V2Val.detailControll.showDetail.value.val = true;
                V2Val.detailControll.showDetail.refresh();
              },
              child: Container(
                color: Colors.cyan,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 24,
                        child: Text(
                          V2Val.detailControll.content.value.val['idx'].toString(),
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
                              V2Val.detailControll.content.value.val['name'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              V2Val.detailControll.content.value.val['des'].toString(),
                              style: TextStyle(color: Colors.grey.shade200, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    V2Val.clock
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: Stack(
              children: [
                V2ImageWidget.chatBgV2(width: double.infinity),
                Obx(
                  () => ListView(
                    addAutomaticKeepAlives: true,
                    controller: _scrollController,
                    children: [
                      for (final itm in V2Val.chatControll.listDiscution.value.val)
                        Builder(builder: (context) {
                          try {
                            return _chatItem(isMobile, itm);
                          } catch (e) {
                            return Text("loading");
                          }
                        })
                    ],
                  ),
                )
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
                  RawKeyboardListener(
                    focusNode: _fokus,
                    child: IconButton(
                      onPressed: () async {
                        final data = await _singleImageUploadHandler();
                        if (data != null) {
                          final img = Map.from(jsonDecode(data));
                          final con = {
                            "content": "",
                            "issuesId": V2Val.detailControll.content.value.val['id'],
                            "usersId": V2Val.user.val["id"],
                            "imagesId": img['data']['id']
                          };

                          final body = {"type": "image", "dataImage": jsonEncode(con)};
                          final discution = await V2Api.discutionCreate().postData(body);

                          V2Val.chatControll.listDiscution.value.val.add(Map.from(jsonDecode(discution.body)));
                          V2Val.chatControll.listDiscution.refresh();

                          _fokus.requestFocus();

                          _scrollController.animateTo(_scrollController.position.maxScrollExtent + 300,
                              duration: Duration(milliseconds: 500), curve: Curves.ease);

                          // Skt.notifWithIssue(
                          //   title: "new message",
                          //   content: "[ image ]",
                          //   jenis: "msg",
                          // );

                          debugPrint("halo disini chat image");
                          await V2Load.loadDiscutionByIssueId();
                        } else {
                          EasyLoading.showToast("hemmm ...");
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    onKey: (x) async {
                      if (x.isControlPressed && x.character == "v" || x.isMetaPressed && x.character == "v") {
                        final imageBytes = await Pasteboard.image;
                        final upload =
                            http.MultipartRequest('POST', Uri.parse("${Config.host}/api/v2/upload-image-single"));
                        if (imageBytes != null) {
                          final name = Random().nextInt(99999999) + 11111111;
                          upload.files
                              .add(http.MultipartFile.fromBytes("image", imageBytes, filename: "img-$name.png"));
                          final data = await upload.send().then((value) => value.stream.bytesToString());

                          final img = Map.from(jsonDecode(data));
                          final con = {
                            "content": "",
                            "issuesId": V2Val.detailControll.content.value.val['id'],
                            "usersId": V2Val.user.val["id"],
                            "imagesId": img['data']['id']
                          };

                          final body = {"type": "image", "dataImage": jsonEncode(con)};
                          final discution = await V2Api.discutionCreate().postData(body);

                          V2Val.chatControll.listDiscution.value.val.add(Map.from(jsonDecode(discution.body)));
                          V2Val.chatControll.listDiscution.refresh();

                          _fokus.requestFocus();

                          _scrollController.animateTo(_scrollController.position.maxScrollExtent + 300,
                              duration: Duration(milliseconds: 500), curve: Curves.ease);

                          // Skt.notifWithIssue(
                          //   title: "new message",
                          //   content: "[ image ]",
                          //   jenis: "msg",
                          // );

                          debugPrint("halo disini chat image");
                          await V2Load.loadDiscutionByIssueId();

                        }
                      }
                    },
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
                        hintText: "Type Something",
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
                          "issuesId": V2Val.detailControll.content.value.val['id'],
                          "usersId": V2Val.user.val['id']
                          //imagesId
                        };

                        final body = {"type": "text", "dataText": jsonEncode(con)};

                        final discution = await V2Api.discutionCreate().postData(body);
                        debugPrint("discution.body");
                        try {
                          V2Val.chatControll.listDiscution.value.val.add(Map.from(jsonDecode(discution.body)));
                          V2Val.chatControll.listDiscution.refresh();

                          // Skt.notifWithIssue(
                          //   title: "new message",
                          //   content: _contentText.text,
                          //   jenis: "msg",
                          // );

                          _contentText.clear();
                          _fokus.requestFocus();
                          _scrollController.animateTo(_scrollController.position.maxScrollExtent + 100,
                              duration: Duration(milliseconds: 500), curve: Curves.ease);

                          debugPrint("halo disini chat");
                          await V2Load.loadDiscutionByIssueId();
                        } catch (e) {
                          debugPrint(e.toString());
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
    );
  }

  Widget _chatItem(bool isMobile, Map itm) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: isMobile ? double.infinity : Get.width / 1.5,
            child: Row(
              mainAxisAlignment:
                  (itm["User"]?['id'] ?? "a") == V2Val.user.val['id'] ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: Get.width / (isMobile ? 2 : 3)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: (itm["User"]['id'] ?? "a") == V2Val.user.val['id']
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
                                  imageUrl: Config.host + "/image/" + itm['Image']['name'].toString(),
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
    final upload = http.MultipartRequest('POST', Uri.parse("${Config.host}/api/v2/upload-image-single"));
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
