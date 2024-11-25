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

  static InputDecoration commonInputDecoration({
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: CustomColors.borderGrey),
      ),
    );
  }

  // You can add more common styling here if needed
}
