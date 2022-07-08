import 'package:flutter/material.dart';
import 'package:my_probus/v2/v2_dashboard_admin.dart';
import 'package:my_probus/v2/v2_dashboard_leader.dart';
import 'package:my_probus/v2/v2_dashboard_moderator.dart';
import 'package:my_probus/v2/v2_dashboard_user.dart';
import 'package:my_probus/v2/v2_status.dart';
import 'package:my_probus/v2/v2_val.dart';

class V2Role {
  V2Role();

  late String id;
  late String name;

  // a1 do not remove this line
  V2Role.leader() {
    id = '2';
    name = 'Leader';
  }
  V2Role.moderator() {
    id = '3';
    name = 'Moderator';
  }
  V2Role.admin() {
    id = '4';
    name = 'Admin';
  }
  V2Role.superAdmin() {
    id = '5';
    name = 'Super Admin';
  }
  V2Role.user() {
    id = '1';
    name = 'User';
  }

  Map val() => {
        'id': id,
        'name': name,
      };

  List<V2Role> get all => [
        V2Role.leader(),
        V2Role.moderator(),
        V2Role.admin(),
        V2Role.superAdmin(),
        V2Role.user(),
      ];

  bool isMe() => V2Val.user.val['Role']['id'] == id;

  String get myRoleId => V2Val.user.val['Role']['id'];
  String get myRoleName => V2Val.user.val['Role']['name'];

  String get myStatusId {
    if(V2Role().myRoleName == V2Role.user().name){
      return V2Status.open().id;
    }else if(V2Role().myRoleName == V2Role.leader().name){
      return V2Status.open().id;
    }else if(V2Role().myRoleName == V2Role.moderator().name){
      return V2Status.accepted().id;
    }else if(V2Role().myRoleName == V2Role.admin().name){
      return V2Status.approved().id;
    }else{
      return "";
    }
   
  }

  Widget buttonStatusByRole(String issueId) {
     if (V2Role().myRoleName == V2Role.user().name) {
      return SizedBox.shrink();
    } else if (V2Role().myRoleName == V2Role.leader().name) {
      return V2HomeController().accepttRejectApproveButton(issueId);
    } else if (V2Role().myRoleName == V2Role.moderator().name) {
      return V2HomeController().approveOrDeclineButton(issueId);
    } else if (V2Role().myRoleName == V2Role.admin().name) {
      return V2HomeController().pendingProgresButton(issueId);
    } else {
      return Text("ini kosong");
    }
  }

  Widget get dashboardByRolw {
     if (V2Role().myRoleName == V2Role.user().name) {
      return V2DashboardUser();
    } else if (V2Role().myRoleName == V2Role.leader().name) {
      return V2DashboardLeader();
    } else if (V2Role().myRoleName == V2Role.moderator().name) {
      return V2DashboardModerator();
    } else if (V2Role().myRoleName == V2Role.admin().name) {
      return V2DashboardAdmin();
    } else {
      return Text("belum ada ");
    }
  }
}


