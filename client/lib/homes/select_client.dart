import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_probus/val.dart';

class SelectCllient extends StatelessWidget {
  SelectCllient({Key? key, required this.onSelect}) : super(key: key);
  final _value = {}.obs;
  final Function(Map value) onSelect;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          child: ExpansionTile(
            title: Text(
              "Select Client : ${(_value['name'] ?? '').toString().toUpperCase()}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            subtitle: Text(
              "Pilih client dari client list",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade400),
            ),
            children: [
              Container(
                height: 400,
                child: GridView.extent(
                  controller: ScrollController(),
                  maxCrossAxisExtent: 150,
                  children: [
                    for (final ist in Val.clients.value.val)
                      Card(
                        
                        child: ListTile(
                          selected: _value['id'] == ist['id'],
                          onTap: () {
                            onSelect(ist);
                            _value.assignAll(ist);
                          },
                          title: Text(
                            ist['name'].toString(),
                          ),
                          subtitle: Text("pilih ini jika yang anda maksut adalah ${ist['name']}"),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
