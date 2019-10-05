import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ffflutter/ffflutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('ffflutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Ffflutter.platformVersion, '42');
  });
}
