import 'dart:io';

import 'package:commons/commons.dart';
import 'package:flutter/foundation.dart';

class Environment {
  static String? platform;
  static String? deviceVersion;
  static String? appVersion;
  static String? deviceId;
  static Box? cacheBox;

  static String? apiKey;
  static String? apiEndpoint;

  Environment._();

  static Future<void> initialize({
    String? platform,
    String? deviceVersion,
    String? appVersion,
    String? deviceId,
    Box? cacheBox,
    String? apiKey,
    String? apiEndpoint,
  }) async {
    Environment.platform = kIsWeb ? 'web' : Platform.operatingSystem;
    Environment.deviceVersion = deviceVersion;
    Environment.appVersion = appVersion;
    Environment.deviceId = deviceId;

    Environment.apiKey = const String.fromEnvironment('API_KEY');
    Environment.apiEndpoint =
        '${const String.fromEnvironment('API_ENDPOINT')}?api_key=${Environment.apiKey}';

    /// Have configuration
    var hiveBoxPath = 'nasa_app';
    if (Environment.platform != 'web') {
      var appDocumentDirectory = await getApplicationDocumentsDirectory();
      hiveBoxPath = '${appDocumentDirectory.path}/nasa_app';
    }
    Hive.init(hiveBoxPath);
    Environment.cacheBox = await Hive.openBox('nasa_app');
  }
}
