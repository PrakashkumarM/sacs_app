import 'package:flutter/material.dart';
import 'package:sacs_app/app/common/widgets/custom_icons.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Widget? actionButton;
  final bool isSearchAvailable;
  final bool isFilterAvailable;

  CustomAppBar({
    required this.title,
    this.showBackButton = true,
    this.actionButton,
    this.isSearchAvailable = false,
    this.isFilterAvailable = false,
  });

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
                Navigator.of(context).pop();
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
                  },
                ),
              if (isFilterAvailable)
                IconButton(
                  icon: Icon(CustomIcons.filter,
                      color: CustomColors.unSelectionColor),
                  onPressed: () {
                    print('Filter tapped');
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
