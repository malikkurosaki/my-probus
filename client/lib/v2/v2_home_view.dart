import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_val.dart';

class V2HomeView extends StatelessWidget {
  const V2HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => Scaffold(
        appBar: !isMobile? null : AppBar(
          title: Text("Home"),
        ),
        drawer: !isMobile? null : _drawerPart(),
        body: Scaffold(
          body: isMobile ? _mobilePart(isMobile) : _webPart(isMobile),
        ),
      ),
    );
  }

  Widget _drawerPart() => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  V2ImageWidget.logo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(V2Val.user.value.val['name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      );

  Widget _mobilePart(bool isMobile) => SizedBox(
        child: Card(
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [Text("Home")],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _webPart(bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _drawerPart(),
        Flexible(child: _mobilePart(isMobile)),
      ],
    );
  }
}
