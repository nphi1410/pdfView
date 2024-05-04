import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf_view/sfpdf_viewer.dart';
import 'entity.dart';

class MyPdfPage extends StatelessWidget {
  final List<PdfUrl> linkList;

  const MyPdfPage(this.linkList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pdf'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: linkList.map((pdfUrl) {
            return SizedBox(
              width: double.infinity, // Button width is full screen
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // No border radius
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPdfViewer(url: pdfUrl.bytes ?? Uint8List(0)),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    '${linkList.indexOf(pdfUrl) + 1}. ${pdfUrl.title}',
                    textAlign: TextAlign.left, // Set text alignment to left
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
