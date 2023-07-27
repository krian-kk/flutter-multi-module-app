import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_method_channel.dart';

abstract class NetworkPlatform extends PlatformInterface {
  /// Constructs a NetworkPlatform.
  NetworkPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkPlatform _instance = MethodChannelNetwork();

  /// The default instance of [NetworkPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetwork].
  static NetworkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkPlatform] when
  /// they register themselves.
  static set instance(NetworkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDecryptedData(String text) {
    throw UnimplementedError('getDecryptedData has not been implemented.');
  }

  Future<String?> sendEncryptedData(Map<String, dynamic> requestData) {
    throw UnimplementedError('sendEncryptedData() has not been implemented.');
  }
}
