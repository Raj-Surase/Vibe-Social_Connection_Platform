import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLinksDeepLink extends GetxService {
  AppLinksDeepLink._privateConstructor();

  static final AppLinksDeepLink _instance =
      AppLinksDeepLink._privateConstructor();

  static AppLinksDeepLink get instance => _instance;

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeAppLinks();
  }

  void _initializeAppLinks() {
    try {
      _appLinks = AppLinks();
      initDeepLinks();
    } catch (e) {
      debugPrint('Failed to initialize AppLinks: $e');
    }
  }

  Future<void> initDeepLinks() async {
    try {
      // Check initial link if app was in cold state (terminated)
      final appLink = await _appLinks.getInitialLink();
      if (appLink != null) {
        var uri = Uri.parse(appLink.toString());
        print('Here you can redirect from URL as per your need');
      }

      // Handle link when app is in warm state (front or background)
      _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
        print('You will listen to any URL updates');
        print('Here you can redirect from URL as per your need');
      }, onError: (err) {
        debugPrint('====>>> error : $err');
      }, onDone: () {
        _linkSubscription?.cancel();
      });
    } catch (e) {
      debugPrint('Error in initDeepLinks: $e');
    }
  }
}
