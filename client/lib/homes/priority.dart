import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class Priority extends StatelessWidget {
  Priority({Key? key,required this.title,required this.onSelect,required this.item}) : super(key: key);
  // final _item = [
  //   {"value": 1, "name": "light", "des": "pilih jika anda rasa adalah yang ringan"},
  //   {"value": 2, "name": "info", "des": "pilih jika anda rasa adalah sejenis issue info untuk diketahui"},
  //   {"value": 3, "name": "primary", "des": "pilih jika anda rasa adalah issue penting "},
  //   {"value": 4, "name": "warning", "des": "pilih jika anda rasa adalah butuh diperhatikan dan tanggapan segera"},
  //   {"value": 5, "name": "danger", "des": "pilih jika anda rasa adalah issue butuh ditangani sesegera mungkin"},
  //   {"value": 6, "name": "dark", "des": "pilih jika anda rasa adalah issue sangat serius "},
  // ];
  final String title;
  final _value = {}.obs;
  final Function(Map value) onSelect;
  final List item;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(title),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _value.isNotEmpty,
                      child: Text(
                        (_value['name'] ?? "").toString().toUpperCase(),
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Icon(Icons.arrow_drop_down),
              ),
            ),
          ],
        ),
      itemBuilder: (context) => [
        for( final itm in item)
        PopupMenuItem(
          onTap: (){
            _value.assignAll(itm);
            onSelect(itm);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itm['name'].toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              Row(
                children: [
                  for( final c in List.generate(itm['value'] as int, (index) => index))
                  Icon(Icons.star)
                ],
              ),
              Text(itm['des'].toString(),
                style: TextStyle(
                  color: Colors.grey
                ),
              )
            ],
          )
        )
      ]
      
    );
  }
}
