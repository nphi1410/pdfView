import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_view/pdf_view.dart';
import 'package:pdf_view/pdf_view_platform_interface.dart';
import 'package:pdf_view/pdf_view_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPdfViewPlatform
    with MockPlatformInterfaceMixin
    implements PdfViewPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PdfViewPlatform initialPlatform = PdfViewPlatform.instance;

  test('$MethodChannelPdfView is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPdfView>());
  });

  test('getPlatformVersion', () async {
    PdfView pdfViewPlugin = PdfView();
    MockPdfViewPlatform fakePlatform = MockPdfViewPlatform();
    PdfViewPlatform.instance = fakePlatform;

    expect(await pdfViewPlugin.getPlatformVersion(), '42');
  });
}
