import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:identity_server/identity_server.dart';

void main() {
  const MethodChannel channel = MethodChannel('identity_server');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterAppAuth.platformVersion, '42');
  });
}
