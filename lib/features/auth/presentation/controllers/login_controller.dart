import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';
import 'package:meditation_app/core/services/auth_service.dart';
import 'package:shadow_log/shadow_log.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

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

  void onRegisterTap(BuildContext context) {
    context.push(RoutePaths.register);
  }

  bool onLoginAction(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    ShadowLog.d('Login success', tag: 'Login Page');
    _authService.login();
    return true;
  }
}
