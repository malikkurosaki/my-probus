import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart' as anim;
import 'package:shimmer/shimmer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class FutureWidget {
  // component future list
  Widget futureList(
          {required Rx<ReadWriteValue<List<dynamic>>> rxValue,
          required Future<http.Response> loadData,
          required Function(Rx<ReadWriteValue<List<dynamic>>> value) value}) =>
      FutureBuilder<http.Response>(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              rxValue.value.val = List.from(jsonDecode(snapshot.data!.body)['data']);
              rxValue.refresh();
              return Obx(
                () => value(rxValue),
              );
            } catch (e) {
              return Row(
                children: [Icon(Icons.error), Text("Ups Error")],
              );
            }
          } else {
            return Shimmer(
                child: Text("wait amoment please"),
                gradient: LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade100]));
          }
        },
      );

  // component future map
  Widget futureMap(
          {required Rx<ReadWriteValue<Map<String, dynamic>>> rxValue,
          required Future<http.Response> loadData,
          required Function(Rx<ReadWriteValue<Map<String, dynamic>>> value) value}) =>
      FutureBuilder<http.Response>(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              rxValue.value.val = jsonDecode(snapshot.data!.body);
              rxValue.refresh();
              return Obx(
                () => value(rxValue),
              );
            } catch (e) {
              return Row(
                children: [Icon(Icons.error), Text("Ups Error")],
              );
            }
          } else {
            return Shimmer(
                child: Text("hahahaha ini diamana"),
                gradient: LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade100]));
          }
        },
      );
}
