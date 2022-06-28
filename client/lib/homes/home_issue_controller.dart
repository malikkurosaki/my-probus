import 'package:get_storage/get_storage.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';

class HomeIssueController {
  static final listIssue = [].val("HomeMain_listIssue").obs;
  static final listIssueBackup = [].val("HomeMain_listIssueBackup").obs;
  static final listIssueStatusBackup = [].val("HomeMain_listIssueStatusBackup").obs;
  static final selectDate = DateTime.now().val("HomeMain_selectDate").obs;

  static final search = "".val("HomeMain_search").obs;

  static onLoad() async {
    await Load().loadIssue();

    listIssue.value.val = Val.issues.value.val;
    // _listIssueBackup.value.val = Val.issues.value.val;
    listIssueStatusBackup.value.val = listIssue.value.val;
    listIssue.refresh();

    final types = List.from(
      Val.issues.value.val.where(
        (e) => e['IssueType']['id'] == Val.seletctedCategory.value.val['id'],
      ),
    );

    if (types.isNotEmpty) {
      listIssue.value.val = types;
      listIssue.refresh();
    }

    final statuses = List.from(
      listIssueStatusBackup.value.val.where(
        (e) => e['issueStatusesId'].toString() == Val.selectedStatus.value.val['id'].toString(),
      ),
    );

    if (statuses.isNotEmpty) {
      listIssue.value.val = statuses;
      listIssue.refresh();
    }

    // debugPrint("_listIssue.value.val: ${_listIssue.value.val}");
  }
}
