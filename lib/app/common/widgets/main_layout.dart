import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/custom_appbar.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/screens/home/widgets/appbar.dart';

class MainLayout extends StatelessWidget {
  final Widget body; // The body content of each page
  final Function()? onProfileTap; // Nullable function, coming from parent
  final Function()? onLogoutTap; // Nullable function, coming from parent
  final bool isDashboard;
  final bool showBackButton;
  final String title;
  final bool isSearchAvailable;
  final bool isFilterAvailable;
  final bool showFloatingActionButton; // Bool to control FAB visibility

  const MainLayout({
    Key? key,
    required this.body,
    this.onProfileTap,
    this.onLogoutTap,
    this.isDashboard = false,
    this.title = '',
    this.showBackButton = false,
    this.isSearchAvailable = false,
    this.isFilterAvailable = false,
    this.showFloatingActionButton = false, // Default is no FAB
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: isDashboard
          ? DashboardAppBar(
              onProfileTap: onProfileTap ?? () {},
              onLogoutTap: onLogoutTap ?? () {},
            )
          : CustomAppBar(
              title: title,
              showBackButton: showBackButton,
              isSearchAvailable: isSearchAvailable,
              isFilterAvailable: isFilterAvailable,
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: body, // The different content for each page
      ),
      floatingActionButton: showFloatingActionButton
          ? FloatingActionButton(
              onPressed: () {
                // Default action for FAB, can be replaced or left empty
              },
              child: Icon(Icons.add), // Default plus icon
              tooltip: 'Add',
            )
          : null, // No FAB if showFloatingActionButton is false
    );
  }
}