import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InputImage extends StatelessWidget {
  InputImage({Key? key}) : super(key: key);
  final _listImage = [].val("_listImage").obs;
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_box,
                  color: _listImage.value.val.isNotEmpty ? Colors.green : Colors.grey,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    labelText: 'Image Url',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  if (_imageController.text.isNotEmpty) {
                    final listImage = List.from(_listImage.value.val);
                    listImage.add(_imageController.text);
                    _listImage.value.val = listImage;
                    _imageController.text = "";
                    _listImage.refresh();

                    print(_listImage.value.val);

                  }else{
                    EasyLoading.showError("Image Url is empty");
                  }
                },
              ),
            ],
          ),
          Obx(
            () => 
            Wrap(
                children: [
                  for (var image in _listImage.value.val)
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                _listImage.value.val.remove(image);
                                _listImage.refresh();
                              },
                              icon: CircleAvatar(child: Icon(Icons.close)),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fitWidth
                          ),
                          
                        ],
                      ),
                    ),
                ],
              )
          )
        ],
      ),
    );
  }
}
