
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPip {
  static const MethodChannel _channel = MethodChannel('flutter_pip');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
    static Future pip({PipRational aspectRatio = const PipRational(192, 108)}) {
    return _channel.invokeMethod('pip', {"aspectRatio": aspectRatio.toMap()});
  }
}


class PipRational {
  final int numerator;
  final int denominator;

  const PipRational(this.numerator, this.denominator);

  Map<String, int> toMap() {
    return {"numerator": numerator, "denominator": denominator};
  }
}

