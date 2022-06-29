import 'package:http/http.dart' as http;

import 'v2_config.dart';

class V2Api {
  // login
  static Future<http.Response> login(Map body) =>  http.post(Uri.parse('${V2Config.host}/login'), body: body);
  
}
