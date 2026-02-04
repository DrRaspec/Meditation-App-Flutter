import 'package:get/get.dart';
import 'package:meditation_app/features/home/presentation/controllers/home_controller.dart';

void ensureHomeDependencies() {
  if (!Get.isRegistered<HomeController>()) {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
