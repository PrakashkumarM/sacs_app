import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? locationWidget;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.locationWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // Removes default back button
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(TextString.profilePath),
        ),
      ),
      title: locationWidget != null
          ? locationWidget!
          : Text(
              title,
              style: TextStyle(
                color: CustomColors.black,
                fontSize: 16,
              ),
            ),
      centerTitle: false, // Align title to the left
      actions: [
        Row(
          children: [
            Icon(Icons.logout, color: CustomColors.black),
            SizedBox(width: 8),
            TextButton(
              onPressed: () {
                // Add log out functionality here
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 16), // Padding on the right
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
