import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Image.asset(
          TextString.sacsLogoPath, // SACS logo
          height: 100, // Adjust height as needed
        ),
      ),
    );
  }
}
