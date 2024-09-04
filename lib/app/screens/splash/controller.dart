import 'dart:async';

import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 2), () {
      NavigationHelper.navigateAndReplace('login');
    });
  }
}
