import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cross_platform_crypto_platform_interface.dart';

/// An implementation of [CrossPlatformCryptoPlatform] that uses method channels.
class MethodChannelCrossPlatformCrypto extends CrossPlatformCryptoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cross_platform_crypto');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getDecryptedData(Map<String, dynamic> text) async {
    final version =
        await methodChannel.invokeMethod<String>('getDecryptedData', text);
    return version;
  }

  @override
  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) async {
    final version = await methodChannel.invokeMethod<String>(
        'sendEncryptedData', requestData);
    return version;
  }
}
