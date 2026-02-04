import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final _box = GetStorage();

  final _isLoggedInKey = 'isLoggedIn';

  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    isLoggedIn.value = _box.read(_isLoggedInKey) ?? false;
    super.onInit();
  }

  void login() {
    isLoggedIn.value = true;
    _box.write(_isLoggedInKey, true);
  }

  void logout() {
    isLoggedIn.value = false;
    _box.write(_isLoggedInKey, false);
  }
}
