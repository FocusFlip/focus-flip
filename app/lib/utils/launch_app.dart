import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:focus_flip/models/app.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchApp(App app) async {
  if (Platform.isAndroid) {
    await LaunchApp.openApp(
        androidPackageName: app.packageName!, iosUrlScheme: app.url);
  } else if (Platform.isIOS) {
    Uri uri = Uri.parse(app.url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  } else {
    throw Exception("Unknown platform");
  }
}
