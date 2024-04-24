import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pdf_view_platform_interface.dart';

/// An implementation of [PdfViewPlatform] that uses method channels.
class MethodChannelPdfView extends PdfViewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pdf_view');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
