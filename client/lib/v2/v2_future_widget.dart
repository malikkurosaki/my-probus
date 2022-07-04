import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget({Key? key, required this.future, required this.value}) : super(key: key);
  final Future<http.Response> future;
  final Function(String value) value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return value(snapshot.data!.body);
        }
      },
    );
  }
}

class FutureListWidget extends StatelessWidget {
  const FutureListWidget({Key? key, required this.future, required this.value}) : super(key: key);
  final Future<http.Response> future;
  final Function(List) value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: future,
      builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : value(List.from(json.decode(snapshot.data!.body))),
    );
  }
}

class FutureMapWidget extends StatelessWidget {
  const FutureMapWidget({Key? key, required this.future, required this.value}) : super(key: key);
  final Future<http.Response> future;
  final Function(Map<String, dynamic> value) value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: future,
      builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : value(jsonDecode(snapshot.data!.body)),
    );
  }
}
