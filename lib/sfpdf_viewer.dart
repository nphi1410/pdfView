import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MyPdfViewer extends StatefulWidget {
  final Uint8List url;
  MyPdfViewer({required this.url});

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  double? x, y,reflectY;
  int? tapedPage;
  late Future<Uint8List> originData;
  late Future<Uint8List> editData;

  @override
  void initState() {
    super.initState();
    originData = Future.value(widget.url);
    editData = Future.value(widget.url);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Pdf view'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<Uint8List>(
              future: editData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SfPdfViewer.memory(
                      snapshot.data!,
                      onTap: (details) {
                        setState(() {
                          tapedPage = details.pageNumber;
                          x = details.pagePosition.dx;
                          y = details.pagePosition.dy;
                          PdfDocument doc = PdfDocument(inputBytes: snapshot.data);
                          reflectY = doc.pages[tapedPage!].size.height - y!;
                        });
                        _addAnnotation();
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading PDF'));
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'x: ${(x??0).toStringAsFixed(2)} y: ${(y??0).toStringAsFixed(2)} page: $tapedPage',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addAnnotation() async {
    Uint8List originBytes = await originData;
    PdfDocument document = PdfDocument(inputBytes: originBytes);
    PdfPage page = document.pages[(tapedPage! - 1)];

    final String assetName = 'assets/pen.png'; // Corrected asset path
    final ByteData? byteData = await rootBundle.load(assetName);
    if (byteData == null) {
      throw Exception('Failed to load PNG image');
    }
    final Uint8List pngBytes = byteData.buffer.asUint8List();

    final PdfBitmap pngImage = PdfBitmap(pngBytes);
    final Rect imageRect = Rect.fromLTWH(x!, y! - 24, 24, 24);

    page.graphics.drawImage(pngImage, imageRect);

    final Uint8List updatedDocument = Uint8List.fromList(await document.save());
    document.dispose();

    setState(() {
      editData = Future.value(updatedDocument);
    });
  }
}
