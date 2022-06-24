import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_probus/val.dart';
import 'package:get_storage/get_storage.dart';

class SelectCllient extends StatelessWidget {
  SelectCllient({Key? key, required this.client}) : super(key: key);
  final _listCustomer = [...Val.clients.value.val].val("electCllient._listCustomer").obs;
  final _searchText = "".val("SelectCllient._searchText").obs;
  final Rx<ReadWriteValue<Map<dynamic, dynamic>>> client;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
      ),
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) => ListView(
            controller: ScrollController(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BackButton(),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          _searchText.value.val = value;
                          _listCustomer.value.val.assignAll(
                            Val.clients.value.val.where(
                              (element) => element['name'].toString().toLowerCase().contains(
                                    _searchText.value.val.toString().toLowerCase(),
                                  ),
                            ),
                          );

                          _listCustomer.refresh();
                        },
                        controller: TextEditingController(text: _searchText.value.val),
                        decoration: InputDecoration(
                            hintText: "client name",
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final cln in _listCustomer.value.val)
                        ListTile(
                          onTap: () {
                            client.value.val = cln;
                            client.refresh();
                            Get.back();
                          },
                          leading: Icon(Icons.people),
                          title: Text(cln['name'].toString()),
                        )
                    ],
                  ))
            ],
          ),
        );
      },
      leading: Icon(
        Icons.check_box,
        color: client.value.val['name'] == null ? Colors.grey: Colors.green,
      ),
      title: Text(
        "Select Client",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("pilih customer "),
          Visibility(
            visible: client.value.val.isNotEmpty,
            child: Text(
              (client.value.val['name'] ?? "").toString().toUpperCase(),
              style: TextStyle(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
    ;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Obx(() => Card(
  //         child: ExpansionTile(
  //           title: Text(
  //             "Select Client : ${(_value['name'] ?? '').toString().toUpperCase()}",
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
  //           ),
  //           subtitle: Text(
  //             "Pilih client dari client list",
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(color: Colors.grey.shade400),
  //           ),
  //           children: [
  //             Container(
  //               height: 400,
  //               child: GridView.extent(
  //                 controller: ScrollController(),
  //                 maxCrossAxisExtent: 150,
  //                 children: [
  //                   for (final ist in Val.clients.value.val)
  //                     Card(

  //                       child: ListTile(
  //                         selected: _value['id'] == ist['id'],
  //                         onTap: () {
  //                           onSelect(ist);
  //                           _value.assignAll(ist);
  //                         },
  //                         title: Text(
  //                           ist['name'].toString(),
  //                         ),
  //                         subtitle: Text("pilih ini jika yang anda maksut adalah ${ist['name']}"),
  //                       ),
  //                     )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ));
  // }
}
