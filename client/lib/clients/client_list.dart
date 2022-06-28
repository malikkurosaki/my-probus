import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_table/json_table.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';

class ClientList extends StatelessWidget {
  const ClientList({Key? key}) : super(key: key);

  _onload() async {
    Load().loadClient();
  }

  @override
  Widget build(BuildContext context) {
    _onload();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: JsonTable(
              Val.clients.value.val.map((e) => {
                "name": e['name'],
              }).toList(),
              onRowSelect: (index, map) {
                
              },
              allowRowHighlight: true,
              tableHeaderBuilder: (header) {
                return Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.grey.shade300,
                  child: Text(header.toString().toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
              tableCellBuilder: (apa) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                   apa.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
                  
            ),
          ),
        ),
        Flexible(
          child: ListView(
            children: [
              Text("Ini ada Dimana")
            ],
          )
        )
      ],
    );
  }
}
