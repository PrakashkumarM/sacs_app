import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/data/services/auth_session_service.dart';

class DashboardController extends GetxController {
  DashboardController();
  final formKey = GlobalKey<FormState>();
  final tabIndex = 0.obs;
  final AuthSessionService _authSessionService = AuthSessionService();

  void onInit() {
    super.onInit();

    // Check if tabIndex is passed via route arguments
    if (Get.arguments != null && Get.arguments['tabIndex'] != null) {
      int passedTabIndex = Get.arguments['tabIndex'];
      changeTabIndex(passedTabIndex);
    }
  }

  void logout() {
    _authSessionService.clearLoginSession();
    NavigationHelper.navigateAndClearStack('login');
  }

  void changeTabIndex(int value) {
    // Close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    // Change tab
    tabIndex.value = value;
  }
}
