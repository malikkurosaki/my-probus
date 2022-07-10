import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_routes.dart';

class V2Menu {
  V2Menu._();

  late String key;
  // a1 do not remove this line

  V2Menu.dashboard() : key = 'dashboard';
  V2Menu.issueLaps() : key = 'Issue Laps';
  V2Menu.creteIssue() : key = 'Crete Issue';
  V2Menu.issueHistories() : key = 'Issue Histories';
  V2Menu.formTodo() : key = 'Form Todo';
  V2Menu.issueSubmission() : key = 'Issue Submission';
  V2Menu.issueDetail() : key = 'Issue Detail';
  V2Menu.issueList() : key = 'Issue List';
  V2Menu.absensi() : key = 'Absensi';
  V2Menu.formCuti() : key = 'Form Cuti';
  V2Menu.formIzin() : key = 'Form Izin';
  V2Menu.calendarLibur() : key = 'Calendar Libur';
  V2Menu.bankSolusi() : key = 'Bank Solusi';
  V2Menu.productStore() : key = 'Product Store';
  V2Menu.listClient() : key = 'List Client';
  V2Menu.listProject() : key = 'List Project';
  V2Menu.developer() : key = 'Developer';

  // a2 do not remove this line
  static final all = [
    V2Menu.dashboard().menuItem(onTap: () => EasyLoading.showToast("dashboard")),
    V2Menu.issueLaps().menuItem(),
    V2Menu.creteIssue().menuItem(onTap: () => Get.toNamed(V2Routes.createIssue().key)),
    V2Menu.issueHistories().menuItem(),
    V2Menu.formTodo().menuItem(onTap: () => Get.toNamed(V2Routes.formTodo().key)),
    V2Menu.issueSubmission().menuItem(),
    V2Menu.issueDetail().menuItem(),
    V2Menu.issueList().menuItem(onTap: () => Get.toNamed(V2Routes.issueList().key)),
    V2Menu.absensi().menuItem(),
    V2Menu.formCuti().menuItem(),
    V2Menu.formIzin().menuItem(),
    V2Menu.calendarLibur().menuItem(),
    V2Menu.bankSolusi().menuItem(),
    V2Menu.productStore().menuItem(),
    V2Menu.listClient().menuItem(),
    V2Menu.listProject().menuItem(),
    V2Menu.developer().menuItem(onTap: () => Get.toNamed(V2Routes.developer().key)),
  ];

  Widget menuItem({VoidCallback? onTap}) => ListTile(
        title: Text(key.toUpperCase()),
        leading: Icon(
          Icons.data_saver_on,
          color: Colors.cyan,
        ),
        onTap: onTap,
      );
}
