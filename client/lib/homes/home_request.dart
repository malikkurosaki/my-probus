import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/homes/home_request_form.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeRequest extends StatelessWidget {
  const HomeRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveBuilder(
      builder: (context, sizingInformation) => HomeRequestForm(
        sizingInformation: sizingInformation,
      ),
    )
        // ResponsiveBuilder(
        //   builder: (context, sizingInformation) => Column(
        //     children: [
        //       Container(
        //         color: Colors.grey.shade100,
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               "Request",
        //               style: TextStyle(fontSize: 40, color: Colors.grey.shade700),
        //             ),
        //             IconButton(
        //               onPressed: () {
        //                 showBottomSheet(
        //                   context: context,
        //                   builder: (context) => HomeRequestForm(sizingInformation: sizingInformation),
        //                 );
        //               },
        //               icon: Icon(Icons.add),
        //             )
        //           ],
        //         ),
        //       ),
        //       Flexible(
        //         child: Obx(() => ListView(
        //               controller: ScrollController(),
        //               children: Val.listContent.value.val.map(
        //                 (e) {
        //                   return Card(
        //                     child: ListTile(
        //                       title: Text(e['title']),
        //                       subtitle: Text(e['description']),
        //                       onTap: () {},
        //                     ),
        //                   );
        //                 },
        //               ).toList(),
        //             )),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
