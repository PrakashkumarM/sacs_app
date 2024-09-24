import 'dart:io'; // Import this to use File
import 'package:flutter/material.dart';

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
      backgroundImage: backgroundImageUrl.startsWith('/data/user/')
          ? FileImage(File(backgroundImageUrl)) // Use FileImage for file paths
          : AssetImage('assets/images/profile.jpeg')
              as ImageProvider, // Use a default image
      radius: radius,
      backgroundColor: backgroundColor,
    );
  }
}
