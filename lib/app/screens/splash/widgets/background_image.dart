import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      TextString.splashBackgroundPath, // Background image path
      width: double.infinity, // Full width
      fit: BoxFit.cover, // Cover the entire area
    );
  }
}
