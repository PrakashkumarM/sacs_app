import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class AppliancesLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      TextString.productLogoPath, // Appliances image
      width: double.infinity, // Full width
      fit: BoxFit.cover, // Ensure image covers full width
    );
  }
}
