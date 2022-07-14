import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'v2_val.dart';

class V2PrinstReportButton extends StatelessWidget {
  const V2PrinstReportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade200,
      child: IconButton(
        onPressed: () {
          final datanya = List.from(V2Val.listIssueDashboard.value.val);
          var ini = {};
          try {
            ini = groupBy(List<Map>.from(datanya), (x) => jsonDecode(jsonEncode(x))["Client"]['name']).map(
              (key, value) => MapEntry(
                key,
                groupBy(value, (x) => jsonDecode(jsonEncode(x))["Product"]['name'])
                    .map(
                      (key, value) => MapEntry(key, value),
                    )
                    .map((key, value) =>
                        MapEntry(key, groupBy(value, (x) => jsonDecode(jsonEncode(x))['IssueType']['name']))),
              ),
            );

            print(ini);
          } catch (e) {
            print(e);
          }

          showBottomSheet(
            context: context,
            builder: (context) {
              return Material(
                child: Column(
                  children: [
                    Row(
                      children: [BackButton()],
                    ),
                    Flexible(
                      child: PdfPreview(
                        build: (format) => _generatePdf(format, ini),
                      ),
                    ),
                  ],
                ),
              );
            },
            enableDrag: true,
          );
        },
        icon: Icon(Icons.print),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, Map contents) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    final datanya = List.from(V2Val.listIssueDashboard.value.val);
    var ini = {};
    try {
      ini = groupBy(List<Map>.from(datanya), (x) => jsonDecode(jsonEncode(x))["Client"]['name']).map(
        (key, value) => MapEntry(
          key,
          groupBy(value, (x) => jsonDecode(jsonEncode(x))["Product"]['name'])
              .map(
                (key, value) => MapEntry(key, value),
              )
              .map(
                  (key, value) => MapEntry(key, groupBy(value, (x) => jsonDecode(jsonEncode(x))['IssueType']['name']))),
        ),
      );

      print(ini);
    } catch (e) {
      print(e);
    }

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.ListView(
            children: [
                        for (final client in ini.keys)
              pw.Padding(
                padding: pw.EdgeInsets.all(8.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      client.toString(),
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    for (final product in ini[client].keys)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            product.toString(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          for (final issueType in ini[client][product].keys)
                            pw.Padding(
                              padding: pw.EdgeInsets.all(8.0),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.SizedBox(width: 100, child: pw.Text("Type ")),
                                      pw.Expanded(child: pw.Text(issueType.toString())),
                                    ],
                                  ),
                                  for (final issue in ini[client][product][issueType])
                                    pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Row(
                                          children: [
                                            pw.SizedBox(width: 100, child: pw.Text("Title")),
                                            pw.Expanded(child: pw.Text(issue['name'].toString())),
                                          ],
                                        ),
                                        pw.Row(
                                          children: [
                                            pw.SizedBox(width: 100, child: pw.Text("Description")),
                                            pw.Expanded(child: pw.Text(issue['des'].toString())),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    pw.Divider()
                  ],
                ),
              )
            ]
          );
          // pw.Column(
          //   crossAxisAlignment: pw.CrossAxisAlignment.start,
          //   children: [
          //     pw.Text(DateFormat('dd/MM/yyyy').format(DateTime.now()), style: pw.TextStyle(font: font, fontSize: 16)),
          //     pw.Divider(),
          //     for (final itm in contents)
          //       pw.Column(
          //         children: [
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                 width: 70,
          //                 child: pw.Text(
          //                   "Name",
          //                   style: pw.TextStyle(
          //                     font: font,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //               ),
          //               pw.Flexible(
          //                   child: pw.Text(
          //                 itm['name'].toString(),
          //               )),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Description",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   itm['des'].toString(),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Type",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   itm['IssueType']['name'].toString(),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Module",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   itm['Departement']['name'].toString(),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Product",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   itm['Product']['name'].toString(),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Creator",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   itm['CreatedBy']['name'].toString(),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.Row(
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.SizedBox(
          //                   width: 70,
          //                   child: pw.Text(
          //                     "Kapan",
          //                     style: pw.TextStyle(
          //                       font: font,
          //                       fontSize: 12,
          //                     ),
          //                   )),
          //               pw.Flexible(
          //                 child: pw.Text(
          //                   // itm['dateSubmit'].toString(),
          //                   itm['dateSubmit'].toString() == "null"
          //                       ? "-"
          //                       : timeago.format(DateTime.parse(itm['dateSubmit'].toString())),
          //                   style: pw.TextStyle(font: font),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           pw.SizedBox(height: 10)
          //         ],
          //       )
          //   ],
          // );
        },
      ),
    );

    return pdf.save();
  }
}
