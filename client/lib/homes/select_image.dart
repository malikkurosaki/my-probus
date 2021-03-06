import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/conn.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({Key? key, required this.values}) : super(key: key);

  final Rx<ReadWriteValue<List<dynamic>>> values;

  @override
  Widget build(BuildContext context) {
    return 
    ListTile(
          leading: Icon(
            Icons.check_box,
            color: values.value.val.isNotEmpty ? Colors.green : Colors.grey,
          ),
          title: Text("Select Image"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("sertakan gambar ( optional )"),
              Obx(
                () => Wrap(
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
                                icon: const Icon(Icons.cancel),
                                onPressed: () async {
                                  final del = await Conn().imageDeleteFile(gam['name']);
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
                                  imageUrl: "${Conn().hostImage}/${gam['name']}",
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
              )
            ],
          ),
          onTap: () async {
            final gam = await Conn().imageHandler();
            if (gam != null) {
              final ls = List.from(values.value.val);
              ls.addAll(gam);
              values.value.val = ls;
              values.refresh();
            }
          },
        );
    
  }
}
