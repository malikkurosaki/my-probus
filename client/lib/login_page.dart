import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _controller = <String, TextEditingController>{
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  _onload() {}

  @override
  Widget build(BuildContext context) {
    _onload();

    return ResponsiveBuilder(
      builder: (context, sizingInformation) =>
          // login page with form
          Material(
        child: Stack(
          children: [
            Visibility(
              visible: !sizingInformation.isMobile,
              child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: CachedNetworkImage(
                    imageUrl: Conn.host + "/images/logo.png",
                    fit: BoxFit.cover,
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  padding: EdgeInsets.all(16),
                  width: sizingInformation.isMobile ? double.infinity : 340,
                  child: Column(
                    children: [
                      // Image.asset('assets/images/login.jpg'),
                      CachedNetworkImage(imageUrl: '${Conn.host}/images/login.png'),
                      ListTile(
                        title: Text("LOGIN",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      ListTile(
                        title: Text("Email"),
                        subtitle: TextFormField(
                          controller: _controller["email"],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Password"),
                        subtitle: TextFormField(
                          controller: _controller["password"],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ListTile(
                        subtitle: MaterialButton(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                            debugPrint(Val.users.value.val.toString());
              
                            final body = {
                              "email": _controller["email"]!.text,
                              "password": _controller["password"]!.text,
                            };
              
                            if (body.values.contains("")) {
                              EasyLoading.showError("Please fill all the fields");
                              return;
                            }
              
                            final res = await Conn.login(body);
                            if (res.statusCode == 200) {
                              Val.token.value.val = jsonDecode(res.body)['token'];
                              Val.token.refresh();
                              await Conn().loadFirst();
                              Routes.home().goOff();
                            } else {
                              EasyLoading.showError(
                                  res.statusCode == 401 ? "wrong email or password" : res.statusCode.toString());
                            }
                          },
                        ),
                      ),
                      // ListTile(
                      //   title: Text("Don't have an account?"),
                      //   subtitle: MaterialButton(
                      //     color: Colors.blue,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         "Register",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //     onPressed: () => Routes.register().go(),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
