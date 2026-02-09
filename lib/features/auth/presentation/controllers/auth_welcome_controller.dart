import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/navigation/route_paths.dart';
import 'package:shadow_log/shadow_log.dart';

class AuthWelcomeController extends GetxController {
  void onRegisterAction(BuildContext context) {
    context.push(RoutePaths.register);
  }

  void onLoginAction(BuildContext context) {
    ShadowLog.d('on login tap');
    context.push(RoutePaths.login);
  }
}
