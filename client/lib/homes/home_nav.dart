import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key, required this.subPages, required this.indexhome, required this.sizingInformation})
      : super(key: key);
  final List<Map<String, Object>> subPages;
  final Rx<ReadWriteValue<int>> indexhome;
  final SizingInformation sizingInformation;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          width: sizingInformation.isMobile ? double.infinity : 340,
          child: ListView(
            controller: ScrollController(),
            children: [
              Container(
                color: Colors.white,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(visible: sizingInformation.isMobile, child: BackButton()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Val.user.value.val['name'] ?? "No Name - Reload",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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
                      return ListTile(
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
                      content: Text("Are you sure?"),
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
