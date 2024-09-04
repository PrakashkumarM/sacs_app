import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationHelper {
  // Navigate to a named route
  static Future<T?>? navigateTo<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  // Navigate and replace the current route with a named route
  static Future<T?>? navigateAndReplace<T>(String routeName,
      {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  // Navigate and clear all previous routes
  static Future<T?>? navigateAndClearStack<T>(String routeName,
      {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  // Go back to the previous route
  static void goBack<T>({T? result}) {
    Get.back<T>(result: result);
  }

  // Navigate to a named route with removal of all previous routes until a specific route
  static Future<T?>? navigateAndRemoveUntil<T>(
      String routeName, String predicateRouteName,
      {dynamic arguments}) {
    return Get.offNamedUntil<T>(
        routeName, ModalRoute.withName(predicateRouteName),
        arguments: arguments);
  }

  // Go back until a specific route
  static void goBackUntil(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }
}
