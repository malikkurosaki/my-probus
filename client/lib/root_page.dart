import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_probus/routes.dart';

import 'package:my_probus/val.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);


  _onLoad()async{
    await 2.delay();
    if(Val.user.value.val.isEmpty){
      Routes.login().goOff();
    }else{
      Routes.home().goOff();
    }
  }
  @override
  Widget build(BuildContext context) {
    _onLoad();

    return Material(
      child: Center(
        child: Text("My Probus"),
      ),
    );
  }
}