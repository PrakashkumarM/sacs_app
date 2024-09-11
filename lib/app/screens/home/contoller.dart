import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/services/auth_session_service.dart';
import 'package:sacs_app/app/screens/profile/view.dart';

class HomeController extends GetxController {
  RxString selectedLocation = 'Madurai'.obs;
  List<String> locations = ['Madurai', 'Chennai', 'Coimbatore'];
  final AuthSessionService _authSessionService = AuthSessionService();
  final UserController userController = Get.find<UserController>();

  RxBool isExpanded = false.obs;

  List<Performer> topPerformers = [
    Performer('John Mathew', 35, 67, '₹3.9K'),
    Performer('Alex Mark', 30, 50, '₹2.8K'),
    // Add more performers here
  ];

  void onLogoutTap() {}
  void logout() {
    _authSessionService.clearLoginSession();
    userController.clearUserDetails();
    NavigationHelper.navigateAndClearStack('login');
  }

  void updateLocation(String newLocation) {
    selectedLocation.value = newLocation;
  }

  void toggleExpandAll() {
    isExpanded.value = !isExpanded.value;
  }

  void profileTap() {
    NavigationHelper.navigateToScreen(ProfileScreen());
  }
}

class Performer {
  final String name;
  final int enquiries;
  final int sales;
  final String payments;

  Performer(this.name, this.enquiries, this.sales, this.payments);
}
