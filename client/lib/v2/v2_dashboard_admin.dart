import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_probus/v2/v2_template_dashboard.dart';

class V2DashboardAdmin extends StatelessWidget {
  const V2DashboardAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return V2TemplateDashboard(
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Pending / Hold,  menahan atau membiarkan untuk beberapa waktu hingga dirasa mumengkinkan untuk dikerjakan",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Progress,  menerima dan akan mengerjakannya dengan segera",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Close, Menolak karena sudah terselesaikan tanpa penanganan khusus, atau problem telah diselesaikan dengan jalur yang berbeda",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
