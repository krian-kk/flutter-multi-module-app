
import 'cross_platform_crypto_platform_interface.dart';

class CrossPlatformCrypto {
  Future<String?> getDecryptedData(Map<String, dynamic> text) {
    return CrossPlatformCryptoPlatform.instance.getDecryptedData(text);
  }

  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) {
    return CrossPlatformCryptoPlatform.instance.sendEncryptedData(requestData);
  }
}
