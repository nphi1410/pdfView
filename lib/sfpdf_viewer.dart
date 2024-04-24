import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdfrx/pdfrx.dart';

class MyPdfViewer extends StatefulWidget {
  final String url;
  MyPdfViewer(this.url);

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  String x = '0', y = '0', pageNum='0';
  double? pageWidth;
  double? pageHeight;

  @override
  void initState() {
    super.initState();
    getSize();
  }

  void getSize() async {
    try {
      PdfDocument document = await PdfDocument.openUri(Uri.parse(widget.url));
      if (document != null && document.pages.isNotEmpty) {
        setState(() {
          pageWidth = document.pages[0].width;
          pageHeight = document.pages[0].height;
        });
      } else {
        // Handle the case when the document is null or has no pages
        print('Error: Unable to load PDF document');
      }
    } catch (e) {
      // Handle any exceptions that occur during document loading
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('PDF Viewer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SfPdfViewer.network(
              widget.url,
              pageSpacing: 5.0,
              onTap: (pagePosition) {
                setState(() {
                  x = pagePosition.pagePosition.dx.toStringAsFixed(4);
                  y = (pageHeight! - pagePosition.pagePosition.dy).toStringAsFixed(4);
                  pageNum = pagePosition.pageNumber.toString();
                });
              },
            ),
          ),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'x: $x y: $y page: $pageNum',
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
}
