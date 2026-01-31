import 'package:url_launcher/url_launcher.dart';

final _privacyUrl = Uri.parse('https://vitinho-dev.github.io/');

Future<void> openPrivacyPolicy() async {
  if (!await launchUrl(_privacyUrl)) {
    throw Exception('Could not launch $_privacyUrl');
  }
}
