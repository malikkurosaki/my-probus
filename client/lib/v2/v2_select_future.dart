import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class V2SelectFuture extends StatelessWidget {
  const V2SelectFuture({Key? key, required this.hint, required this.future, required this.value, this.padding}) : super(key: key);

  final String hint;
  final Future<http.Response> future;
  final Rx<ReadWriteValue<Map>> value;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("loading ...");
        } else {
          final data = List.from(json.decode(snapshot.data!.body))
              .map((e) => {
                    "id": e["id"],
                    "name": e["name"],
                  })
              .toList();
          return Obx(
            () => Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 18),
              child: DropdownSearch<Map>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        InputDecoration(border: InputBorder.none, hintText: hint, labelText: hint)),
                itemAsString: (Map u) => u['name'].toString(),
                onChanged: (Map? result) => value.value.val = result!,
                items: data,
                popupProps: PopupProps.menu(
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search", fillColor: Colors.grey.shade100, filled: true),
                    ),
                    showSearchBox: true),
                selectedItem: value.value.val.isEmpty ? null : value.value.val,
              ),
            ),
          );
        }
      },
    );
  }
}
