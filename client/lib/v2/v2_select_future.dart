import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class V2SelectFuture extends StatelessWidget {
  const V2SelectFuture({Key? key, required this.hint, required this.sources, required this.value, this.padding}) : super(key: key);

  final String hint;
  // final Future<http.Response> future;
  final Rx<ReadWriteValue<Map>> value;
  final EdgeInsets? padding;
  final List sources;



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Obx(
        () => Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 18),
          child: DropdownSearch<Map>(
            dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(border: InputBorder.none, hintText: hint, labelText: hint)),
            itemAsString: (Map u) => u['name'].toString(),
            onChanged: (Map? result) => value.value.val = result!,
            items: List<Map>.from(sources),
            popupProps: PopupProps.menu(
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search", fillColor: Colors.grey.shade100, filled: true),
                ),
                showSearchBox: true),
            selectedItem: value.value.val.isEmpty ? null : value.value.val,
          ),
        ),
      ),
    );
  }
}
