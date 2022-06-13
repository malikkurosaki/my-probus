import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


class Val {
  static final indexHome = 0.val('indexhome').obs;
  static final selectedPage = "Home".val('selectedPage').obs;
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

  
  static Future<void> logout()async{
    GetStorage().erase();
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
    Get.deleteAll();
  
    // try {
    //   indexHome.value.val = 0;
    //   user.value.val = {};
    //   token.value.val = "";
    //   listContent.value.val = [];
    //   listRequest.value.val = [];
    //   listTodo.value.val = [];

    //   clients.value.val = [];
    //   products.value.val = [];
    //   positions.value.val = [];
    //   departements.value.val = [];
    //   roles.value.val = [];
    //   issueTypes.value.val = [];
    //   issuePriorities.value.val = [];
    //   issues.value.val = [];
    //   issueDetail.value.val = {};
    //   discussion.value.val = [];

    //   indexHome.refresh();
    //   user.refresh();
    //   token.refresh();
    //   listContent.refresh();
    //   listRequest.refresh();
    //   listTodo.refresh();

    //   clients.refresh();
    //   products.refresh();
    //   positions.refresh();
    //   departements.refresh();
    //   roles.refresh();
    //   issueTypes.refresh();
    //   issuePriorities.refresh();
    //   issues.refresh();
    //   issueDetail.refresh();
    //   discussion.refresh();
      
      
    // } catch (e) {
    //   debugPrint(e.toString());
    // } 
  }
}
