import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';

class HomeDashbord extends StatelessWidget {
  const HomeDashbord({Key? key}) : super(key: key);

  _onLoad() {
    Load().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();

    return 
    Obx(
      () => Val.dashboards.value.val.isEmpty
          ? Center(child: Text("No Data"))
          : ListView(
            controller: ScrollController(),
              children: [
                Container(
                  color: Colors.cyan.withOpacity(0.4),
                  height: 200,
                  child: Center(
                    child: CachedNetworkImage(imageUrl: Conn().host +
                        "/images/dashboard.png" ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Issues Summary By Status",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 32),
                  child: Wrap(
                    children: [
                      for (final item in Val.dashboards.value.val['status'])
                        Card(
                          // random color
                          color: Colors.green.shade300,
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['count'].toString(),
                                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['name'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Text(
                //   Val.dashboards.value.val['user'].toString(),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Contribution By User",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 32),
                  child: Wrap(
                    children: [
                      for (final usr in Val.dashboards.value.val['user'])
                        Card(
                          color: Colors.cyan.shade300,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      usr['name'].toString().toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    height: 30,
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    usr['count'].toString(),
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Most Client Contribution",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 32),
                  child: Wrap(
                    children: [
                      for (final usr in Val.dashboards.value.val['client'])
                        Card(
                          color: Colors.blue.shade300,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      usr['name'].toString().toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    height: 30,
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    usr['count'].toString(),
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
