import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'conn.dart';
import 'val.dart';

class Load {
  Future<Map> _pengolahMap(http.Response data) async {
    try {

      final jsonData = Map.from(json.decode(data.body)['data']);
      // onData(jsonData, jsonData.isEmpty ? false : true);
      return {
        'data': jsonData,
        'status': data.statusCode == 200 ? true : false,
      };
    } catch (e) {
      // onData({}, false);
      return {
        'data': {},
        'status': false,
      };
    }
  }

  Future<Map> _pengolahList(http.Response data) async {
    try {
      final jsonData = List.from(json.decode(data.body)['data']);
      // onData(jsonData, jsonData.isEmpty ? false : true);
      return {
        'data': jsonData,
        'status': data.statusCode == 200 ? true : false,
      };
    } catch (e) {
      // onData([], false);
      return {
        'data': [],
        'status': false,
      };
    }
  }

  Future<void> loadFirst({bool alert = false}) async {
    await loadUser(alert: alert);
    await loadIssuePriority(alert: alert);
    await loadIssue(alert: alert);
    await loadIssueTpe(alert: alert);
    await loadIssueStatus();
    await loadRole(alert: alert);
    await loadDepartement(alert: alert);
    await loadPosition(alert: alert);
    await loadProduct(alert: alert);
    await loadClient(alert: alert);
  }

  Future<void> loadDiscution() async {
    final data = await _pengolahList(await Conn().discusGet(Val.issueDetail.value.val["id"]));
    if (data['status']) {
      Val.discussion.value.val = List.from(data['data']);
      Val.discussion.refresh();
    }
  }

  Future<void> loadClient({bool alert = false}) async {
    final data = await _pengolahList(await Conn().clientGet());
    if (data['status']) {
      Val.clients.value.val = List.from(data['data']);
      Val.clients.refresh();
      if (alert) EasyLoading.showInfo("client laoded");
    }
  }

  Future<void> loadProduct({bool alert = false}) async {
    final data = await _pengolahList(await Conn().productGet());
    if (data['status']) {
      Val.products.value.val = List.from(data['data']);
      Val.products.refresh();
      if (alert) EasyLoading.showInfo("product laoded");
    }
  }

  Future<void> loadPosition({bool alert = false}) async {
    final data = await _pengolahList(await Conn().positionGet());
    if (data['status']) {
      Val.positions.value.val = List.from(data['data']);
      Val.positions.refresh();
      if (alert) EasyLoading.showInfo("position laoded");
    }
  }

  Future<void> loadDepartement({bool alert = false}) async {
    final data = await _pengolahList(await Conn().departementGet());
    if (data['status']) {
      Val.departements.value.val = List.from(data['data']);
      Val.departements.refresh();
      if (alert) EasyLoading.showInfo("departement laoded");
    }
  }

  Future<void> loadRole({bool alert = false}) async {
    final data = await _pengolahList(await Conn().roleGet());
    if (data['status']) {
      Val.roles.value.val = List.from(data['data']);
      Val.roles.refresh();
      if (alert) EasyLoading.showInfo("role laoded");
    }
  }

  Future<void> loadIssueTpe({bool alert = false}) async {
    final data = await _pengolahList(await Conn().issueTypeGet());
    if (data['status']) {
      Val.issueTypes.value.val = List.from(data['data']);
      Val.issueTypes.refresh();
      if (alert) EasyLoading.showInfo("issue type laoded");
    }
  }

  // load user
  Future<void> loadUser({bool alert = false}) async {
    final data = await _pengolahMap(await Conn().userGet());

    if (data['status']) {
      Val.user.value.val = data['data'];
      Val.user.refresh();
      if (alert) EasyLoading.showInfo("user laoded");
    } else {
      debugPrint("user not loaded");
      if (alert) EasyLoading.showError("failed to load user");
    }
  }

  // load issue priority
  Future<void> loadIssuePriority({bool alert = false}) async {
    final data = await _pengolahList(await Conn().issuePriorityGet());
    if (data['status']) {
      Val.issuePriorities.value.val = List.from(data['data']);
      Val.issuePriorities.refresh();
      if (alert) EasyLoading.showInfo("issue priority laoded");
    }
  }

  Future<void> loadIssue({bool alert = false}) async {
    final data = await _pengolahList(await Conn().issueGet());
    if (data['status']) {
      Val.issues.value.val = List.from(data['data']);
      Val.issues.refresh();
      if (alert) EasyLoading.showInfo("issue laoded");
    }
  }

  // load issue status get
  Future<void> loadIssueStatus({bool alert = false}) async {
    final data = await _pengolahList(await Conn().issueStatusGet());

    if (data['status']) {
      Val.issueStatuses.value.val = List.from(data['data']);
      Val.issueStatuses.refresh();
      if (alert) EasyLoading.showInfo("issue status laoded");
    }
  }

  // load dashboards
  Future<void> loadDashboard({bool alert = false}) async {
    final data = await _pengolahMap(await Conn().dashboardGet());

    if (data['status']) {
      Val.dashboards.value.val = Map.from(data['data']);
      Val.dashboards.refresh();
      if (alert) EasyLoading.showInfo("dashboard laoded");
    }
  }
}
