import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_role.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class V2Val {
  static final isMobile = false.val('isMobile').obs;
  static final hasLogin = false.val('hasLogin').obs;
  static final user = {}.val('user');
  static final listIssueByUser = [].val("listIssueByUser").obs;
  static final listIssueByLeader = [].val("listIssueByLeader").obs;
  static final listIssueByModerator = [].val("listIssueByModerator").obs;
  static final listIssueByAdmin = [].val("listIssueByAdmin").obs;
  static final issueDetailId = "".val("issueDetailId").obs;
  static final selectedIssueId = "".val("V2Val_selectedIssueId").obs;

  static final listIssueDashboard = [].val("listIssueDashboard").obs;

  static final backupListIssueDashboard = [].val("backupListIssueDashboard").obs;

  static final homeControll = V2HomeController();
  static final detailControll = V2IHomeDetailController();
  static final chatControll = V2ChatController();

  static final listType = [].val("V2Val_listType").obs;
  static final listStatus = [].val("V2Val_listStatus").obs;
  static final listRole = [].val("V2Val_listRole").obs;
  static final listUser = [].val("V2Val_listUser").obs;
  static final listIssue = [].val("V2Val_listIssue").obs;
  static final listModule = [].val("V2Val_listModule").obs;
  static final listProduct = [].val("V2Val_listProduct").obs;
  static final listClient = [].val("V2Val_listClient").obs;

  static final listTodo = [].val("V2Val_listTodo").obs;

  clear() async {
    isMobile.value.val = false;
    hasLogin.value.val = false;
    user.val = {};
    listIssueByUser.value.val = [];
    listIssueByAdmin.value.val = [];
    listIssueByLeader.value.val = [];
    listIssueByModerator.value.val = [];
    issueDetailId.value.val = "";

    // listType.value.val = [];
    // listStatus.value.val = [];
    // listRole.value.val = [];
    // listUser.value.val = [];
    // listIssue.value.val = [];
    // listModule.value.val = [];
    // listProduct.value.val = [];
    // listClient.value.val = [];

    // await GetStorage().erase();

    debugPrint("clear data");
  }

  logout() {
    V2Val().clear();
    V2Val.homeControll.clear();
    V2Val.detailControll.clear();
    V2Val.chatControll.clear();
  }

  static final clock = DigitalClock(
    areaAligment: AlignmentDirectional.topEnd,
    areaDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    hourMinuteDigitTextStyle: const TextStyle(
      fontSize: 30,
      color: Colors.black,
    ),
    secondDigitTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 30,
    ),
    amPmDigitTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    is24HourTimeFormat: true,
    hourMinuteDigitDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    showSecondsDigit: true,
    secondDigitDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
  );
}

class V2HomeController {
  // final listIssueDashboard = [].val("listIssueDashboard").obs;
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

  _updateWithNote(Object value, String issueId, String note) async {
    final body = {"issueStatusesId": value.toString(), "usersId": V2Val.user.val['id'], "note": note};

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

  Widget accepttRejectApproveButton(String issueId) => PopupMenuButton(
        onSelected: (value) async {
          // 3 -> reject
          if (value == "3") {
            final reasonController = TextEditingController();
            Get.dialog(SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add Reason",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: reasonController,
                          decoration: InputDecoration(hintText: "add reason here"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            color: Colors.cyan,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await _updateWithNote(value!, issueId, reasonController.text);
                              Get.back();
                            }),
                      )
                    ],
                  ),
                )
              ],
            ));
            return;
          }

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
          PopupMenuItem(
            child: Text(V2Status.approved().name),
            value: V2Status.approved().id,
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

  Widget resolveCloseButton(String issueId) => PopupMenuButton(
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
    // final data = await V2Api.issueByStatusId().getByParams(V2Role().myStatusId);
    final depId = V2Val.user.val['departementsId'];
    final statusId = V2Role().myStatusId;

    final data = await V2Api.issueByDepartementId().getByQuery('depId=$depId&statusId=$statusId');
    V2Val.listIssueDashboard.value.val = List<Map>.from(jsonDecode(data.body));
    V2Val.listIssueDashboard.refresh();
    V2Val.backupListIssueDashboard.value.val = List<Map>.from(jsonDecode(data.body));

    debugPrint("ambil data issue by ${V2Role().myRoleName}");
  }

  clear() {
    V2Val.listIssueDashboard.value.val = [];
    V2Val.selectedIssueId.value.val = "";
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
