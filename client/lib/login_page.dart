import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) =>
          // login page with form
          Material(
        child: Row(
          children: [
            Expanded(
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
                      title:
                          Text("LOGIN", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
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
                        onPressed: () {
                          debugPrint(Val.users.value.val.toString());
            
                          final body = {
                            "email": _controller["email"]!.text,
                            "password": _controller["password"]!.text,
                          };
            
                          if (body.values.contains("")) {
                            EasyLoading.showError("Please fill all the fields");
                            return;
                          }
            
                          final result = Val.users.value.val
                              .where((user) => user["email"] == body["email"] && user["password"] == body["password"])
                              .toList();
            
                          if (result.isNotEmpty) {
                            Val.user.value.val = result.first;
                            Routes.home().go();
                          } else {
                            EasyLoading.showError("User not found");
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("Don't have an account?"),
                      subtitle: MaterialButton(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () => Routes.register().go(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !sizingInformation.isMobile,
              child: Container(
                width: Get.width - 340,
              )),
          ],
        ),
      ),
    );
  }
}
