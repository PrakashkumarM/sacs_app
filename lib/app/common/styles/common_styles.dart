import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart'; // Import your colors

class CommonStyles {
  // Common method to return OutlineInputBorder
  static OutlineInputBorder outlineInputBorder({
    Color color = CustomColors.grey, // Default color is grey
    double borderRadius = 8.0, // Default border radius
    double borderWidth = 1.0, // Default border width
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: CustomColors.borderGrey,
        width: borderWidth,
      ),
    );
  }

  // You can add more common styling here if needed
}
