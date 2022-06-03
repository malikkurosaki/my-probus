import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeRequestForm extends StatelessWidget {
  HomeRequestForm({Key? key, required this.sizingInformation}) : super(key: key);
  final SizingInformation sizingInformation;
  final _controller = {
    'title': TextEditingController(),
    'description': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              BackButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Form Request",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controller['title'],
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Title",
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controller['description'],
            textAlign: TextAlign.start,
            maxLength: 1000,
            maxLines: 10,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "Description",
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            color: Colors.blue,
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              final body = {
                'title': _controller['title']!.text,
                'description': _controller['description']!.text,
              };

              if (body.values.contains("")) {
                EasyLoading.showError("Please fill all the fields");
                return;
              }

              final listContent = Val.listContent.value.val;
              final listRequest = Val.listRequest.value.val;
              listContent.add(body);
              listRequest.add(body);

              Val.listRequest.value.val = listRequest;
              Val.listRequest.refresh();
              Val.listContent.value.val = listContent;
              Val.listContent.refresh();

              EasyLoading.showSuccess("Request has been sent");
            },
          ),
        ),
      ],
    ));
  }
}
