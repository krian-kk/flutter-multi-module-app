import 'network_platform_interface.dart';

class Network {
  Future<String?> getDecryptedData(String text) {
    return NetworkPlatform.instance.getDecryptedData(text);
  }

  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) {
    return NetworkPlatform.instance.sendEncryptedData(requestData);
  }
}
