import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';

class V2Developer extends StatelessWidget {
  const V2Developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => ListView(
        children: [
          ListTile(
            title: Text("Reset Index Issue "),
          )
        ],
      ),
    );
  }
}
