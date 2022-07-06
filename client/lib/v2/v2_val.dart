import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_chat.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:my_probus/val.dart';

class V2Val {
  static final isMobile = false.val('isMobile').obs;
  static final hasLogin = false.val('hasLogin').obs;
  static final user = {}.val('user');
  static final listIssueByUser = [].val("listIssueByUser").obs;
  static final listIssueByLeader = [].val("listIssueByLeader").obs;
  static final listIssueByModerator = [].val("listIssueByModerator").obs;
  static final listIssueByAdmin = [].val("listIssueByAdmin").obs;
  static final issueDetailId = "".val("issueDetailId").obs;
  static final selectedIssueId = "".val("V2Val_selectedIssueId");

  static final homeControll = V2HomeController();
  static final detailControll = V2IHomeDetailController();
  static final chatControll = V2ChatController();

  clear() {
    isMobile.value.val = false;
    hasLogin.value.val = false;
    user.val = {};
    listIssueByUser.value.val = [];
    listIssueByAdmin.value.val = [];
    listIssueByLeader.value.val = [];
    listIssueByModerator.value.val = [];
    issueDetailId.value.val = "";
  }

  logout() {
    V2Val().clear();
    V2Val.homeControll.clear();
    V2Val.detailControll.clear();
    V2Val.chatControll.clear();
  }
}


class V2Load{

   static Future<void> loadDiscutionByIssueId() async {
    try {
      debugPrint("lihat lihat disini");
      debugPrint(V2Val.selectedIssueId.val.toString());
      // final data = await V2Api.discutionByIssueId().getByParams(V2Val.selectedIssueId.val);
      // V2Val.chatControll.listDiscution.value.val = jsonDecode(data.body) as List<Map<String, dynamic>>;
      // V2Val.chatControll.listDiscution.refresh();
      // debugPrint("ambil data discution");
    } catch (e) {
      EasyLoading.showToast(e.toString());
      throw e.toString();
    }
  }
}

class V2HomeController {
  final listIssueDashboard = [].val("listIssueDashboard").obs;
  // final selectedIssueId = "".val("selectedIssueId").obs;

  _update(Object value, String issueId) async {
    final body = {
      "issueStatusesId": value.toString(),
      "usersId": V2Val.user.val['id'],
    };

    final data = await V2Api.updateIssueStatus().postDataParam(issueId, body);
    if (data.statusCode == 200) {
      await V2Val.homeControll.loadIssueDashboard();
      EasyLoading.showToast("Updated");
    } else {
      EasyLoading.showToast("Error");
    }
  }

  Widget acceptOrRejectButton(String issueId) => PopupMenuButton(
        onSelected: (value) async {
          _update(value!, issueId);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(V2Status.accepted().name),
            value: V2Status.accepted().id,
          ),
          PopupMenuItem(
            child: Text(V2Status.rejected().name),
            value: V2Status.rejected().id,
          ),
        ],
      );

  Widget approveOrDeclineButton(String issueId) => PopupMenuButton(
        onSelected: (value) async {
          _update(value!, issueId);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(V2Status.approved().name),
            value: V2Status.approved().id,
          ),
          PopupMenuItem(
            child: Text(V2Status.decline().name),
            value: V2Status.decline().id,
          ),
        ],
      );

  Widget pendingProgresButton(String issueId) => PopupMenuButton(
        onSelected: (value) async {
          _update(value!, issueId);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(V2Status.pending().name),
            value: V2Status.pending().id,
          ),
          PopupMenuItem(
            child: Text(V2Status.progress().name),
            value: V2Status.progress().id,
          ),
          PopupMenuItem(
            child: Text(V2Status.closed().name),
            value: V2Status.closed().id,
          ),
          
        ],
      );
    


  Widget resolveCloseButton(String issueId) => 
  PopupMenuButton(
        onSelected: (value) async {
          _update(value!, issueId);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(V2Status.resolved().name),
            value: V2Status.resolved().id,
          ),
          PopupMenuItem(
            child: Text(V2Status.closed().name),
            value: V2Status.closed().id,
          ),
        ],
      );

  // Future<void> loadDiscutionByIssueId() async {
  //   try {

  //     debugPrint("lihat lihat disini");
  //     debugPrint(V2Val.selectedIssueId.val.toString());
  //     // final data = await V2Api.discutionByIssueId().getByParams(V2Val.selectedIssueId.val);
  //     // V2Val.chatControll.listDiscution.value.val = jsonDecode(data.body) as List<Map<String, dynamic>>;
  //     // V2Val.chatControll.listDiscution.refresh();
  //     // debugPrint("ambil data discution");
  //   } catch (e) {
  //     EasyLoading.showToast(e.toString());
  //     throw e.toString();
  //   }
  // }

  Future<void> loadIssueDashboard() async {
    final data = await V2Api.issueByStatusId().getByParams(V2Role().myStatusId);
    V2Val.homeControll.listIssueDashboard.value.val = jsonDecode(data.body);
    V2Val.homeControll.listIssueDashboard.refresh();
    debugPrint("ambil data issue by ${V2Role().myRoleName}");
  }

  clear() {
    listIssueDashboard.value.val = [];
    V2Val.selectedIssueId.val = "";
  }
}

class V2IHomeDetailController {
  final type = {}.val("V2IssueDetail_type").obs;
  final showDetail = false.val("V2IssueDetail_show_detail").obs;
  final content = {}.val("V2IssueDetail_content").obs;
  final image = "".val("V2IssueDetail_image").obs;
  // final listDiscution = [].val("V2IssueDetail_listDiscution").obs;
  
  clear() {
    type.value.val = {};
    showDetail.value.val = false;
    content.value.val = {};
    image.value.val = "";
    // listDiscution.value.val = [];
    // contentText.text = "";
  }
}

class V2ChatController {
  final listDiscution = [].val("listDiscution").obs;

  clear() {
    listDiscution.value.val = [];
  }
}
