import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mini_project/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("SplashScreenController onInit called");
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    print("Starting 3-second delay");
    await Future.delayed(Duration(seconds: 3));
    print("Delay finished, checking login status");
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User is logged in, navigating to HOME");
      Get.offAllNamed(Routes.HOME);
    } else {
      print("User is not logged in, navigating to LOGIN");
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
