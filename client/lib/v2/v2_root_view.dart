import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'v2_routes.dart';
import 'v2_val.dart';

class V2RootView extends StatelessWidget {
  const V2RootView({Key? key}) : super(key: key);
  
  _onLoad()async{
    await 0.1.delay();
    if (V2Val.user.val.isEmpty) {
      Get.toNamed(V2Routes.login().key);
    }else{
      Get.toNamed(V2Routes.home().key);
    };
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      V2Val.isMobile.value.val = sizingInformation.isMobile;
      return Scaffold(
        body: Center(
          child: Text("Loading"),
        ),
      );
    });
  }
}