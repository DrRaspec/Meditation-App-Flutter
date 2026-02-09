import 'package:get/get.dart';
import 'package:meditation_app/features/auth/presentation/controllers/auth_welcome_controller.dart';
import 'package:meditation_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:meditation_app/features/auth/presentation/controllers/register_controller.dart';

void ensureAuthDependencies() {
  if (!Get.isRegistered<AuthWelcomeController>()) {
    Get.lazyPut<AuthWelcomeController>(
      () => AuthWelcomeController(),
      fenix: true,
    );
  }

  if (!Get.isRegistered<LoginController>()) {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }

  if (!Get.isRegistered<RegisterController>()) {
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
  }
}
