import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/config.dart';

class V2DevRole extends StatelessWidget {
  const V2DevRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: FutureBuilder<http.Response>(
            future: http.get(Uri.parse('${Config.host}/dev-role')),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("loading ...");
              final datanya = jsonDecode(snapshot.data!.body);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(datanya.toString()),
                  for (final itm in datanya)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(itm['name'].toString()),
                    )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
