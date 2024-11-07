import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/bottom_sheet.dart';

class CustomerEnquiriesController extends GetxController {
  // Observables for managing state
  var isEnquirySelected = true.obs;

  // Method to toggle between Enquiry and Sale
  void toggleEnquirySale(bool isEnquiry) {
    isEnquirySelected.value = isEnquiry;
  }

  void showBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomBottomSheet(
          title: title,
          content: Text(
            'Here is the content for $title.',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
