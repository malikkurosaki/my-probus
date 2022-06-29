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
import 'package:my_probus/v2/v2_val.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
              mainAxisSize: MainAxisSize.min,
              children: [
                V2ImageWidget.logo(height: 200),
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

                    try {
                      EasyLoading.dismiss();
                      V2Val.user.value.val = jsonDecode(lgn.body);
                      Get.offAllNamed(V2Routes.home);
                    } catch (e) {
                      EasyLoading.showError("Something went wrong");
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