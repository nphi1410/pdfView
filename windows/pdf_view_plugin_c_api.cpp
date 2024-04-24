#include "include/pdf_view/pdf_view_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "pdf_view_plugin.h"

void PdfViewPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  pdf_view::PdfViewPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
