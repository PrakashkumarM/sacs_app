import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/text_string.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(
        TextString.topFrameLogoPath, // Replace with your logo asset
        height: 135.0,
      ),
    );
  }
}
