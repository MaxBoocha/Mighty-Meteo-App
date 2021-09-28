import 'package:mightymeteomap/screens/authenticate/authenticate.dart';
import 'package:mightymeteomap/screens/home/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isLoggedIn = false.obs;

  @override
  void onReady() {
    super.onReady();
    _setInitialScreen();
  }

  _setInitialScreen() {
    if (!isLoggedIn.value) {
      Get.offAll(() => const Authenticate());
    } else {
      Get.offAll(() => const Home());
    }
  }
}
