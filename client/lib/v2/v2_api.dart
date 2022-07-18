import 'package:http/http.dart'
as http;

import '../config.dart';

class V2Api {
  V2Api();
  late String path;

  // login
  static Future < http.Response > login(Map body) => http.post(Uri.parse('${Config.host}/login'), body: body);

  // a1 do not remove this line
  V2Api.todoDelete(): path = '/todo-delete';
  V2Api.todoChangeStatus(): path = '/todo-change-status';
  V2Api.todoGetAll(): path = '/todo-get-all';
  V2Api.todoCreate(): path = '/todo-create';
  V2Api.propertiesAll(): path = '/properties-all';
  V2Api.updateIssueStatus(): path = '/update-issue-status';
  V2Api.uploadImageSingle(): path = '/upload-image-single';
  V2Api.discutionCreate(): path = '/discution-create';
  V2Api.imageUploadSingle(): path = '/image-upload-single';
  V2Api.discutionByIssueId(): path = '/discution-by-issue-id';
  V2Api.issueById(): path = '/issue-by-id';
  V2Api.issueByStatusId(): path = '/issue-by-status-id';
  V2Api.statusGetAll(): path = '/status-get-all';
  V2Api.issueByRole(): path = '/issue-by-role';
  V2Api.issueCreate(): path = '/issue-create';
  V2Api.imageDelete(): path = '/image-delete';
  V2Api.clientGetIdByName(): path = '/client-get-id-by-name';
  V2Api.issueGetAll(): path = '/issue-get-all';
  V2Api.type(): path = '/type';
  V2Api.uploadImage(): path = '/upload-image';
  V2Api.modules(): path = '/modules';
  V2Api.products(): path = '/products';
  V2Api.client(): path = '/client';


  // get
  Future < http.Response > getByParams(String param) => http.get(Uri.parse('${Config.host}/api/v2$path/$param'));
  Future < http.Response > getData() => http.get(Uri.parse('${Config.host}/api/v2$path'));

  // post
  Future < http.Response > postData(Map body) => http.post(Uri.parse('${Config.host}/api/v2$path'), body: body);
  Future < http.Response > postDataParam(String param, Map body) =>
    http.post(Uri.parse('${Config.host}/api/v2$path/$param'), body: body);
  
  // delete
  Future < http.Response > deleteData(String param) => http.delete(Uri.parse('${Config.host}/api/v2$path/$param'));
}