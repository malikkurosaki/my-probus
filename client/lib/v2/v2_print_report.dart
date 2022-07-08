import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'v2_val.dart';

class V2PrinstReportButton extends StatelessWidget {
  const V2PrinstReportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: IconButton(
                      onPressed: () {
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
                                      build: (format) => _generatePdf(format, V2Val.listIssueDashboard.value.val),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          enableDrag: true,
                        );
                      },
                      icon: Icon(Icons.print)),
                );
  }

  Future<Uint8List>  _generatePdf(PdfPageFormat format, List contents) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(DateFormat('dd/MM/yyyy').format(DateTime.now()), style: pw.TextStyle(font: font, fontSize: 16)),
              pw.Divider(),
              for (final itm in contents)
                pw.Column(
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          width: 70,
                          child: pw.Text(
                            "Name",
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        pw.Flexible(
                            child: pw.Text(
                          itm['name'].toString(),
                        )),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Description",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            itm['des'].toString(),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Type",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            itm['IssueType']['name'].toString(),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Module",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            itm['Departement']['name'].toString(),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Product",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            itm['Product']['name'].toString(),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Creator",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            itm['CreatedBy']['name'].toString(),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 70,
                            child: pw.Text(
                              "Kapan",
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 12,
                              ),
                            )),
                        pw.Flexible(
                          child: pw.Text(
                            // itm['dateSubmit'].toString(),
                            itm['dateSubmit'].toString() == "null" ? "-" :timeago.format(DateTime.parse(itm['dateSubmit'].toString())),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10)
                  ],
                )
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}