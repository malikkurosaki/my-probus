import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class V2ListTodo extends StatelessWidget {
  V2ListTodo({Key? key}) : super(key: key);

  final _hasilData = {}.obs;

  _loadData(String tanggal) async {
    final gtData = await V2Api.todoList().getByParams(tanggal);
    final hasil = groupBy(List.from(jsonDecode(gtData.body)), (x) => jsonDecode(jsonEncode(x))['User']['name']);
    _hasilData.assignAll(hasil);

  }

  @override
  Widget build(BuildContext context) {
    _loadData(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString());
    return V2IsMobileWidget(
      isMobile: (isMobile) => Row(
        children: [
          Visibility(
            visible: !isMobile,
            child: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Column(
                      children: [V2ImageWidget.logo()],
                    ),
                  ),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    onDateChanged: (date) async{

                      await _loadData(date.toString());
                    },
                    currentDate: DateTime.now(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: ScrollController(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Todo List",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final user in _hasilData.keys)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  user.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              for (final todo in jsonDecode(jsonEncode(_hasilData[user])))
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    todo['title'].toString(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    todo['content'].toString(),
                                                  ),
                                                  Text(
                                                    DateFormat("dd/MM/yyyy").format(DateTime.parse(todo['createdAt'])),
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: todo['status'] == "open"
                                                    ? Icon(
                                                        Icons.circle_outlined,
                                                        color: Colors.grey,
                                                      )
                                                    : Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
