import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/models/user_model.dart';
import 'package:sacs_app/app/data/services/auth_session_service.dart';
import 'package:sacs_app/app/data/services/login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final AuthSessionService _authSessionService = AuthSessionService();
  final UserController userController = Get.put(UserController());

  var obscureText = true.obs;
  var isLoading = false.obs;
  // Create controllers for email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Form validation logic
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
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
  Future<void> formSubmit(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      // Call login service to handle API request
      print('bef');

      final user = await _loginService.login(username, password);
      print(user);

      if (user != null) {
        // Handle successful login
        print('User logged in: $user');
        // Store user details in sesison
        _authSessionService.saveLoginSession(user);
        // Store user details in the UserController
        userController.saveUserDetails(user);
        // Navigate to dashboars
        NavigationHelper.navigateAndClearStack('/dashboard');
      } else {
        // Handle login failure
        print('Login failed');
      }
    }
  }
}
