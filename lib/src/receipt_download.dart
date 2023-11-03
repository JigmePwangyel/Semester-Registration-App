// import 'dart:io';
// import 'dart:ui';
// import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
// import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

// // ignore: camel_case_types
// class Receipt {
//   String? receiptHtml;

//   Receipt(this.receiptHtml);

//   Future<void> createDocument() async {
//     // String? downloadsDirectoryPath =
//     //     (await DownloadsPath.downloadsDirectory())?.path;
//     // final filePath = '${downloadsDirectoryPath}/r.pdf';
//     // print("The file path is $filePath");
//     // var file = File(filePath);

//     // final newpdf = Document();
//     // List<Widget> widgets = await HTMLToPdf().convert(receiptHtml!);
//     // newpdf.addPage(MultiPage(
//     //     maxPages: 200,
//     //     build: (context) {
//     //       return widgets;
//     //     }));
//     // await file.writeAsBytes(await newpdf.save());

//     String? downloadsDirectoryPath =
//         (await DownloadsPath.downloadsDirectory())?.path;
//     final targetPath = "$downloadsDirectoryPath";
//     final targetFileName = "receipt.pdf";

//     final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         receiptHtml!, targetPath, targetFileName);
//   }
// }
