import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/data/controllers/filter_controller.dart';
import 'package:sacs_app/app/data/controllers/search_controller.dart';
import 'package:sacs_app/app/screens/dashboard/controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final String showBackButtonStr; // Renamed for clarity
  final Widget? actionButton;
  final bool isSearchAvailable;
  final bool isFilterAvailable;
  final dynamic mainFiltercontroller;

  CustomAppBar(
      {required this.title,
      this.showBackButton = true,
      this.showBackButtonStr = '',
      this.actionButton,
      this.isSearchAvailable = false,
      this.isFilterAvailable = false,
      this.mainFiltercontroller});

  final SearchTextController controller = SearchTextController();
  final FilterController filterController = FilterController();
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.white,
      elevation: 6,
      shadowColor: CustomColors.grey.withOpacity(0.1),
      surfaceTintColor: CustomColors.transparent,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: CustomColors.black),
              onPressed: () {
                if (showBackButtonStr.isEmpty) {
                  Navigator.of(context).pop();
                } else if (showBackButtonStr == 'dashboard') {
                  dashboardController.changeTabIndex(0);
                } else {
                  NavigationHelper.navigateAndClearStack(showBackButtonStr);
                }
              },
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: CustomColors.unSelectionColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      actions: [
        if (isSearchAvailable || isFilterAvailable)
          Row(
            children: [
              if (isSearchAvailable)
                IconButton(
                  icon:
                      Icon(Icons.search, color: CustomColors.unSelectionColor),
                  onPressed: controller.showSearchBar,
                ),
              if (isFilterAvailable)
                IconButton(
                  icon: Icon(CustomIcons.filter,
                      color: CustomColors.unSelectionColor, size: 15),
                  onPressed: () {
                    filterController.showAdvancedSearchBottomSheet(
                        title: title,
                        mainFiltercontroller: mainFiltercontroller);
                  },
                ),
            ],
          ),
        if (actionButton != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: actionButton,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
