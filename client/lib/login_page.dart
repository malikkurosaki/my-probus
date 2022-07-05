import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/components/petunjuk_penggunaan.dart';
import 'package:my_probus/conn.dart';

import 'package:my_probus/homes/super_admin.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:soundpool/soundpool.dart';
import 'package:url_launcher/url_launcher.dart';

import 'routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  // final _controller = <String, TextEditingController>{
  //   "email": TextEditingController(),
  //   "password": TextEditingController(),
  // };

  final _email = "".val("LoginPage_email").obs;
  final _password = "".val("LoginPage_password").obs;

  _onload() {
    Val.logout();
  }

  @override
  Widget build(BuildContext context) {
    _onload();

    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) =>
            // login page with form
            Material(
          child: Row(
            children: [
              Visibility(
                visible: !sizingInformation.isMobile,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: Get.width - 460,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: Conn().host + "/images/logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    footer(context, sizingInformation, !sizingInformation.isMobile)
                  ],
                ),
              ),
              Container(
                color: Colors.cyan.withOpacity(0.4),
                width: sizingInformation.isMobile ? Get.width : 460,
                height: Get.height,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: CachedNetworkImage(imageUrl: '${Conn().host}/images/login.png'),
                            ),
                            ListTile(
                              title: Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextFormField(
                                onChanged: (value) => _email.value.val = value,
                                controller: TextEditingController(text: _email.value.val),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.white54,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                      width: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextFormField(
                                onChanged: (value) => _password.value.val = value,
                                controller: TextEditingController(text: _password.value.val),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white54,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                      width: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              subtitle: MaterialButton(
                                elevation: 0,
                                color: Colors.cyan,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  final body = {
                                    "email": _email.value.val,
                                    "password": _password.value.val,
                                  };

                                  if (body.values.contains("")) {
                                    EasyLoading.showError("Please fill all the fields");
                                    return;
                                  }

                                  final res = await Conn().login(body);
                                  if (res.statusCode == 200) {
                                    Val.token.value.val = jsonDecode(res.body)['token'].toString();
                                    Val.token.refresh();

                                    await Load().loadFirst();

                                    await Get.dialog(
                                      AlertDialog(
                                        title: Text("Login Successful"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: Conn().host + "/images/tos.png",
                                              height: Get.height * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                              "Welcome back, ${Val.user.value.val['name']}",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "You are now logged in",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          MaterialButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                      barrierDismissible: false,
                                    );

                                    Routes.home().goOff();
                                  } else {
                                    EasyLoading.showError(
                                        res.statusCode == 401 ? "wrong email or password" : res.statusCode.toString());
                                  }
                                },
                              ),
                            ),
                            footer(context, sizingInformation, sizingInformation.isMobile)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    MaterialButton(
                      child: Text("Powered By Probus System"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Powered By Probus System"),
                            content: Column(
                              children: [
                                Text("Probus System is a software developed by PT. Probus Teknologi Indonesia"),
                              ],
                            ),
                            actions: [
                              MaterialButton(
                                child: Text("OK"),
                                onPressed: () => Get.to(SuperAdmin()),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget footer(BuildContext context, SizingInformation sizingInformation, bool visible) => Visibility(
        visible: visible,
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            downloadApp(sizingInformation),
            PetunjukPenggunaan(),
            Divider(),
          ],
        ),
      );

  Widget downloadApp(SizingInformation sizingInformation) => Container(
        padding: EdgeInsets.all(20),
        child: MaterialButton(
            child: CachedNetworkImage(
              imageUrl: "${Conn().host}/images/android_download.png",
              width: 150,
            ),
            onPressed: () async {
              final url = Uri.parse("${Conn().host}/my-probus-apk");
              if (!await launchUrl(url)) throw 'Could not launch $url}';
            }),
      );
}
