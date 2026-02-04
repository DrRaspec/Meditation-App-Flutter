import 'package:flutter_adaptive_kit/flutter_adaptive_kit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/core/navigation/app_router.dart';
import 'package:meditation_app/core/services/auth_service.dart';
import 'package:meditation_app/core/services/theme_service.dart';

Future<void> initAppDependencies() async {
  await GetStorage.init();
  await AdaptiveUtils.ensureScreenSize();

  Get.put(AuthService());
  Get.put(ThemeService());
}

GoRouter buildAppRouter() {
  return createRouter(Get.find<AuthService>());
}
