import 'package:flutter/material.dart';

import 'package:sacs_app/app/common/widgets/rounded_image.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onLogoutTap;
  final Function() onProfileTap;

  const DashboardAppBar({
    Key? key,
    required this.onLogoutTap,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CustomColors.white,
      surfaceTintColor: CustomColors.transparent,
      elevation: 0,
      titleSpacing: 0, // Ensure no extra space before the title content
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: onProfileTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.lightGrey, // Custom border color
                width: 4.0, // Adjust width as needed
              ),
            ),
            child: RoundedImage(
              radius: 23.0,
              backgroundImageUrl: TextString.profilePath,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onLogoutTap,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Proper padding at the end
            child: Row(
              children: [
                Icon(Icons.logout, color: CustomColors.darkGrey),
                SizedBox(width: 5),
                Text(
                  "Log Out",
                  style: TextStyle(
                      color: CustomColors.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
