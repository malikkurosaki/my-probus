import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';
import 'package:my_probus/val.dart';
import 'package:get_storage/get_storage.dart';

class Master extends StatelessWidget {
  const Master({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Get.height,
            child: ListView(
              children: [
                for(final itm in Val.clients.value.val)
                ListTile(
                  title: Text(itm['name']),
                )
              ],
            ),
          )
        ),
        SizedBox(
          height: Get.height,
          width: 500,
          child: ListView(
            children: [
              Text("ini ada dimana")
            ],
          ),
        )
      ],
    );
  }
}

// class Master extends StatelessWidget {
//   Master({Key? key}) : super(key: key);
//   final _action = {}.val("action").obs;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Card(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: SizedBox(
//                 height: Get.height,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: JsonTable(
//                     Val.clients.value.val
//                         .map((e) =>
//                             {"#": (Val.clients.value.val.indexOf(e) + 1).toString(), "name": "${e['name']}/data/${jsonEncode(e)}"})
//                         .toList(),
//                     allowRowHighlight: true,
//                     tableHeaderBuilder: (value) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         value!,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                     tableCellBuilder: (value) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(value.toString().split("/data/")[0].toString()),
//                     ),
//                     onRowSelect: (index, value) {
//                       _action.value.val = jsonDecode(value['name'].toString().split("/data/")[1].toString());
//                       _action.refresh();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           child: SizedBox(
//             width: 500,
//             height: Get.height,
//             child: Obx(
//               () => Column(
//                 children: [
//                   Row(
//                     children: [
//                       MaterialButton(
//                         child: Text("Add"),
//                         onPressed: (){

//                         }
//                       )
//                     ],
//                   ),
//                   Text("${_action.value.val['name']}"),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
