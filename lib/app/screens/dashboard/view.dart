import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/common_indexed_stack.dart';
import 'package:sacs_app/app/core/utils/screen_utils.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/data/controllers/user_controller.dart';
import 'package:sacs_app/app/data/models/bottom_navbar_items.dart';
import 'package:sacs_app/app/screens/dashboard/controller.dart';
import 'package:sacs_app/app/screens/dashboard/widgets/bottom_navbar.dart';
import 'package:sacs_app/app/screens/enquiry/view.dart';
import 'package:sacs_app/app/screens/home/view.dart';
import 'package:sacs_app/app/screens/sales/view.dart';
import 'package:sacs_app/app/screens/sales_list/view.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color for both Android and iOS
    ScreenUtils.setStatusBarColor(
      color: CustomColors.transparent,
      iconBrightness: Brightness.dark,
    );
    final DashboardController controller = Get.find<DashboardController>();
    final UserController userController = Get.find<UserController>();

    print('TABINDEX:${controller.tabIndex.value}');

    final List<Widget> tabWidgets = userController.isSalesRole.value
        ? [HomeScreen(), EnquiryScreen(), SalesScreen()]
        : [HomeScreen(), SalesListScreen()];

    return Scaffold(
      backgroundColor: CustomColors.white, // Set the background color here
      body: Stack(
        children: [
          SizedBox(
            height: 10,
          ),
          CommonIndexedStack(
            tabWidgets: tabWidgets,
            tabIndex: controller.tabIndex,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      bottomNavigationBar: Obx(() {
        return CustomBottomNavBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          items: userController.isSalesRole.value
              ? bottomNavBarSalesData
              : bottomNavBarWareHouseData,
        );
      }),
    );
  }
}
