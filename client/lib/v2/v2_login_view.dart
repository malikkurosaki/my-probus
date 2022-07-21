import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_api.dart';
import 'package:my_probus/v2/v2_image_widget.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_routes.dart';
import 'package:my_probus/v2/v2_storage.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_probus/val.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:soundpool/soundpool.dart';
import 'package:http/http.dart' as http;
import 'v2_models/v2_user_model.dart';

const listAppLog = [
  "login with email ada passsword",
  "add issue by user",
  "print report by leader",
  "change status by leader",
  "ability chat / commen on issue",
  "add image by CTRL + v",
  "dashboard personaly by leader departement",
  "list issue globaly",
  "add todo personaly",
  "update  todo personaly",
  "delete  todo personali",
  "list todo globaly by user and date"
];

class V2LoginView extends StatelessWidget {
  V2LoginView({Key? key}) : super(key: key);
  final _email = "".val("V2LoginView_email").obs;
  final _password = "".val("V2LoginView_password").obs;

  

  @override
  Widget build(BuildContext context) {
    
    return V2IsMobileWidget(
      isMobile: (isMobile) => isMobile ? _mobilePart(isMobile) : _webPart(isMobile),
    );
  }

  Widget _webPart(bool isMobile) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: V2ImageWidget.logo(height: 200),
                ),
                Flexible(
                  child: Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Change Log App",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(16),
                            child: ListView(
                              children: [
                                for (final ls in listAppLog)
                                  Text(
                                    "- $ls",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        _mobilePart(isMobile)
      ]);

  Widget _mobilePart(bool isMobile) => SizedBox(
        width: isMobile ? Get.width : 400,
        child: Card(
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    V2ImageWidget.login(height: 200),
                    
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: TextFormField(
                              onChanged: (value) => _email.value.val = value,
                              controller: TextEditingController(text: _email.value.val),
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              onChanged: (value) => _password.value.val = value,
                              controller: TextEditingController(text: _password.value.val),
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.cyan,
                  onPressed: () async {
                    final body = {
                      "email": _email.value.val,
                      "password": _password.value.val,
                    };

                    if (body.values.contains("")) {
                      EasyLoading.showError("Please fill all fields");
                      return;
                    }

                    EasyLoading.show(status: "Logging in...");
                    final lgn = await V2Api.login(body);
                    if(lgn.statusCode == 200) {
                     try {
                        V2Val().logout();
                        EasyLoading.dismiss();

                        V2Val.user.val = jsonDecode(lgn.body);

                        await V2Val.homeControll.loadIssueDashboard();
                        Get.offAllNamed(V2Routes.home().key);
                      } catch (e) {
                        EasyLoading.showError("Something went wrong");
                        throw e.toString();
                      }
                    } else {
                      EasyLoading.showError("Login failed wrong email or password");
                    }
                    
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
