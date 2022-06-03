import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_probus/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeHome extends StatelessWidget {
  const HomeHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Obx(
          () => ListView(
            children: Val.listContent.value.val.map(
              (e) {
                return Card(
                  child: ListTile(
                    title: Text(e['title']),
                    subtitle: Text(e['description']),
                    onTap: () {},
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
