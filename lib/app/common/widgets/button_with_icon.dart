import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {super.key,
      required this.onButtonTap,
      required this.text,
      required this.icon,
      this.textColor = CustomColors.black,
      this.iconColor = CustomColors.grey});

  final VoidCallback onButtonTap;
  final String text;
  final IconData icon;
  final textColor;
  final iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          SizedBox(
            width: 3,
          ),
          Text(text, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
