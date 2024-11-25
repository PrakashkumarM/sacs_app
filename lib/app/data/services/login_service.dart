import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/core/utils/snackbar_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class LoginService {
  final ApiService _apiService = ApiService();

  // Login API call
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await _apiService.dioInstance.get('/users');
      print('login: $response');
      // Parsing the response to find the user with the given credentials
      final List<dynamic> users = response.data;
      final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        print('Login successful: ${user['username']}');
        SnackbarHelper.showSnackbar(
          title: 'Success',
          message: 'Login Successfully',
          position: SnackPosition.TOP,
          backgroundColor: CustomColors.success,
        );
        return user; // Return the whole user data
      } else {
        SnackbarHelper.showSnackbar(
          title: 'Error',
          message: 'Invalid username or password',
          position: SnackPosition.TOP,
          backgroundColor: CustomColors.error,
        );
        print('Invalid username or password');
        return null;
      }
    } catch (e) {
      print('Error Message => $e');
      return null;
    }
  }
}
