import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_platform_crypto/cross_platform_crypto_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCrossPlatformCrypto platform = MethodChannelCrossPlatformCrypto();
  const MethodChannel channel = MethodChannel('cross_platform_crypto');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
