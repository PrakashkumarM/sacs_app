import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class CustomTextButtonWithIcon extends StatelessWidget {
  const CustomTextButtonWithIcon({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.textColor = CustomColors.white, // Default text color
    this.borderRadius = 25.0, // Default border radius
    this.isDynamic = false, // Default isDynamic value
    this.isExpanded, // Pass RxBool from parent if isDynamic is true
  }) : super(key: key);

  final VoidCallback onTap; // Action to perform on tap
  final dynamic text; // Can be normal text or RxString
  final dynamic icon; // Can be normal IconData or Rx<IconData>
  final Color textColor; // Text color
  final double borderRadius; // Button border radius
  final bool isDynamic; // Indicates if dynamic values are used
  final RxBool? isExpanded; // Optional RxBool for dynamic states

  Widget _buildText() {
    // Check if `isDynamic` is true
    if (isDynamic && isExpanded != null) {
      return Obx(() {
        return Text(
          isExpanded!.value ? text[1] : text[0], // Use text based on isExpanded
          style: TextStyle(color: textColor),
        );
      });
    } else {
      // Normal text or static
      return Text(
        text,
        style: TextStyle(color: textColor),
      );
    }
  }

  Widget _buildIcon() {
    // Check if `isDynamic` is true
    if (isDynamic && isExpanded != null) {
      return Obx(() {
        return Icon(
          isExpanded!.value ? icon[1] : icon[0], // Use icon based on isExpanded
          color: textColor,
        );
      });
    } else {
      // Normal icon or static
      return Icon(
        icon,
        color: textColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 2, right: 6, left: 8),
        decoration: BoxDecoration(
          color: CustomColors.selectionColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildText(), // Handle text (Rx or normal)
            SizedBox(width: 3.0),
            _buildIcon(), // Handle icon (Rx or normal)
          ],
        ),
      ),
    );
  }
}
