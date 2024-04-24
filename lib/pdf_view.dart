
import 'pdf_view_platform_interface.dart';

class PdfView {
  Future<String?> getPlatformVersion() {
    return PdfViewPlatform.instance.getPlatformVersion();
  }
}
