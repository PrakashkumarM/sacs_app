import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/screens/enquiry/controller.dart';

final duration =
    const Duration(milliseconds: 3000); // Duration for slower animation

class SalesScreen extends StatelessWidget {
  final EnquiryController _controller =
      Get.put(EnquiryController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: TextString.salesListIconText,
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      body: Stack(
        children: [
          // Your main content
          Text('Sales screen'),
          // FAB positioned at the bottom-right corner
        ],
      ),
      showFloatingActionButton: true, // Display the FAB
    );
  }
}
