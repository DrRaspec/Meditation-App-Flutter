import 'package:get/get.dart';
import 'package:meditation_app/features/auth/presentation/controllers/welcome_controller.dart';

void ensureAuthDependencies() {
  if (!Get.isRegistered<WelcomeController>()) {
    Get.lazyPut<WelcomeController>(() => WelcomeController(), fenix: true);
  }
}
