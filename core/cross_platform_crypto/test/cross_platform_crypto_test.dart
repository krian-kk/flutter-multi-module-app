import 'package:flutter_test/flutter_test.dart';
import 'package:cross_platform_crypto/cross_platform_crypto_platform_interface.dart';
import 'package:cross_platform_crypto/cross_platform_crypto_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCrossPlatformCryptoPlatform
    with MockPlatformInterfaceMixin
    implements CrossPlatformCryptoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getDecryptedData(Map<String, dynamic> text) {
    return Future.value('');
  }

  @override
  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) {
    return Future.value('');
  }
}

void main() {
  final CrossPlatformCryptoPlatform initialPlatform =
      CrossPlatformCryptoPlatform.instance;

  test('$MethodChannelCrossPlatformCrypto is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCrossPlatformCrypto>());
  });

  test('getPlatformVersion', () async {
    // CrossPlatformCrypto crossPlatformCryptoPlugin = CrossPlatformCrypto();
    // MockCrossPlatformCryptoPlatform fakePlatform =
    //     MockCrossPlatformCryptoPlatform();
    // CrossPlatformCryptoPlatform.instance = fakePlatform;
  });
}
