import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pdf_view_method_channel.dart';

abstract class PdfViewPlatform extends PlatformInterface {
  /// Constructs a PdfViewPlatform.
  PdfViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static PdfViewPlatform _instance = MethodChannelPdfView();

  /// The default instance of [PdfViewPlatform] to use.
  ///
  /// Defaults to [MethodChannelPdfView].
  static PdfViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PdfViewPlatform] when
  /// they register themselves.
  static set instance(PdfViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
