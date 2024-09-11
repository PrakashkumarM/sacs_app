import 'package:get/get.dart';
import 'package:sacs_app/app/data/models/user_model.dart';

class UserController extends GetxController {
  // Observable user details (use Rx types for reactivity)
  var userData = UserModel(id: '', username: '', password: '', role: '').obs;
  var isSalesRole = true.obs;

  // Function to save user details
  void saveUserDetails(Map<String, dynamic>? user) {
    if (user != null) {
      userData.value = UserModel.fromJson(user); // Update user data
      isSalesRole.value = userData.value.role == "sales";
    } else {
      // Optionally handle the case where user is null
      userData.value = UserModel(id: '', username: '', password: '', role: '');
    } // Update user data
    isSalesRole.value = userData.value.role == "sales";
  }

  // Function to clear user data (logout)
  void clearUserDetails() {
    userData.value = UserModel.empty(); // Clear user data
  }
}
