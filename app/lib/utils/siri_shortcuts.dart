import 'package:url_launcher/url_launcher.dart';

Future<void> runSiriShortcut(String name) async {
  // TODO: implement `input` and `text`
  // https://support.apple.com/de-de/guide/shortcuts/apd624386f42/ios

  // TODO: check if `name` has to be escaped/sanitized because of possible vulnerabilities

  final Uri url = Uri.parse('shortcuts://run-shortcut?name=$name');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
