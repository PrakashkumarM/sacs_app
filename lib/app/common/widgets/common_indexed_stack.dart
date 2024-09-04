import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonIndexedStack extends StatelessWidget {
  final RxInt tabIndex; // Expect RxInt
  final List<Widget> tabWidgets;

  const CommonIndexedStack({
    Key? key,
    required this.tabWidgets,
    required this.tabIndex, // RxInt passed here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: tabIndex.value, // Access the value of RxInt
        children: tabWidgets,
      ),
    );
  }
}
