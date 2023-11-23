import 'package:url_launcher/url_launcher.dart';
import 'package:zungu_mobile/main.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';

Future<void> launchMobile(String url) async {
  final Uri uri = Uri(scheme: 'tel', path: url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showAlert(context: getContext, message: 'Could not launch mobile $url');
  }
}

Future<void> launchEmail(String url) async {
  final Uri uri = Uri(scheme: 'mailto', path: url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showAlert(context: getContext, message: 'Could not launch email $url');
  }
}

Future<void> launchURL(String url) async {
  final Uri uri = Uri(scheme: 'https', path: url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showAlert(context: getContext, message: 'Could not launch $url');
  }
}
