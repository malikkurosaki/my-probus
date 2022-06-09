import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key, required this.subPages, required this.indexhome, required this.sizingInformation, this.scrollController }) : super(key: key);

  final List<Map<String, Object>> subPages;
  final Rx<ReadWriteValue<int>> indexhome;
  final SizingInformation sizingInformation;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          width: sizingInformation.isMobile ? double.infinity : 340,
          child: ListView(
            controller: scrollController,
            children: [
              Container(
                color: Colors.white,
                height: 200,
                child: Stack(
                  children: [
                    CachedNetworkImage(imageUrl: '${Conn.host}/images/profile.png',
                    width: double.infinity,
                        fit: BoxFit.cover,
                    ),
                    Visibility(visible: sizingInformation.isMobile, child: BackButton()),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Val.user.value.val['name'].toString(),
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subPages.map(
                    (e) {
                      return Visibility(
                        visible: e['menu'] as bool,
                        child: ListTile(
                          selected: indexhome.value.val == e['index'],
                          leading: Icon(e['icon'] as IconData),
                          title: Text(e['title'] as String),
                          onTap: () {
                            indexhome.value.val = e['index'] as int;
                            indexhome.refresh();
                            
                            debugPrint(e['index'].toString());
                            debugPrint(indexhome.value.val.toString());
                            
                            if (sizingInformation.isMobile) {
                              Get.back();
                            }
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
      
              // logout button
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Logout"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CachedNetworkImage(imageUrl: '${Conn.host}/images/logout.png',
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Are you sure?",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),


                            ),
                          ),
                        ],
                      ),
                      actions: [
                        MaterialButton(
                          child: Text("Yes"),
                          onPressed: () {
                            Val.user.value.val = {};
                            Routes.root().goOff();
                          },
                        ),
                        MaterialButton(
                          child: Text("No"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
