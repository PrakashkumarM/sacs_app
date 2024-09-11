import 'dart:async';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/models/user_model.dart';
import 'package:sacs_app/app/data/services/auth_session_service.dart';

class SplashController extends GetxController {
  final AuthSessionService _authSessionService = AuthSessionService();
  final UserController _userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  // Check if the user is logged in
  Future<void> _checkLoginStatus() async {
    bool isUserLoggedIn = await _authSessionService.isLoggedIn();

    Timer(Duration(seconds: 2), () async {
      if (isUserLoggedIn) {
        // Fetch user data from session
        var userDataMap = await _authSessionService.getUserData();
        print(userDataMap);

        _userController.saveUserDetails(userDataMap);
        // Navigate to Dashboard
        NavigationHelper.navigateAndReplace('dashboard');
      } else {
        // Navigate to Login
        NavigationHelper.navigateAndReplace('login');
      }
    });
  }
}
