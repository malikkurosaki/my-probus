import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_config.dart';
import 'package:pasteboard/pasteboard.dart';

class V2SelectImage extends StatelessWidget {
  V2SelectImage({Key? key, required this.values}) : super(key: key);
  final Rx<ReadWriteValue<List<dynamic>>> values;
  final _imgFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text("Select Image"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("sertakan gambar ( optional )"),
                RawKeyboardListener(
                  focusNode: _imgFocus,
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Wrap(
                          children: [
                            for (var gam in values.value.val)
                              Container(
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade100),
                                ),
                                width: 150,
                                height: 150,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () async {
                                          final del = await _imageDeleteFile(gam['name']);
                                          debugPrint(del.body.toString());
                                          if (del.statusCode == 201 || del.statusCode == 200) {
                                            final listasil = List.from(values.value.val);
                                            listasil.remove(gam);
                                            values.value.val = listasil;
                                            values.refresh();
                                          } else {
                                            debugPrint("gagal delete");
                                          }
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: "${Config.host}/image/${gam['name']}",
                                          placeholder: (context, url) =>
                                              const Center(child: const CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onKey: (x) async {
                    if (x.isControlPressed && x.character == "v" || x.isMetaPressed && x.character == "v") {
                      final imageBytes = await Pasteboard.image;
                      final upload = http.MultipartRequest('POST', Uri.parse("${Config.host}/api/v2/upload-image"));
                      if (imageBytes != null) {
                        final name = Random().nextInt(99999999) + 11111111;
                        upload.files.add(http.MultipartFile.fromBytes("image", imageBytes, filename: "img-$name.png"));
                        final res = await upload.send().then((value) => value.stream.bytesToString());
                        final gam = jsonDecode(res)['data'];
                        if (gam != null) {
                          final ls = List.from(values.value.val);
                          ls.addAll(gam);
                          values.value.val = ls;
                          values.refresh();
                        }
                      } else {
                        EasyLoading.showError("Bukan Gambar Yang Kau Berikan Kepadaku , Melainkan Hanya sebuah Text");
                      }
                    }
                  },
                )
              ],
            ),
            onTap: () async {
              final gam = await _imageHandler();
              if (gam != null) {
                final ls = List.from(values.value.val);
                ls.addAll(gam);
                values.value.val = ls;
                values.refresh();
              }
            },
          ),
          MaterialButton(
              focusNode: _imgFocus,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("click then press ctrl+v | cmd+v to paste image"),
              ),
              onPressed: () {
                _imgFocus.requestFocus();
              })
        ],
      ),
    );
  }

  Future<List?> _imageHandler() async {
    final upload = http.MultipartRequest('POST', Uri.parse("${Config.host}/api/v2/upload-image"));
    final image = await ImagePicker().pickMultiImage(maxHeight: 500, maxWidth: 500);
    if (image!.isNotEmpty) {
      for (var img in image) {
        upload.files.add(http.MultipartFile.fromBytes("image", await img.readAsBytes(), filename: ".png"));
      }

      //upload.headers.addAll(_header);
      final res = await upload.send().then((value) => value.stream.bytesToString());
      return jsonDecode(res)['data'];
    } else {
      return null;
    }
  }

  Future<http.Response> _imageDeleteFile(String name) => http.delete(
        Uri.parse("${Config.host}/api/v2/image-delete/$name"),
      );
}
