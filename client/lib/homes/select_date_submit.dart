import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelectDateIndent extends StatelessWidget {
  const SelectDateIndent({Key? key, required this.dateSubmit}) : super(key: key);
  final Rx<ReadWriteValue<String>> dateSubmit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check_box),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: dateSubmit.value.val.isEmpty ? DateTime.now() : DateTime.parse(dateSubmit.value.val),
          firstDate: DateTime.now(), //DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1), //DateTime(DateTime.now().year + 1),
        );

        if (date != null) {
          dateSubmit.value.val = date.toString();
          dateSubmit.refresh();
        }
      },
      title: Text("Pilih Date Submit"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Indent Date Submit ( optional )"),
          Obx(
            () => dateSubmit.value.val.isEmpty
                ? SizedBox.shrink()
                : Text(
                    DateFormat("dd/MM/yyyy").format(DateTime.parse((dateSubmit.value.val))),
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
