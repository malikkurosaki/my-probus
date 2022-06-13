import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/routes.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
                child: Container(
                    width: Get.width - 460,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: Conn().host + "/images/logo.png",
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                color: Colors.blueGrey.shade100,
                width: sizingInformation.isMobile ? Get.width : 460,
                height: Get.height,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      // Image.asset('assets/images/login.jpg'),
                      SizedBox(
                        height: 300,
                        child: CachedNetworkImage(imageUrl: '${Conn().host}/images/login.png'),
                      ),
                      ListTile(
                        title: Text("LOGIN",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          onChanged: (value) => _email.value.val = value,
                          controller: TextEditingController(text: _email.value.val),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            label: Text("Email"),
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
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
                            label: Text("Password"),
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      ListTile(
                        subtitle: MaterialButton(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                      CachedNetworkImage(imageUrl: Conn().host + "/images/tos.png",
                                        height: Get.height * 0.3,
                                        fit: BoxFit.cover,
                                      ),
                                      Text("Welcome back, ${Val.user.value.val['name']}", 
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text("You are now logged in",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget loginMobile(SizingInformation sizingInformation) => SingleChildScrollView(
  //       controller: ScrollController(),
  //       child: Container(
  //         height: 1000,
  //         decoration: BoxDecoration(
  //           color: Colors.grey.shade100,
  //         ),
  //         padding: EdgeInsets.all(16),
  //         width: sizingInformation.isMobile ? double.infinity : 340,
  //         child: Column(
  //           children: [
  //             Text("Mobile"),
  //             // Image.asset('assets/images/login.jpg'),
  //             CachedNetworkImage(imageUrl: '${Conn.host}/images/login.png'),
  //             ListTile(
  //               title: Text("LOGIN", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
  //             ),
  //             ListTile(
  //               title: Text("Email"),
  //               subtitle: TextFormField(
  //                 controller: _controller["email"],
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Colors.white,
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //             ListTile(
  //               title: Text("Password"),
  //               subtitle: TextFormField(
  //                 controller: _controller["password"],
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Colors.white,
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //             ListTile(
  //               subtitle: MaterialButton(
  //                 color: Colors.blue,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     "Login",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 onPressed: () async {
  //                   debugPrint(Val.users.value.val.toString());

  //                   final body = {
  //                     "email": _controller["email"]!.text,
  //                     "password": _controller["password"]!.text,
  //                   };

  //                   if (body.values.contains("")) {
  //                     EasyLoading.showError("Please fill all the fields");
  //                     return;
  //                   }

  //                   final res = await Conn.login(body);
  //                   if (res.statusCode == 200) {
  //                     Val.token.value.val = jsonDecode(res.body)['token'];
  //                     Val.token.refresh();
  //                     await Conn().loadFirst(alert: true);
  //                     Routes.home().goOff();
  //                   } else {
  //                     EasyLoading.showError(
  //                         res.statusCode == 401 ? "wrong email or password" : res.statusCode.toString());
  //                   }
  //                 },
  //               ),
  //             ),
  //             // ListTile(
  //             //   title: Text("Don't have an account?"),
  //             //   subtitle: MaterialButton(
  //             //     color: Colors.blue,
  //             //     child: Padding(
  //             //       padding: const EdgeInsets.all(8.0),
  //             //       child: Text(
  //             //         "Register",
  //             //         style: TextStyle(
  //             //           color: Colors.white,
  //             //           fontSize: 20,
  //             //           fontWeight: FontWeight.bold,
  //             //         ),
  //             //       ),
  //             //     ),
  //             //     onPressed: () => Routes.register().go(),
  //             //   ),
  //             // )
  //           ],
  //         ),
  //       ),
  //     );
}
