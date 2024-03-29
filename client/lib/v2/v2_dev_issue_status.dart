import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';

class V2DevIssueStatus extends StatelessWidget {
  const V2DevIssueStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: FutureBuilder<http.Response>(
          future: http.get(Uri.parse(Config.host + '/dev-issue-status')),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("loading ...");
            final datanya = jsonDecode(snapshot.data!.body);
            return ListView(
              children: [
                // Text(datanya.toString()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(final itm in datanya)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(itm['name'].toString()),
                    )
                  ],
                )
              ],
            );
          },
        ))
      ],
    );
  }
}
