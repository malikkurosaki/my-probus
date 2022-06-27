import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/val.dart';

class SuperAdmin extends StatelessWidget {
  const SuperAdmin({Key? key}) : super(key: key);

  _onLoad()async{

  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ListView(
      children: [
        Text(Val.issues.value.val.toString())
      ],
    );
  }
}