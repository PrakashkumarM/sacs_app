import 'package:flutter/material.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class RoundedImage extends StatelessWidget {
  final String backgroundImageUrl;
  final double radius;
  final Color backgroundColor;

  RoundedImage({
    super.key,
    required this.backgroundImageUrl,
    this.radius = 15.0,
    this.backgroundColor = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(backgroundImageUrl),
      radius: radius, // Adjust radius to match the profile image size
      backgroundColor:
          backgroundColor, // Transparent background to avoid extra space
    );
  }
}
