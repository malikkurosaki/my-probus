import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_config.dart';

class V2SelectImage extends StatelessWidget {
  const V2SelectImage({Key? key, required this.values }) : super(key: key);
  final Rx<ReadWriteValue<List<dynamic>>> values;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Select Image"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("sertakan gambar ( optional )"),
          Obx(
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
                                  imageUrl: "${V2Config.host}/image/${gam['name']}",
                                  placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
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
    );
  }

  Future<List?> _imageHandler() async {
    final upload = http.MultipartRequest('POST', Uri.parse("${V2Config.host}/api/v2/upload-image"));
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
