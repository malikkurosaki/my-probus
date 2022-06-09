import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/homes/home_issue_detail.dart';
import 'package:my_probus/homes/home_nav.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_main.dart';
import 'home_request.dart';
import 'home_todo.dart';

// module
// departement ke module
//

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // final _indexhome = 0.val('indexhome').obs;
  final _subPages = [
    {
      'index': 0,
      'title': 'Home',
      'icon': Icons.home,
      'page': HomeMain(),
      'menu': true,
    },
    {
      'index': 1,
      'title': 'Form Request',
      'icon': Icons.add,
      'page': HomeRequest(),
      'menu': true,
    },
    {
      'index': 2,
      'title': 'Form Todo',
      'icon': Icons.add,
      'page': HomeTodo(),
      'menu': true,
    },
    {
      'index': 3,
      'title': 'Issue Detail',
      'icon': Icons.add,
      'page': HomeIssueDetail(),
      'menu': false,
    },
  ];

  _onLoad() async {
    Conn().loadFirst();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return KeyboardDismisser(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: sizingInformation.isMobile
              ? AppBar(
                  title: Text("Form"),
                  actions: [],
                )
              : null,
          drawer: sizingInformation.isMobile
              ? Drawer(
                  child: HomeNav(subPages: _subPages, indexhome: Val.indexHome, sizingInformation: sizingInformation),
                )
              : null,
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !sizingInformation.isMobile,
                  child: HomeNav(
                    sizingInformation: sizingInformation,
                    subPages: _subPages,
                    indexhome: Val.indexHome,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.topLeft,
                      children: _subPages
                          .map(
                            (e) => Visibility(
                              visible: Val.indexHome.value.val == e['index'] as int,
                              child: e['page'] as Widget,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
