import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/text_string.dart';

class BottomLogo extends StatelessWidget {
  const BottomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Image.asset(
        TextString.bottomFrameLogoPath, // Replace with your logo asset
        height: 135.0,
      ),
    );
  }
}
