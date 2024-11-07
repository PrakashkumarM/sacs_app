import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/alert_dialog.dart';
import 'package:sacs_app/app/common/widgets/bottom_sheet.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/services/auth_session_service.dart';
import 'package:sacs_app/app/data/services/dashboard_service.dart';
import 'package:sacs_app/app/screens/profile/view.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';

class HomeController extends GetxController {
  final AuthSessionService _authSessionService = AuthSessionService();
  final UserController userController = Get.find<UserController>();
  final DashboardService _dashboardService =
      DashboardService(); // Dashboard service instance

  RxBool isExpanded = false.obs;
  RxBool isLoading = true.obs; // To handle loading state

  // Fields to store dashboard data
  RxList topPerformers = [].obs;
  RxList teamAchievements = [].obs;
  RxList followUpReminderList = [].obs;
  RxList customerFeedback = [].obs;
  RxList<ReadyForDelivery> salesList = <ReadyForDelivery>[].obs;

  Rx<DashboardWidgets> dashboardWidgets = DashboardWidgets(
    target: 0,
    achievement: 0,
    followUpReminder: 0,
    enquiries: 0,
    delivered: 0,
    readyForDelivery: 0,
  ).obs;

  // On initialization, fetch dashboard data
  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  // Fetch the dashboard data
  void fetchDashboardData() async {
    isLoading.value = true;
    try {
      Dashboard? dashboard = await _dashboardService.fetchDashboardData();
      if (dashboard != null) {
        // Map the fetched data to the respective fields
        topPerformers.value = dashboard.topPerformers;
        teamAchievements.value = dashboard.teamAchievements;
        followUpReminderList.value = dashboard.followUpReminders;
        customerFeedback.value = dashboard.customerFeedbacks;
        salesList.value = dashboard.readyForDelivery;

        // Set other fields
        dashboardWidgets.value = dashboard.widgets;
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Logout functionality
  void onLogoutTap() {}
  void logout() {
    _authSessionService.clearLoginSession();
    userController.clearUserDetails();
    NavigationHelper.navigateAndClearStack('login');
  }

  void showCustomerFeedback(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: TextString.customerFeedback,
        message: [
          TextSpan(
            text: TextString.cutomerFeedbackAlertContent,
            style: TextStyle(color: CustomColors.darkGrey),
          ),
        ],
        confirmText: TextString.submit,
        // cancelText: TextString.cancel,
        onConfirm: (feedback) => Navigator.of(context).pop(),
        onCancel: () => Navigator.of(context).pop(),
        hintText: 'Enter your feedback here', // Hint text
        labelText: 'Feedback', // Label text
        showField: true, // Show the TextFormField
      ),
    );
  }

  // Toggle expand/collapse state
  void toggleExpandAll() {
    isExpanded.value = !isExpanded.value;
  }

  // Navigate to profile screen
  void profileTap() {
    NavigationHelper.navigateToScreen(ProfileScreen());
  }

  void showBottomSheet(BuildContext context, String title, body) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomBottomSheet(title: title, content: body);
      },
    );
  }
}
