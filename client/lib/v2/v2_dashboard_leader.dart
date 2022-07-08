import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_probus/v2/v2_component.dart';
import 'package:my_probus/v2/v2_filter_dashboard_button.dart';
import 'package:my_probus/v2/v2_ismobile_widget.dart';
import 'package:my_probus/v2/v2_print_report.dart';
import 'package:my_probus/v2/v2_val.dart';
import 'v2_role.dart';



class V2DashboardLeader extends StatelessWidget {
  V2DashboardLeader({Key? key}) : super(key: key);
  final _showDrawerFilter = false.obs;

  // final doc = pw.Document();

  // Future<Uint8List>  _generatePdf(PdfPageFormat format, List contents) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(DateFormat('dd/MM/yyyy').format(DateTime.now()), style: pw.TextStyle(font: font, fontSize: 16)),
  //             pw.Divider(),
  //             for (final itm in contents)
  //               pw.Column(
  //                 children: [
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                         width: 70,
  //                         child: pw.Text(
  //                           "Name",
  //                           style: pw.TextStyle(
  //                             font: font,
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                       ),
  //                       pw.Flexible(
  //                           child: pw.Text(
  //                         itm['name'].toString(),
  //                       )),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Description",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           itm['des'].toString(),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Type",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           itm['IssueType']['name'].toString(),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Module",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           itm['Departement']['name'].toString(),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Product",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           itm['Product']['name'].toString(),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Creator",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           itm['CreatedBy']['name'].toString(),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(
  //                           width: 70,
  //                           child: pw.Text(
  //                             "Kapan",
  //                             style: pw.TextStyle(
  //                               font: font,
  //                               fontSize: 12,
  //                             ),
  //                           )),
  //                       pw.Flexible(
  //                         child: pw.Text(
  //                           // itm['dateSubmit'].toString(),
  //                           itm['dateSubmit'].toString() == "null" ? "-" :timeago.format(DateTime.parse(itm['dateSubmit'].toString())),
  //                           style: pw.TextStyle(font: font),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   pw.SizedBox(height: 10)
  //                 ],
  //               )
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }

  @override
  Widget build(BuildContext context) {
    return V2IsMobileWidget(
      isMobile: (isMobile) => ListView(
        controller: ScrollController(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: Colors.cyan,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          V2Val.user.val['name'].toString(),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          V2Val.user.val['Role']['name'].toString(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    V2Val.clock,
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      await V2Val.homeControll.loadIssueDashboard();
                      EasyLoading.showToast("Refreshed");
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
          ),
          Divider(
            color: Colors.cyan,
          ),
          Visibility(
            visible: !V2Role.user().isMe(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "the issue has passed a week ago",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Date Is Empty"),
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Need Your Handling",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                V2FilterDashboardButton(),
                V2PrinstReportButton()
              ],
            ),
          ),
          V2Component().listJobs(isMobile)
        ],
      ),
    );
  }

  // final _fileterType = {};
  // // final _filterStatus = {}.val("filter_status").obs;
  // final _filterModule = {};
  // final _filterProduct = {};
  // final _filterClient = {};
  // // final _filterUser = {}.val("filter_user").obs;

  // _filterButton(BuildContext context) => 
  // CircleAvatar(
  //       backgroundColor: Colors.grey.shade200,
  //       child: Center(
  //         child: IconButton(
  //           onPressed: () async {
  //             showBottomSheet(
  //               context: context,
  //               builder: (context) => V2Component.drawerFilter(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       _dropdownSearch(items: V2Val.listType.value.val, title: "Type", values: _fileterType),
  //                       // _dropdownSearch(items: V2Val.listStatus.value.val, title: "Status", values: _filterStatus),
  //                       _dropdownSearch(items: V2Val.listModule.value.val, title: "Module", values: _filterModule),
  //                       _dropdownSearch(items: V2Val.listProduct.value.val, title: "Product", values: _filterProduct),
  //                       _dropdownSearch(items: V2Val.listClient.value.val, title: "Client", values: _filterClient),
  //                       // _dropdownSearch(items: V2Val.listUser.value.val, title: "User", values: _filterUser),
  //                       SizedBox(
  //                         height: 70,
  //                       ),
  //                       MaterialButton(
  //                         color: Colors.cyan,
  //                         child: Container(
  //                           width: double.infinity,
  //                           padding: EdgeInsets.all(10),
  //                           child: Center(
  //                             child: Text("Filter",
  //                                 style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           List bk = V2Val.backupListIssueDashboard.value.val;
  //                           List ls = [...bk];

  //                           if (_fileterType.isNotEmpty) {
  //                             ls = ls.where((element) => element['IssueType']['name'] == _fileterType['name']).toList();
  //                           }

  //                           if (_filterModule.isNotEmpty) {
  //                             ls = ls
  //                                 .where((element) => element['Departement']['name'] == _filterModule['name'])
  //                                 .toList();
  //                           }

  //                           if (_filterProduct.isNotEmpty) {
  //                             ls = ls.where((element) => element['Product']['name'] == _filterProduct['name']).toList();
  //                           }

  //                           if (_filterClient.isNotEmpty) {
  //                             ls = ls.where((element) => element['Client']['name'] == _filterClient['name']).toList();
  //                           }

  //                           V2Val.listIssueDashboard.value.val = ls;
  //                           V2Val.listIssueDashboard.refresh();
  //                           // debugPrint(ls.toString());
  //                         },
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           icon: Icon(
  //             Icons.filter_alt,
  //             color: Colors.cyan,
  //           ),
  //         ),
  //       ),
  //     );

  // _dropdownSearch({String? title, Map? values, required List items}) {
  //   final selected = values!.isEmpty ? {"name": "all", "id": "all"} : values;
  //   if (!items.map((e) => e['name']).toList().contains("all")) {
  //     items.insert(0, {"name": "all", "id": "all"});
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Text("Filter By $title"),
  //       DropdownSearch(
  //         dropdownDecoratorProps: DropDownDecoratorProps(
  //           dropdownSearchDecoration: InputDecoration(
  //               border: InputBorder.none, hintText: "Filter By $title", label: Text("Filter By $title")),
  //         ),
  //         itemAsString: (Map item) => item['name'].toString(),
  //         items: List<Map>.from(items),
  //         selectedItem: selected,
  //         onChanged: (item) {
  //           Map val = item as Map;
  //           if (val['name'] == "all") {
  //             val = {};
  //           } else {
  //             val = val;
  //           }

  //           values.assignAll(val);
  //           // debugPrint(item.toString());
  //         },
  //       ),
  //       // Divider()
  //     ],
  //   );
  // }
}
