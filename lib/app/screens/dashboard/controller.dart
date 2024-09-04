import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  DashboardController();
  final formKey = GlobalKey<FormState>();
  final tabIndex = 0.obs;

  void changeTabIndex(int value) {
    // Close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    // Change tab
    tabIndex.value = value;
  }
}
