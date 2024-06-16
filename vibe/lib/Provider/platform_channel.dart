import 'package:flutter/services.dart';

class PlatformChannels {
  static const MethodChannel _methodChannel =
      MethodChannel('test.deeplink.flutter.dev/channel');
  static const EventChannel _eventChannel =
      EventChannel('test.deeplink.flutter.dev/events');

  Future<String?> getInitialLink() async {
    try {
      final String? initialLink =
          await _methodChannel.invokeMethod('initialLink');
      return initialLink;
    } on PlatformException catch (e) {
      print("Failed to get initial link: '${e.message}'.");
      return null;
    }
  }

  Stream<String?> getLinkStream() {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as String?);
  }
}
