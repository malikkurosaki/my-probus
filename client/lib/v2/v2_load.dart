import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'v2_api.dart';
import 'v2_val.dart';

class V2Load {
  static Future<void> loadDiscutionByIssueId() async {
    try {
      // debugPrint("lihat lihat disini");
      // debugPrint(V2Val.selectedIssueId.value.val.toString());
      final data = await V2Api.discutionByIssueId().getByParams(V2Val.selectedIssueId.value.val);
      V2Val.chatControll.listDiscution.value.val = jsonDecode(data.body);
      V2Val.chatControll.listDiscution.refresh();
      debugPrint("ambil data discution");
    } catch (e) {
      EasyLoading.showToast(e.toString());
      throw e.toString();
    }
  }

  static Future<void> propertiesAll() async {
    try {
      final data = await V2Api.propertiesAll().getData();
      final all = jsonDecode(data.body);

      V2Val.listType.value.val = List<Map>.from(all['issueTypes']);
      V2Val.listStatus.value.val = List<Map>.from(all['issueStatuses']);
      V2Val.listRole.value.val = List<Map>.from(all['roles']);
      V2Val.listUser.value.val = List<Map>.from(all['users']);
      V2Val.listModule.value.val = List<Map>.from(all['departements']);
      V2Val.listProduct.value.val = List<Map>.from(all['products']);
      V2Val.listClient.value.val = List<Map>.from(all['clients']);

      debugPrint("ambil data properties");
    } catch (e) {
      // EasyLoading.showToast(e.toString());
      throw e.toString();
    }
  }

  static Future<void> issuegetAll() async {
    try {
      final data = await V2Api.issueGetAll().getData();
      V2Val.listIssue.value.val = List.from(jsonDecode(data.body));
      V2Val.listIssue.refresh();
      debugPrint("ambil data issue get all");
    } catch (e) {
      // EasyLoading.showToast(e.toString());
      throw e.toString();
    }
  }

  static loadTodo(String date) async {
    try {
      final data = await V2Api.todoGetAll().getByParams("${V2Val.user.val['id']}/$date");
      V2Val.listTodo.value.val = List.from(jsonDecode(data.body));
      V2Val.listTodo.refresh();
      debugPrint("ambil data todo");
    } catch (e) {
      throw e.toString();
    }
  }
}
