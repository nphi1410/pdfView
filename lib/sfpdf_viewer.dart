import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdfrx/pdfrx.dart';

class MyPdfViewer extends StatefulWidget {
  final String url;
  MyPdfViewer(this.url);

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  String x = '0', y = '0', pageNum = '0';
  double? pageWidth, widDx, pageHeight, widDy, totalHeight;
  double? zoomLevel=1.0;

  @override
  void initState() {
    super.initState();
    getSize();
  }

  void getSize() async {
    try {
      PdfDocument document = await PdfDocument.openUri(Uri.parse(widget.url));
      if (document.pages.isNotEmpty) {
        setState(() {
          pageWidth = document.pages[0].width.toDouble();
          pageHeight = document.pages[0].height.toDouble();
          totalHeight = document.pages.length.toDouble() * (pageHeight ?? 0);
        });
      } else {
        print('Error: Unable to load PDF document');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double aspectRatio = screenWidth / (pageWidth ?? 1);
    double fitWidth = (pageWidth ?? 0) * aspectRatio;
    double fitHeight = (totalHeight ?? 0) * aspectRatio;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('height:${pageHeight?.toStringAsFixed(2)}/ ${totalHeight?.toStringAsFixed(2)}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: fitWidth,
                  height: fitHeight,
                  child: Stack(
                    children: [
                      SfPdfViewer.network(
                        widget.url,
                        pageSpacing: 5.0,
                        onTap: (details) {
                          setState(() {
                            widDx = details.position.dx;
                            widDy = details.position.dy;
                            x = details.pagePosition.dx.toStringAsFixed(2);
                            y = (pageHeight! - details.pagePosition.dy).toStringAsFixed(2);
                            pageNum = details.pageNumber.toString();
                          });
                        },
                        onZoomLevelChanged: (details) {
                          setState(() {
                            zoomLevel = details.newZoomLevel;
                          });
                          print('widX:$widDx');
                          print('widY:$widDy');
                          },

                      ),
                      if (widDx != null && widDy != null && x != '-1.00' && y != '-1.00')
                        Positioned(
                          top: widDy! - 18,
                          left: widDx! - 6,
                          child: Icon(Icons.edit),
                        ),
                    ],
                  ),
                ),
              ),
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
