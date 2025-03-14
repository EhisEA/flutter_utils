import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  /// Calls a phone number using the device's dialer.
  static Future<void> call(String phoneNumber) async {
    await _launch(Uri.parse("tel:$phoneNumber"), "Could not launch phone dialer for $phoneNumber");
  }

  /// Opens a web URL in the default browser.
  static Future<void> openURL(String url) async {
    await _launch(Uri.parse(url), "Could not open URL: $url");
  }

  /// Opens the default email app with prefilled details.
  static Future<void> sendEmail({required String email, String? subject, String? body}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    await _launch(emailUri, "Could not launch email client for $email");
  }

  /// Opens the messaging app with a prefilled SMS.
  static Future<void> sendSMS(String phoneNumber, {String? message}) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );
    await _launch(smsUri, "Could not launch SMS app for $phoneNumber");
  }

  /// Opens a WhatsApp chat with a given phone number.
  static Future<void> sendWhatsAppMessage(String phoneNumber, {String? message}) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phoneNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}",
    );
    await _launch(whatsappUri, "Could not launch WhatsApp for $phoneNumber");
  }

  /// Generic function to handle URL launching with error throwing.
  static Future<void> _launch(Uri uri, String errorMessage) async {
    try {
      if (!await canLaunchUrl(uri)) {
        throw Exception(errorMessage);
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw Exception("$errorMessage. Error: $e");
    }
  }
}
