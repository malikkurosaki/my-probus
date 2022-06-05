import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_probus/val.dart';
import 'package:animate_do/animate_do.dart' as animate;

class Select extends StatelessWidget {
  Select({Key? key, required this.onSelect, required this.item, required this.title}) : super(key: key);

  final Function(Map value) onSelect;
  final Map _value = {}.obs;
  final List item;
  final String title;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: 
      Row(
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
        for (final ist in item)
          PopupMenuItem(
            onTap: () {
              _value.assignAll(ist);
              onSelect(ist);
            },
            value: ist,
            child: Text(ist['name']),
          ),
      ],
    );
    //  Obx(
    //   () =>

    //   // Column(
    //   //   children: [
    //   //     MaterialButton(
    //   //       color: Colors.blue,
    //   //       child: Container(
    //   //         padding: EdgeInsets.all(12),
    //   //         child: Row(
    //   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //           children: [
    //   //             Text(_value['name']?? "Select Issue",
    //   //               style: TextStyle(fontSize: 24, color: Colors.white),
    //   //             ),
    //   //             Icon(_isShow.value? Icons.arrow_drop_down: Icons.arrow_drop_up,color: Colors.white,),
    //   //           ],
    //   //         ),
    //   //       ),
    //   //       onPressed: () {
    //   //         _isShow.value = !_isShow.value;
    //   //       },
    //   //     ),
    //   //     Visibility(
    //   //       visible: _isShow.value,
    //   //       child: Material(
    //   //         color: Colors.white,
    //   //         child: Column(
    //   //           children: [
    //   //             for(final itm in item)
    //   //             ListTile(
    //   //               onTap: () {
    //   //                 _value.assignAll(itm);
    //   //                 _isShow.value = false;
    //   //                 onSelect(itm);

    //   //               },
    //   //               title: Text(itm['name']),
    //   //             )
    //   //           ],
    //   //         ),
    //   //       )
    //   //     )
    //   //   ],
    //   // )
    //   ,
    // );
  }
}
