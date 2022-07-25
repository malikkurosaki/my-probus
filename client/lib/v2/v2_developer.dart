import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:intl/intl.dart';

class V2Developer extends StatelessWidget {
  const V2Developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datanya = List.from(V2Val.listIssueDashboard.value.val);
    var ini = {};
    try {
      ini = groupBy(List<Map>.from(datanya), (x) => jsonDecode(jsonEncode(x))["Client"]['name']).map(
        (key, value) => MapEntry(
          key,
          groupBy(value, (x) => jsonDecode(jsonEncode(x))["Product"]['name'])
              .map(
                (key, value) => MapEntry(key, value),
              )
              .map(
                  (key, value) => MapEntry(key, groupBy(value, (x) => jsonDecode(jsonEncode(x))['IssueType']['name']))),
        ),
      );

      print(ini);
    } catch (e) {
      print(e);
    }

    return V2IsMobileWidget(
      isMobile: (isMobile, isTablet, isDesktop) => ListView(
        children: [
          Text("data"),
          Text(JsonEncoder.withIndent("    ").convert(ini)),
          Divider(),
          for (final client in ini.keys)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (final product in ini[client].keys)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (final issueType in ini[client][product].keys)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 100, child: Text("Type ")),
                                    Expanded(child: Text(issueType.toString())),
                                  ],
                                ),
                                for (final issue in ini[client][product][issueType])
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 100, child: Text("Title")),
                                          Expanded(child: Text(issue['name'].toString())),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 100, child: Text("Description")),
                                          Expanded(child: Text(issue['des'].toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Divider()
                ],
              ),
            )
        ],
      ),
    );
  }
}
