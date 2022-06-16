import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/val.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Pref {
  String get userRole => (Val.user.value.val["Role"]?['name'] ?? "").toString();
  String get userName => (Val.user.value.val["name"] ?? "").toString();
  bool get isSuperAdmin => Val.user.value.val['Role']['name'] == 'Super Admin';
  bool get isLeader => Val.user.value.val['Role']['name'] == 'Leader';
  bool get isAdmin => Val.user.value.val['Role']['name'] == 'Admin';
  bool get isUser => Val.user.value.val['Role']['name'] == 'User';
  bool get isModerator => Val.user.value.val['Role']['name'] == 'Moderator';

  bool get isLoggedIn => Val.user.value.val['name'] != null;

  /// super admin
  bool get isRole1 => isSuperAdmin;

  /// superadmin | admin
  bool get isRole2 => isSuperAdmin || isAdmin;

  // superadmin | admin | leader
  bool get isRole3 => isSuperAdmin || isAdmin || isLeader;

  // superadmin | admin | leader | user
  bool get isRole4 => isSuperAdmin || isAdmin || isLeader || isUser;
}
