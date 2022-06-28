import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_probus/conn.dart';
import 'package:my_probus/load.dart';
import 'package:my_probus/models/model_status.dart';
import 'package:get/get.dart';
import 'package:my_probus/val.dart';

class ButtonStatus extends StatelessWidget {
  const ButtonStatus(
      {Key? key, required this.visibleFor, required this.paramA, required this.paramB, required this.issueId})
      : super(key: key);
  final bool visibleFor;
  final ModelStatus paramA;
  final ModelStatus paramB;
  // final Rx<ReadWriteValue<String>> note;
  final String issueId;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibleFor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            MaterialButton(
              color: Colors.blue,
              child: Text(paramA.name.toString(), style: TextStyle(color: Colors.white)),
              onPressed: () {
                final note = TextEditingController();
                Get.dialog(
                  AlertDialog(
                    title: Text("Accept"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Are you sure to accept this issue?"),
                        // TextFormField(
                        //   controller: note,
                        //   decoration: InputDecoration(fillColor: Colors.grey.shade50, filled: true, hintText: ""),
                        // )
                      ],
                    ),
                    actions: [
                      MaterialButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          // if (note.text.isEmpty) {
                          //   EasyLoading.showError("Please fill note");
                          //   return;
                          // }

                          final body = {
                            "issueId": issueId,
                            "issueStatusesId": paramA.id,
                            "note": "",
                          };

                          final ptc = await Conn().issuePatchStatus(body);
                          debugPrint(ptc.body);

                          if (ptc.statusCode == 200) {
                            await Load().loadIssue();
                            Get.back();
                            EasyLoading.showSuccess("Success");
                          } else {
                            EasyLoading.showError("Failed");
                          }
                        },
                      ),
                      MaterialButton(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            MaterialButton(
              color: Colors.pink,
              child: Text("Reject", style: TextStyle(color: Colors.white)),
              onPressed: () {
                final note = TextEditingController();
                Get.dialog(
                  AlertDialog(
                    title: Text("Reject"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Are you sure to reject this issue?"),
                        // pilih prioritas
                        // TextFormField(
                        //   // onChanged: (value) => _noteController.value.val = value,
                        //   controller: note,
                        //   maxLength: 100,
                        //   maxLines: 5,
                        //   decoration: InputDecoration(
                        //     labelText: "Reason",
                        //     hintText: "Please enter reason",
                        //   ),
                        // )
                      ],
                    ),
                    actions: [
                      MaterialButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          // if (note.text.isEmpty) {
                          //   EasyLoading.showError("Please enter reason");
                          //   return;
                          // }

                          final body = {
                            "issueId": issueId,
                            "issueStatusesId": paramB.id,
                            "note": "",
                          };

                          final ptc = await Conn().issuePatchStatus(body);
                          debugPrint(ptc.body);

                          if (ptc.statusCode == 200) {
                            await Load().loadIssue();
                            Get.back();
                            EasyLoading.showSuccess("Success");
                          } else {
                            EasyLoading.showError("Failed");
                          }
                        },
                      ),
                      MaterialButton(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
