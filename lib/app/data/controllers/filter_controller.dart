import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/advance_filter.dart';

class FilterController extends GetxController {
  RxString startDate = ''.obs; // Final value
  RxString endDate = ''.obs; // Final value
  RxString status = ''.obs; // Final value
  RxString deliveryStatus = ''.obs; // Final value
  RxString deliveryPayment = ''.obs; // Final value

  VoidCallback? filterOpenCallback;

  void updateValue(RxString key, String value) {
    key.value = value;
  }

  void showAdvancedSearchBottomSheet(
      {required String title, required dynamic mainFiltercontroller}) {
    Get.bottomSheet(
      AdvancedSearchBottomSheet(
          title: title, mainFiltercontroller: mainFiltercontroller),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
    );
  }
}
