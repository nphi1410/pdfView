import 'dart:typed_data';
import 'package:http/http.dart' as http;

class PdfUrl {
  String title;
  String url;
  Uint8List? bytes;

  PdfUrl(this.title, this.url);

  // Method to fetch PDF bytes from URL
  Future<void> fetchPdfBytes() async {
    const int maxRetries = 3;
    int retryCount = 0;
    while (retryCount < maxRetries) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          bytes = response.bodyBytes;
          return; // Exit the loop if successful
        } else {
          throw Exception('Failed to fetch PDF: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching PDF: $e');
        retryCount++;
        if (retryCount < maxRetries) {
          print('Retrying...');
          await Future.delayed(Duration(seconds: retryCount)); // Exponential backoff
        }
      }
    }
    throw Exception('Failed to fetch PDF after $maxRetries attempts');
  }
}


class Links {
  List<PdfUrl> list = [];

  // Constructor to fetch PDF bytes for each URL
  Links() {
    list = [
      PdfUrl('testPdf', 'https://www.sldttc.org/allpdf/21583473018.pdf'),
      PdfUrl('Visual Studio IDE Tutorial', 'https://www.srii.sou.edu.ge/Visual%20Studio%20IDE%20Tutorial.pdf'),
      PdfUrl('NetBeans Manual', 'https://users.cs.fiu.edu/~smithjo/classnotes_2xxxx/netbeans.manual.pdf'),
      PdfUrl('IntelliJ IDEA', 'https://riptutorial.com/Download/intellij-idea.pdf')
    ];

    // Fetch PDF bytes for each URL asynchronously
    list.forEach((pdfUrl) {
      pdfUrl.fetchPdfBytes();
    });
  }
}
