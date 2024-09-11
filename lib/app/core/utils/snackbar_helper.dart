import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class SnackbarHelper {
  // Common Snackbar method
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = CustomColors.black,
    Color textColor = CustomColors.white,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}
