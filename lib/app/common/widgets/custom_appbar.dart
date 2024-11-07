import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/data/controllers/filter_controller.dart';
import 'package:sacs_app/app/data/controllers/search_controller.dart';
import 'package:sacs_app/app/screens/dashboard/controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SearchTextController controller = SearchTextController();
  final FilterController filterController = FilterController();
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  final String title;
  final bool showBackButton;
  final String showBackButtonStr;
  final Widget? actionButton;
  final bool isSearchAvailable;
  final bool isFilterAvailable;

  CustomAppBar(
      {required this.title,
      this.showBackButton = true,
      this.actionButton,
      this.isSearchAvailable = false,
      this.isFilterAvailable = false,
      this.showBackButtonStr = ''});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.white,
      elevation: 6, // Increase elevation to create a shadow effect
      shadowColor: CustomColors.grey.withOpacity(0.1), // Control shadow color
      surfaceTintColor: CustomColors.transparent,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: CustomColors.black),
              onPressed: () {
                showBackButtonStr == ''
                    ? Navigator.of(context).pop()
                    : showBackButtonStr == 'dashboard'
                        ? dashboardController.changeTabIndex(0)
                        : NavigationHelper.navigateAndClearStack(
                            showBackButtonStr);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSearchAvailable)
                IconButton(
                  icon:
                      Icon(Icons.search, color: CustomColors.unSelectionColor),
                  onPressed: () {
                    print('Search tapped');
                    controller.showSearchBar();
                  },
                ),
              if (isFilterAvailable)
                IconButton(
                  icon: Icon(
                    CustomIcons.filter,
                    color: CustomColors.unSelectionColor,
                    size: 15,
                  ),
                  onPressed: () {
                    print('Filter tapped');
                    filterController.showAdvancedSearchBottomSheet();
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
