import 'package:flutter/material.dart';

class ScreenSizeGetter extends StatelessWidget {
  const ScreenSizeGetter({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        // Can pass these sizes down to the child by Bloc pattern or other ways
        return child;
      },
    );
  }
}
