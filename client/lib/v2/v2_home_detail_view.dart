import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_chat.dart';

import 'package:my_probus/v2/v2_config.dart';
import 'package:my_probus/v2/v2_future_widget.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:my_probus/v2/v2_val.dart';



class V2HomeDetailView extends StatelessWidget {
  V2HomeDetailView({Key? key}) : super(key: key);

  final _controller = ScrollController();

  _loadAwal() async {
    V2Load.loadDiscutionByIssueId();
  }

  @override
  Widget build(BuildContext context) {
    _loadAwal();
    return V2IsMobileWidget(
      isMobile: (isMobile) => Row(
        children: [
          Visibility(
            visible: !isMobile,
            child: Drawer(
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(
                    onPressed: () => Get.toNamed(V2Routes.home().key),
                  ),
                  Obx(
                    () => Flexible(
                      child: ListView(
                        controller: ScrollController(),
                        children: [
                          for (final itm in V2Val.homeControll.listIssueDashboard.value.val)
                            ListTile(
                              selected: itm['id'] == V2Val.selectedIssueId.val,
                              onTap: () async {
                                V2Val.selectedIssueId.val = itm["id"];
                                // todo : disini harusnya bisa refresh
                                // V2Val.homeControll.selectedIssueId.refresh();
                                await V2Load.loadDiscutionByIssueId();
                                V2Val.detailControll.content.value.val = itm;
                                V2Val.detailControll.content.refresh();
                              },
                              leading: Text(itm['idx'].toString()),
                              title: Text(itm['name'].toString()),
                              subtitle: Text(itm['des'].toString()),
                              trailing: V2Role().buttonStatusByRole(itm['id'])
                           
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: V2Chat(),
          ),
          Obx(
            () => Visibility(
              visible: V2Val.detailControll.showDetail.value.val,
              child: Drawer(
                elevation: 0,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CloseButton(
                        onPressed: () {
                          V2Val.detailControll.showDetail.value.val = false;
                          V2Val.detailControll.showDetail.refresh();
                        },
                      ),
                    ),
                    for( final k in V2Val.detailControll.content.value.val.keys)
                      Builder(
                        builder: (context) {
                          final vl = V2Val.detailControll.content.value.val;
                          return ListTile(
                            title: Text(k),
                            subtitle: Text(vl[k].toString()),
                          );
                        }
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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

  // Widget _mobilePart(bool isMobile, String issueDetailId) => Column(
  //       children: [
  //         InkWell(
  //           onTap: () => V2Val.detailControll.showDetail.value.val = true,
  //           child: Container(
  //             color: Colors.cyan,
  //             child: FutureBuilder<http.Response>(
  //               future: V2Api.issueById().getByParams(issueDetailId),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return Center(child: CircularProgressIndicator());
  //                 }
  //                 final data = jsonDecode(snapshot.data!.body);
  //                 V2Val.detailControll.content.value.val = data;
  //                 return Row(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: CircleAvatar(
  //                         radius: 24,
  //                         child: Text(
  //                           data['idx'].toString(),
  //                           style: TextStyle(color: Colors.white, fontSize: 24),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               data['name'].toString(),
  //                               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             Text(
  //                               data['des'].toString(),
  //                               style: TextStyle(color: Colors.grey.shade200, fontSize: 12),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Stack(
  //             children: [
  //               V2ImageWidget.chatBgV2(width: double.infinity),
  //               FutureListWidget(
  //                 future: V2Api.discutionByIssueId().getByParams(issueDetailId),
  //                 value: (value) => ListView(
  //                   controller: _controller,
  //                   children: [
  //                     for (final itm in V2Val.chatControll.listDiscution.value.val)
  //                       Center(
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: SizedBox(
  //                             width: isMobile ? double.infinity : Get.width / 1.5,
  //                             child: Row(
  //                               mainAxisAlignment: itm["User"]['id'] == V2Val.user.value.val['id']
  //                                   ? MainAxisAlignment.end
  //                                   : MainAxisAlignment.start,
  //                               children: [
  //                                 Card(
  //                                   elevation: 0,
  //                                   child: Container(
  //                                     constraints: BoxConstraints(maxWidth: Get.width / (isMobile ? 2 : 3)),
  //                                     padding: EdgeInsets.all(8),
  //                                     child: Column(
  //                                       crossAxisAlignment: itm["User"]['id'] == V2Val.user.value.val['id']
  //                                           ? CrossAxisAlignment.end
  //                                           : CrossAxisAlignment.start,
  //                                       children: [
  //                                         Padding(
  //                                           padding: const EdgeInsets.all(8.0),
  //                                           child: Text(
  //                                             itm["User"]['name'].toString(),
  //                                             style: TextStyle(color: Colors.cyan, fontSize: 16),
  //                                             overflow: TextOverflow.ellipsis,
  //                                           ),
  //                                         ),
  //                                         Padding(
  //                                           padding: const EdgeInsets.all(8.0),
  //                                           child: itm['imagesId'] != null
  //                                               ? CachedNetworkImage(
  //                                                   imageUrl:
  //                                                       V2Config.host + "/image/" + itm['Image']['name'].toString(),
  //                                                   fit: BoxFit.cover,
  //                                                 )
  //                                               : Text(itm['content'].toString()),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Card(
  //           color: Colors.cyan,
  //           elevation: 0,
  //           child: Container(
  //             width: double.infinity,
  //             padding: const EdgeInsets.all(8),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 IconButton(
  //                   onPressed: () async {
  //                     final data = await _singleImageUploadHandler();
  //                     if (data != null) {
  //                       final img = Map.from(jsonDecode(data));
  //                       final con = {
  //                         "content": "",
  //                         "issuesId": V2Val.detailControll.content.value.val['id'],
  //                         "usersId": V2Val.user.value.val["id"],
  //                         "imagesId": img['data']['id']
  //                       };

  //                       final body = {"type": "image", "dataImage": jsonEncode(con)};
  //                       final discution = await V2Api.discutionCreate().postData(body);

  //                       final baru = List.from(V2Val.chatControll.listDiscution.value.val);
  //                       baru.add(Map.from(jsonDecode(discution.body)));
  //                       V2Val.chatControll.listDiscution.value.val = baru;
  //                       V2Val.chatControll.listDiscution.refresh();
  //                       await 0.5.delay();
  //                       _controller
  //                           .animateTo(200, duration: Duration(milliseconds: 500), curve: Curves.ease);
  //                     } else {
  //                       EasyLoading.showToast("hemmm ...");
  //                     }
  //                   },
  //                   icon: Icon(
  //                     Icons.image,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: TextField(
  //                     autofocus: true,
  //                     focusNode: V2Val.detailControll.fokus,
  //                     controller: V2Val.detailControll.contentText,
  //                     decoration: InputDecoration(
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                         borderSide: BorderSide.none,
  //                       ),
  //                       fillColor: Colors.cyan.shade300,
  //                       filled: true,
  //                       hintText: "Tulis sesuatu",
  //                       hintStyle: TextStyle(color: Colors.white),
  //                     ),
  //                     onSubmitted: (value) async {
  //                       final con = {
  //                         "content": V2Val.detailControll.contentText.text,
  //                         "issuesId": V2Val.detailControll.content.value.val['id'],
  //                         "usersId": V2Val.user.value.val["id"]
  //                         //imagesId
  //                       };

  //                       final body = {"type": "text", "dataText": jsonEncode(con)};

  //                       final discution = await V2Api.discutionCreate().postData(body);
  //                       final baru = List.from(V2Val.chatControll.listDiscution.value.val);
  //                       baru.add(Map.from(jsonDecode(discution.body)));
  //                       V2Val.chatControll.listDiscution.value.val = baru;
  //                       V2Val.chatControll.listDiscution.refresh();

  //                       await 0.5.delay();
  //                       V2Val.detailControll.scrollController.animateTo(
  //                           V2Val.detailControll.scrollController.position.maxScrollExtent,
  //                           duration: Duration(milliseconds: 500),
  //                           curve: Curves.ease);

  //                       V2Val.detailControll.contentText.clear();
  //                       V2Val.detailControll.fokus.requestFocus();
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
}
