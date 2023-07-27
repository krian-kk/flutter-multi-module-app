import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'network_platform_interface.dart';

/// An implementation of [NetworkPlatform] that uses method channels.
class MethodChannelNetwork extends NetworkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('encryptionChannel');

  @override
  Future<String?> getDecryptedData(String text) async {
    final version =
        await methodChannel.invokeMethod<String>('getDecryptedData',text);
    return version;
  }

  @override
  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) async {
    final version = await methodChannel.invokeMethod<String>(
        'sendEncryptedData', requestData);
    return version;
  }
}
