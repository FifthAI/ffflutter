import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ffi';  // For FFI
import 'dart:io';   // For Platform.isX

final DynamicLibrary nativeAddLib =
Platform.isAndroid
    ? DynamicLibrary.open("libnative_ffmpeg.so")
    : DynamicLibrary.open("/usr/local/lib/libffflutter.a");
//    : DynamicLibrary.open("libPods-Runner.a");
//    : DynamicLibrary.open("ffflutter.framework/ffflutter");

final int Function(int x, int y) nativeAdd =
nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class Ffflutter {
  static const MethodChannel _channel =
      const MethodChannel('ffflutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
