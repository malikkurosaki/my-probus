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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_box,
                color: value.isNotEmpty ? Colors.green : Colors.grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Icon(Icons.arrow_drop_down),
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
