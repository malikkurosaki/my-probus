import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_probus/val.dart';
import 'package:animate_do/animate_do.dart' as animate;

class Select extends StatelessWidget {
  const Select({
    Key? key,
    required this.onSelect,
    required this.item,
    required this.title,
    required this.value,
    required this.subtitle,
  }) : super(key: key);

  final Function(Map value) onSelect;
  final Map value;
  final List item;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: title,
      child: ListTile(
        leading: Icon(
          Icons.check_box,
          color: value.isNotEmpty ? Colors.green : Colors.grey,
        ),
        title: Text(
          title,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
            ),
            Visibility(
              visible: value.isNotEmpty,
              child: Text(
                (value['name'] ?? "").toString().toUpperCase(),
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        for (final ist in item)
          PopupMenuItem(
            onTap: () {
              value.assignAll(ist);
              onSelect(ist);
            },
            value: ist,
            child: Text(ist['name']),
          ),
      ],
    );
  }
}
