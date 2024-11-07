import 'dart:math';

import 'package:flutter/material.dart';

class ElectricCircleLoader extends StatefulWidget {
  @override
  _ElectricCircleLoaderState createState() => _ElectricCircleLoaderState();
}

class _ElectricCircleLoaderState extends State<ElectricCircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Loop the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Circle
            CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation(Colors.red), // Electric Red
              backgroundColor: Colors.grey.shade300,
            ),
            // Sparks Animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 6.28319, // 2 * pi
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(8, (index) {
                      double angle = index * 0.7854; // 45 degrees
                      double x = 40 * cos(angle);
                      double y = 40 * sin(angle);
                      return Positioned(
                        left: x,
                        top: y,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.red, // Electric Red Spark
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            // Inner Loader Indicator
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
