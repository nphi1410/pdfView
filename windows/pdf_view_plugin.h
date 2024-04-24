#ifndef FLUTTER_PLUGIN_PDF_VIEW_PLUGIN_H_
#define FLUTTER_PLUGIN_PDF_VIEW_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace pdf_view {

class PdfViewPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PdfViewPlugin();

  virtual ~PdfViewPlugin();

  // Disallow copy and assign.
  PdfViewPlugin(const PdfViewPlugin&) = delete;
  PdfViewPlugin& operator=(const PdfViewPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace pdf_view

#endif  // FLUTTER_PLUGIN_PDF_VIEW_PLUGIN_H_
