import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/routes.dart';

import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final _controller = <String, TextEditingController>{
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) =>
              // login page with form
              Row(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  padding: EdgeInsets.all(16),
                  width: sizingInformation.isMobile ? double.infinity : 340,
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      ListTile(
                        title: Text("REGISTER",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      ListTile(
                        title: Text("Name"),
                        subtitle: TextFormField(
                          controller: _controller["name"],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Email"),
                        subtitle: TextFormField(
                          controller: _controller["email"],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Password"),
                        subtitle: TextFormField(
                          controller: _controller["password"],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ListTile(
                        subtitle: MaterialButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Register",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            final _body = {
                              "name": _controller["name"]!.text,
                              "email": _controller["email"]!.text,
                              "password": _controller["password"]!.text,
                            };
              
                            if(_body.values.contains("")){
                              EasyLoading.showError("Please fill all the fields");
                              return;
                            }
              
                            Val.users.value.val.add(_body);
                            Val.users.refresh();
              
                            Routes.login().goOff();
                            
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("Already have an account?"),
                        subtitle: MaterialButton(
                          color: Colors.blue,
                          onPressed: () => Routes.login().go(),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !sizingInformation.isMobile,
                child: Container(
                  width: Get.width - 340,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
