import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';

class Conn {
  static const String _host = "http://103.171.85.55:3000";
  static const String host = _host;
  static const String _api = "/api/v1";
  static const String _url = _host + _api;
  static const String _client = '$_url/client';
  static const String _product = '$_url/product';
  static const String _position = '$_url/position';
  static const String _departement = '$_url/departement';
  static const String _role = '$_url/role';
  static const String _issueType = '$_url/issue-type';
  static const String _user = '$_url/user';
  static const String _issuePriority = '$_url/issue-priority';
  static const String _issue = '$_url/issue';

  static const String _login = '$_host/login';

  static final Map<String, String> _header = {"authorization": "Bearer ${Val.token.value.val}"};
  static const String _errorServer = "error_server_500";
  static const String _server201Ok = "server_ok_201";

  static Future<http.Response> cek(http.Response res) async {
    if (res.statusCode == 401 || res.statusCode == 403) {
      EasyLoading.showError("session habis , mohon login kembali");
      await 1.delay();
      Routes.login().goOff();
      await 1.delay();
      return res;
    } else {
      return res;
    }
  }

  // client
  static Future<http.Response> clientGet() async => cek(
        await http.get(
          Uri.parse(_client),
          headers: _header,
        ),
      );

  static Future<http.Response> clientPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> clientPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> clientDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );

  // product
  static Future<http.Response> productGet() async => cek(
        await http.get(
          Uri.parse(_product),
          headers: _header,
        ),
      );
  static Future<http.Response> productPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> productPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> productDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );

  // position
  static Future<http.Response> positionGet() async => cek(
        await http.get(
          Uri.parse(_position),
          headers: _header,
        ),
      );
  static Future<http.Response> positionPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> positionPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> positionDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );

  // departement
  static Future<http.Response> departementGet() async => cek(await http.get(Uri.parse(_departement), headers: _header));
  static Future<http.Response> departementPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> departementPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> departementDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );

  // role
  static Future<http.Response> roleGet() async => cek(
        await http.get(
          Uri.parse(_role),
          headers: _header,
        ),
      );
  static Future<http.Response> rolePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> rolePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> roleDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );

  // issue type
  static Future<http.Response> issueTypeGet() async => cek(
        await http.get(
          Uri.parse(_issueType),
          headers: _header,
        ),
      );
  static Future<http.Response> issueTypePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> issueTypePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> issueTypeDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );

  // user
  static Future<http.Response> userGet() async => cek(await http.get(Uri.parse(_user), headers: _header));

  // issue priority
  static Future<http.Response> issuePriorityGet() async => cek(
        await http.get(
          Uri.parse(_issuePriority),
          headers: _header,
        ),
      );

  // issue
  static Future<http.Response> issueGet() async => cek(await http.get(Uri.parse(_issue), headers: _header));
  static Future<http.Response> issuePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> issuePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );
  static Future<http.Response> issueDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );

  // login
  static Future<http.Response> login(Map body) => http.post(Uri.parse(_login), body: body);

  // static bool _cekOk(String data) => !data.contains(_errorServer) || data.contains(_server201Ok);

  void _pengolahMap(http.Response data, Function(Map value, bool ada) onData) {
    try {
      final jsonData = Map.from(json.decode(data.body)['data']);
      onData(jsonData, jsonData.isEmpty ? false : true);
    } catch (e) {
      onData({}, false);
    }
  }

  void _pengolahList(http.Response data, Function(List value, bool ada) onData) {
    try {
      final jsonData = List.from(json.decode(data.body)['data']);
      onData(jsonData, jsonData.isEmpty ? false : true);
    } catch (e) {
      onData([], false);
    }
  }

  loadFirst() async {
    await loadUser();
    await loadIssuePriority();
    await loadIssue();
    await loadIssueTpe();
    await loadRole();
    await loadDepartement();
    await loadPosition();
    await loadProduct();
    await loadClient();
  }

  loadClient() async {
    _pengolahList(await clientGet(), (value, ada) async {
      if (ada) {
        Val.clients.value.val = value;
        Val.clients.refresh();
        EasyLoading.showInfo("client laoded");
        await 1.delay();
      }
    });
  }

  loadProduct() async {
    _pengolahList(await productGet(), (value, ada) async {
      if (ada) {
        Val.products.value.val = value;
        Val.products.refresh();
        EasyLoading.showInfo("product laoded");
        await 1.delay();
      }
    });
  }

  loadPosition() async {
    _pengolahList(await positionGet(), (value, ada) async {
      if (ada) {
        Val.positions.value.val = value;
        Val.positions.refresh();
        EasyLoading.showInfo("position laoded");
        await 1.delay();
      }
    });
  }

  loadDepartement() async {
    _pengolahList(await departementGet(), (value, ada) async {
      if (ada) {
        Val.departements.value.val = value;
        Val.departements.refresh();
        EasyLoading.showInfo("departement laoded");
        await 1.delay();
      }
    });
  }

  loadRole() async {
    _pengolahList(await roleGet(), (value, ada) async {
      if (ada) {
        Val.roles.value.val = value;
        Val.roles.refresh();
        EasyLoading.showInfo("role laoded");
        await 1.delay();
      }
    });
  }

  loadIssueTpe() async {
    _pengolahList(await issueTypeGet(), (value, ada) async {
      if (ada) {
        Val.issueTypes.value.val = value;
        Val.issueTypes.refresh();
        EasyLoading.showInfo("issue tpe laoded");
        await 1.delay();
      }
    });
  }

  // load user
  loadUser() async {
    _pengolahMap(await userGet(), (value, ada) async {
      if (ada) {
        Val.user.value.val = value;
        Val.user.refresh();
        EasyLoading.showInfo("user laoded");
        await 1.delay();
      }
    });
  }

  // load issue priority
  loadIssuePriority() async {
    _pengolahList(await issuePriorityGet(), (value, ada) async {
      if (ada) {
        Val.issuePriorities.value.val = value;
        Val.issuePriorities.refresh();
        EasyLoading.showInfo("issue priority laoded");
        await 1.delay();
      }
    });
  }

  loadIssue()async{
    _pengolahList(await issueGet(), (value, ada) async {
      if (ada) {
        Val.issues.value.val = value;
        Val.issues.refresh();
        EasyLoading.showInfo("issue laoded");
        await 1.delay();
      }
    });
  }
}
