import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;

  void formSubmit() {
    NavigationHelper.navigateAndReplace('dashboard');
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username or email';
    }
    // Simple email validation
    // final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    // if (!emailRegex.hasMatch(value)) {
    //   return 'Enter a valid email address';
    // }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\W).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, with one uppercase letter and one symbol';
    }
    return null;
  }
}
