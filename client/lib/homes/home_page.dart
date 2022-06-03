import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_probus/homes/home_nav.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'home_request.dart';
import 'home_todo.dart';
import 'home_home.dart';
import '../routes.dart';
import '../val.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _indexhome = 0.val('indexhome').obs;
  final _subPages = [
    {
      'index': 0,
      'title': 'Home',
      'icon': Icons.home,
      'page': HomeHome(),
    },
    {
      'index': 1,
      'title': 'Form Request',
      'icon': Icons.add,
      'page': HomeRequest(),
    },
    {
      'index': 2,
      'title': 'Form Todo',
      'icon': Icons.add,
      'page': HomeTodo(),
    }
  ];

  _onLoad() async {
    await 1.delay();
    if (Val.user.value.val.isEmpty) {
      Routes.login().go();
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !sizingInformation.isMobile,
                child: HomeNav(
                  sizingInformation: sizingInformation,
                  subPages: _subPages,
                  indexhome: _indexhome,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: sizingInformation.isMobile,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.bottomSheet(
                                HomeNav(
                                    sizingInformation: sizingInformation,
                                    subPages: _subPages,
                                    indexhome: _indexhome,
                                  ),
                                  enableDrag: true
                              );
                            },
                            icon: Icon(Icons.menu),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Obx(
                        () => Stack(
                          alignment: Alignment.topLeft,
                          children: _subPages
                              .map(
                                (e) => Visibility(
                                  visible: _indexhome.value.val == e['index'] as int,
                                  child: e['page'] as Widget,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
