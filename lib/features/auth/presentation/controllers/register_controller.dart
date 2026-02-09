import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterController extends GetxController {
  static const String privacyPolicyUrl =
      'https://meditation-legal-site-frj8.vercel.app/privacy';
  static const String termsOfServiceUrl =
      'https://meditation-legal-site-frj8.vercel.app/terms';
  static const String cookiesPolicyUrl =
      'https://meditation-legal-site-frj8.vercel.app/cookies';
  static const String gdprPolicyUrl =
      'https://meditation-legal-site-frj8.vercel.app/gdpr';

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  String? userValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'User is required';
    }

    return null;
  }

  String? emailValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Email is required';
    } else if (!text.isEmail) {
      return 'Invalid email address';
    }

    return null;
  }

  String? passwordValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  Future<void> openPrivacyPolicy() async {
    await _openUrl(privacyPolicyUrl);
  }

  Future<void> openTermsOfService() async {
    await _openUrl(termsOfServiceUrl);
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final success = await launchUrl(
      uri,
      mode: LaunchMode.inAppBrowserView,
    );
    if (!success) {
      debugPrint('Could not launch $url');
    }
  }
}
