#include "include/network/network_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "network_plugin.h"

void NetworkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  network::NetworkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
