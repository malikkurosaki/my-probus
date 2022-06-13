import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Priority extends StatelessWidget {
  const Priority(
      {Key? key,
      required this.title,
      // required this.onSelect,
      required this.item,
      required this.value,
      required this.subtitle})
      : super(key: key);
  // final _item = [
  //   {"value": 1, "name": "light", "des": "pilih jika anda rasa adalah yang ringan"},
  //   {"value": 2, "name": "info", "des": "pilih jika anda rasa adalah sejenis issue info untuk diketahui"},
  //   {"value": 3, "name": "primary", "des": "pilih jika anda rasa adalah issue penting "},
  //   {"value": 4, "name": "warning", "des": "pilih jika anda rasa adalah butuh diperhatikan dan tanggapan segera"},
  //   {"value": 5, "name": "danger", "des": "pilih jika anda rasa adalah issue butuh ditangani sesegera mungkin"},
  //   {"value": 6, "name": "dark", "des": "pilih jika anda rasa adalah issue sangat serius "},
  // ];
  final String title;
  final Rx<ReadWriteValue<Map<dynamic, dynamic>>> value;
  // final Function(Map value) onSelect;
  final List item;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: title,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Icon(
            //     Icons.check_box,
            //     color: value.value.val.isNotEmpty ? Colors.green : Colors.grey,
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Obx(
                              () => 
                              Text(
                                  (value.value.val['name']??title).toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            )
                            ,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Visibility(
                    //   visible: value.value.val.isNotEmpty,
                    //   child: Text(
                    //     (value.value.val['name'] ?? "").toString().toUpperCase(),
                    //     style: TextStyle(
                    //       color: Colors.blue.shade600,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 24,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
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
      ),
      itemBuilder: (context) => [
        for (final itm in item)
          PopupMenuItem(
            onTap: () {
              value.value.val = itm;
              value.refresh();
              // onSelect(itm);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itm['name'].toString().toUpperCase(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    for (final c in List.generate(6, (index) => index))
                      Icon(
                        Icons.star,
                        color:
                            int.parse(itm['value'].toString()) <= c ? Colors.grey.shade400 : Colors.yellow.shade700,
                      ),
                  ],
                ),
                Text(
                  itm['des'].toString(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
      ],
    );
  }
}
