import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/conn.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AmbilGambar extends StatelessWidget {
  const AmbilGambar({Key? key, required this.values}) : super(key: key);

  final Rx<ReadWriteValue<List<dynamic>>> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final gam = await Conn.imageHandler();
            if (gam != null) {
              final ls = List.from(values.value.val);
              ls.addAll(gam);
              values.value.val = ls;
              values.refresh();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_box,
                    // color: value.isNotEmpty ? Colors.green : Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select Image"),
                )
              ],
            ),
          ),
        ),
        Obx(
          () => 
          Wrap(
            children: [
              for (var gam in values.value.val)
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () async {
                            final del = await Conn.imageDeleteFile(gam['name']);
                            debugPrint(del.body.toString());
                            if (del.statusCode == 201 || del.statusCode == 200) {
                              final listasil = List.from(values.value.val);
                              listasil.remove(gam);
                              values.value.val = listasil;
                              values.refresh();
                            }else{
                              debugPrint("gagal delete");
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: "${Conn.hostImage}/${gam['name']}",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
