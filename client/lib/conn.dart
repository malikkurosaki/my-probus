import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'dart:io';

class Conn {
  get _host => "https://makurostudio.my.id";
  get host => _host;
  get hostImage => "$_host/image";
  get _api => "/api/v1";
  get _url => _host + _api;

  get _client => '$_url/client';
  get _product => '$_url/product';
  get _position => '$_url/position';
  get _departement => '$_url/departement';
  get _role => '$_url/role';
  get _issueType => '$_url/issue-type';
  get _user => '$_url/user';
  get _issuePriority => '$_url/issue-priority';
  get _issue => '$_url/issue';
  get _upload => '$_url/upload';
  get _imageDeleteFile => '$_url/file/delete-file';
  get _imageDeleteDb => '$_url/file/delete-db';
  get _discus => '$_url/discus';
  get _dashboard => '$_url/dashboard';
  // get _issuePatchStatus => '$_url/issue/patch-status';
  get _issueStatus => '$_url/issue-status';
  Map<String, String> get _header => {"authorization": "Bearer ${Val.token.value.val}"};
  get _errorServer => "error_server_500";
  get _server201Ok => "server_ok_201";
  get _login => '$_host/login';

  bool kembali = true;
  Future<http.Response> cek(http.Response res) async {
    if (res.statusCode == 401 || res.statusCode == 403) {
      if (kembali) {
        EasyLoading.showError("session habis , mohon login kembali");
        await 1.delay();
        Routes.login().goOff();
        await 1.delay();
        kembali = false;
      }
      return res;
    } else {
      return res;
    }
  }

  // image handler
  Future<List?> imageHandler() async {
    final upload = http.MultipartRequest('POST', Uri.parse(_upload));
    final image = await ImagePicker().pickMultiImage(maxHeight: 500, maxWidth: 500);
    if (image!.isNotEmpty) {
      for (var img in image) {
        upload.files.add(http.MultipartFile.fromBytes("image", await img.readAsBytes(), filename: ".png"));
      }

      upload.headers.addAll(_header);
      final res = await upload.send().then((value) => value.stream.bytesToString());
      return jsonDecode(res)['data'];
    } else {
      return null;
    }
  }

  // image delete
  Future<http.Response> imageDeleteFile(String name) =>
      http.delete(Uri.parse("$_imageDeleteFile/$name"), headers: _header);

  // client
  Future<http.Response> clientGet() async => cek(
        await http.get(
          Uri.parse(_client),
          headers: _header,
        ),
      );

  Future<http.Response> clientPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> clientPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> clientDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_client),
          body: data,
          headers: _header,
        ),
      );

  // discus get by issue id
  Future<http.Response> discusGet(String id) async => cek(
        await http.get(
          Uri.parse("$_discus/$id"),
          headers: _header,
        ),
      );

  // discus post
  Future<http.Response> discusPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_discus),
          body: data,
          headers: _header,
        ),
      );

  // product
  Future<http.Response> productGet() async => cek(
        await http.get(
          Uri.parse(_product),
          headers: _header,
        ),
      );
  Future<http.Response> productPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> productPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> productDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_product),
          body: data,
          headers: _header,
        ),
      );

  // position
  Future<http.Response> positionGet() async => cek(
        await http.get(
          Uri.parse(_position),
          headers: _header,
        ),
      );
  Future<http.Response> positionPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> positionPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> positionDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_position),
          body: data,
          headers: _header,
        ),
      );

  // departement
  Future<http.Response> departementGet() async => cek(await http.get(Uri.parse(_departement), headers: _header));
  Future<http.Response> departementPost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> departementPut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> departementDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_departement),
          body: data,
          headers: _header,
        ),
      );

  // role
  Future<http.Response> roleGet() async => cek(
        await http.get(
          Uri.parse(_role),
          headers: _header,
        ),
      );
  Future<http.Response> rolePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> rolePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> roleDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_role),
          body: data,
          headers: _header,
        ),
      );

  // issue type
  Future<http.Response> issueTypeGet() async => cek(
        await http.get(
          Uri.parse(_issueType),
          headers: _header,
        ),
      );
  Future<http.Response> issueTypePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> issueTypePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> issueTypeDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_issueType),
          body: data,
          headers: _header,
        ),
      );

  // user
  Future<http.Response> userGet() async => cek(await http.get(Uri.parse(_user), headers: _header));

  // issue priority
  Future<http.Response> issuePriorityGet() async => cek(
        await http.get(
          Uri.parse(_issuePriority),
          headers: _header,
        ),
      );

  // issue
  Future<http.Response> issueGet() async => cek(await http.get(Uri.parse(_issue), headers: _header));
  Future<http.Response> issuePost(Map<String, dynamic> data) async => cek(
        await http.post(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> issuePut(Map<String, dynamic> data) async => cek(
        await http.put(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );
  Future<http.Response> issueDelete(Map<String, dynamic> data) async => cek(
        await http.delete(
          Uri.parse(_issue),
          body: data,
          headers: _header,
        ),
      );

  // issue patch status
  Future<http.Response> issuePatchStatus(Map<String, dynamic> data) async => cek(
        await http.patch(
          Uri.parse(_issue + '/patch-status'),
          body: data,
          headers: _header,
        ),
      );

  // issue status get
  Future<http.Response> issueStatusGet() async => cek(
        await http.get(
          Uri.parse(_issueStatus),
          headers: _header,
        ),
      );

  // issue accepted get
  Future<http.Response> issueAccepted(Map<String, dynamic> data) async => cek(
        await http.get(
          Uri.parse(_issue + '/accepted'),
          headers: _header,
        ),
      );

  // login
  Future<http.Response> login(Map body) => http.post(Uri.parse(_login), body: body);

  //  bool _cekOk(String data) => !data.contains(_errorServer) || data.contains(_server201Ok);

  // dashboard
  Future<http.Response> dashboardGet() async => cek(
        await http.get(
          Uri.parse(_dashboard),
          headers: _header,
        ),
      );
}
