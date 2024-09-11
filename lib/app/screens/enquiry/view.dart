import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/common/widgets/main_layout.dart';
import 'package:sacs_app/app/screens/enquiry/controller.dart';

final duration =
    const Duration(milliseconds: 3000); // Duration for slower animation

class EnquiryScreen extends StatelessWidget {
  final EnquiryController _controller =
      Get.put(EnquiryController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Enquiries',
      showBackButton: false,
      isFilterAvailable: true,
      isSearchAvailable: true,
      body: Text('ENquiry'),
      showFloatingActionButton: true, // Display the FAB
    );
  }
}
