import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:my_probus/homes/home_dashboard.dart';
import 'package:my_probus/homes/home_issue_detail.dart';
import 'package:my_probus/homes/home_issue_week_laps.dart';
import 'package:my_probus/homes/home_nav.dart';
import 'package:my_probus/homes/under_construction.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_request.dart';
import 'issue_laps.dart';

// module
// departement ke module
//

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // final _indexhome = 0.val('indexhome').obs;
  final _subPages = [
    {
      'index': 0,
      'title': 'Dashboard',
      'icon': Icons.dashboard,
      'page': HomeDashbord(),
      'menu': true,
    },
    {
      'index': 0,
      'title': 'Issue Laps',
      'icon': Icons.home,
      'page': IssueLaps(),
      'menu': true,
    },
    {
      'index': 1,
      'title': 'Crete Issue',
      'icon': Icons.auto_stories_sharp,
      'page': HomeRequest(),
      'menu': true,
    },
    {
      'index': 1,
      'title': 'Issue Week Laps',
      'icon': Icons.auto_stories_sharp,
      'page': HomeIssueWeekLaps(),
      'menu': true,
    },
    {
      'index': 2,
      'title': 'Form Todo',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    // issue submission
    {
      'index': 3,
      'title': 'Issue Submission',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 4,
      'title': 'Issue Detail',
      'icon': Icons.auto_stories_sharp,
      'page': HomeIssueDetail(),
      'menu': false,
    },
    {
      'index': 5,
      'title': 'Absensi',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 6,
      'title': 'Form Cuti',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 7,
      'title': 'Form Ijin',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 8,
      'title': 'Calendar Libur',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 9,
      'title': 'Bank Solusi',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 10,
      'title': 'Product Store',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
    {
      'index': 11,
      'title': 'List Client',
      'icon': Icons.auto_stories_sharp,
      'page': UnderConstruction(),
      'menu': true,
    },
  ];

  _onLoad() async {
    Load().loadFirst();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return KeyboardDismisser(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: sizingInformation.isMobile
              ? AppBar(
                backgroundColor: Colors.cyan.withOpacity(0.4),
                elevation: 0.0,
                  title: Text("My Probus",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  actions: [],
                )
              : null,
          drawer: sizingInformation.isMobile
              ? Drawer(
                  child: HomeNav(
                    selectedpage: Val.selectedPage,
                    subPages: _subPages,
                    indexhome: Val.indexHome,
                    sizingInformation: sizingInformation,
                  ),
                )
              : null,
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !sizingInformation.isMobile,
                  child: HomeNav(
                    selectedpage: Val.selectedPage,
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
                              visible: e['title'] == Val.selectedPage.value.val,
                              // visible: Val.indexHome.value.val == e['index'] as int,
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
