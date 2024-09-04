import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScreenUtils {
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double getScreenWidth() {
    return screenSize().width;
  }

  static double getScreenHeight() {
    return screenSize().height;
  }

  static void setStatusBarColor({
    required Color color,
    Brightness iconBrightness = Brightness.light,
    Brightness iconDarkBrightness = Brightness.dark,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconDarkBrightness));
  }
}
