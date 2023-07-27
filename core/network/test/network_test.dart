// import 'package:flutter_test/flutter_test.dart';
// import 'package:network/network.dart';
// import 'package:network/network_platform_interface.dart';
// import 'package:network/network_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockNetworkPlatform
//     with MockPlatformInterfaceMixin
//     implements NetworkPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final NetworkPlatform initialPlatform = NetworkPlatform.instance;
//
//   test('$MethodChannelNetwork is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelNetwork>());
//   });
//
//   test('getPlatformVersion', () async {
//     Network networkPlugin = Network();
//     MockNetworkPlatform fakePlatform = MockNetworkPlatform();
//     NetworkPlatform.instance = fakePlatform;
//
//     expect(await networkPlugin.getPlatformVersion(), '42');
//   });
// }
