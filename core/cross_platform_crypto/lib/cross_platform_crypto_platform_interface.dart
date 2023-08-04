import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cross_platform_crypto_method_channel.dart';

abstract class CrossPlatformCryptoPlatform extends PlatformInterface {
  /// Constructs a CrossPlatformCryptoPlatform.
  CrossPlatformCryptoPlatform() : super(token: _token);

  static final Object _token = Object();

  static CrossPlatformCryptoPlatform _instance = MethodChannelCrossPlatformCrypto();

  /// The default instance of [CrossPlatformCryptoPlatform] to use.
  ///
  /// Defaults to [MethodChannelCrossPlatformCrypto].
  static CrossPlatformCryptoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CrossPlatformCryptoPlatform] when
  /// they register themselves.
  static set instance(CrossPlatformCryptoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getDecryptedData(Map<String, dynamic> text) {
    throw UnimplementedError('getDecryptedData has not been implemented.');
  }

  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) {
    throw UnimplementedError('sendEncryptedData() has not been implemented.');
  }
}
