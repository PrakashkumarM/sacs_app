import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/custom_appbar.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/home/widgets/appbar.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final Function()? onProfileTap;
  final Function()? onLogoutTap;
  final bool isDashboard;
  final bool showBackButton;
  final String title;
  final bool isSearchAvailable;
  final bool isFilterAvailable;
  final bool showFloatingActionButton;
  final bool stepperAvailable;
  final Function()? onFabTap;
  final Function()? openBuilderCallBack;
  final bool resizeToAvoidBottomInset;
  final String showBackButtonStr;

  const MainLayout(
      {Key? key,
      required this.body,
      this.onProfileTap,
      this.onLogoutTap,
      this.isDashboard = false,
      this.title = '',
      this.showBackButton = false,
      this.isSearchAvailable = false,
      this.isFilterAvailable = false,
      this.showFloatingActionButton = false,
      this.onFabTap,
      this.stepperAvailable = true,
      this.openBuilderCallBack,
      this.resizeToAvoidBottomInset = true,
      this.showBackButtonStr = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
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
              showBackButtonStr: showBackButtonStr,
            ),
      body: stepperAvailable
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: body,
            )
          : body,
      floatingActionButton: showFloatingActionButton
          ? OpenContainer(
              closedShape: const CircleBorder(),
              closedElevation: 6.0,
              transitionDuration: const Duration(milliseconds: 500),

              closedColor: CustomColors
                  .selectionColor, // Ensure this matches your FAB color
              openColor: CustomColors
                  .white, // This is the background color when it opens
              closedBuilder:
                  (BuildContext context, VoidCallback openContainer) {
                return FloatingActionButton.small(
                  elevation: 0,
                  shape: const CircleBorder(),
                  heroTag: title,
                  backgroundColor:
                      CustomColors.selectionColor, // FAB background color
                  onPressed: openContainer, // Trigger the container opening
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: CustomColors.white,
                  ),
                  tooltip: TextString.add,
                );
              },
              openBuilder: (BuildContext context, VoidCallback _) {
                return openBuilderCallBack!(); // Replace with your details page widget
              },
            )
          : null,
    );
  }
}
