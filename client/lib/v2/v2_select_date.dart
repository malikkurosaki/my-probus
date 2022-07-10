import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class V2SelectDate extends StatelessWidget {
  const V2SelectDate({Key? key, required this.value}) : super(key: key);

  final Rx<ReadWriteValue<String>> value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Date"),
            Obx(() => Text(
                  DateFormat("dd MMMM yyyy").format(DateTime.parse(value.value.val)),
                  style: TextStyle(fontSize: 12),
                )),
          ],
        ),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.parse(value.value.val),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
          ).then((date) {
            if (date != null) {
              value.value.val = date.toString();
              value.refresh();
            }
          });
        },
        trailing: Icon(Icons.calendar_today),
      ),
    );
  }
}
