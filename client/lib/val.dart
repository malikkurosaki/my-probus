import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


class Val {
  static final indexHome = 0.val('indexhome').obs;
  static final selectedPage = "Dashboard".val('selectedPage').obs;
  static final users = [].val('users').obs;
  static final user = {}.val("user").obs;
  static final token = "".val("token").obs;
  static final listContent = [].val("listContent").obs;
  static final listRequest = [].val('listRequest').obs;
  static final listTodo = [].val('listTodo').obs;
  static final clients = [].val("clients").obs;
  static final products = [].val("products").obs;
  static final positions = [].val("positions").obs;
  static final departements = [].val("departements").obs;
  static final roles = [].val("roles").obs;
  static final issueTypes = [].val("issuesTypes").obs;
  static final issuePriorities = [].val("issuePriorities").obs;
  static final issues = [].val("issues").obs;
  static final issueDetail = {}.val("issueDetail").obs;
  static final discussion = [].val("discussion").obs;
  static final issueAccepted = [].val("issueAccepted").obs;
  static final issueStatuses = [].val("issueStatuses").obs;
  static final dashboards = {}.val("dashboards").obs;
  static final issueHistories = [].val("issueHistories").obs;
  static final seletctedCategory = <String, dynamic>{"id": "all", "name": "all"}.val("_seletctedCategory").obs;
  static final selectedStatus = <String, dynamic>{"id": "all", "name": "all"}.val("_selectedStatus").obs;

  static Future<void> logout()async{
    GetStorage().remove("indexhome");
    GetStorage().remove("selectedPage");
    GetStorage().remove("users");
    GetStorage().remove('token');
    GetStorage().remove('user');
    GetStorage().remove('users');
    GetStorage().remove('listContent');
    GetStorage().remove('listRequest');
    GetStorage().remove('listTodo');
    GetStorage().remove('clients');
    GetStorage().remove('products');
    GetStorage().remove('positions');
    GetStorage().remove('departements');
    GetStorage().remove('roles');
    GetStorage().remove('issuesTypes');
    GetStorage().remove('issuePriorities');
    GetStorage().remove('issues');
    GetStorage().remove('issueDetail');
    GetStorage().remove('discussion');
    GetStorage().remove('issueAccepted');
    GetStorage().remove('issueStatuses');
    GetStorage().remove('dashboards');
    GetStorage().erase();
    Get.deleteAll();
  }
}
