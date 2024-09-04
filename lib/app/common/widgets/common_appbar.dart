import 'package:flutter/material.dart';

class CommonAppHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? profileImage;
  final Widget? locationWidget;

  CommonAppHeader({
    required this.title,
    this.leading,
    this.actions,
    this.profileImage,
    this.locationWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (locationWidget != null) locationWidget!,
          if (profileImage != null) Spacer(),
          Text(title),
        ],
      ),
      leading: leading,
      actions: actions,
    );
  }
}
