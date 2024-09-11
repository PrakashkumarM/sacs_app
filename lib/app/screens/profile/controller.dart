import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';

class ProfileController extends GetxController {
  var obscureText = true.obs;
  var isLoading = false.obs;

  // Create controllers for email and password input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Form validation logic
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // Form submission logic
  Future<void> formSubmit(
      String username, String email, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      // API Call

      NavigationHelper.navigateAndClearStack('/dashboard');
    }
  }
}
