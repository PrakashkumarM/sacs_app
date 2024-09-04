import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? locationWidget; // For the location selection app bar

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
      backgroundColor: Colors.white,
      elevation: 0,
      leading: leading ??
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
      title: locationWidget != null
          ? Row(
              children: [
                locationWidget!,
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ],
            )
          : Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
