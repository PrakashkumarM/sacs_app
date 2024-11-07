import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/common/widgets/advance_filter.dart';

class FilterController extends GetxController {
  var startDate = ''.obs;
  var endDate = ''.obs;
  var deliveryStatus = ''.obs;
  var deliveryPayment = ''.obs;

  void updateStartDate(String date) {
    startDate.value = date;
  }

  void updateEndDate(String date) {
    endDate.value = date;
  }

  void updateDeliveryStatus(String status) {
    deliveryStatus.value = status;
  }

  void updateDeliveryPayment(String payment) {
    deliveryPayment.value = payment;
  }

  void resetFields() {
    startDate.value = '';
    endDate.value = '';
    deliveryStatus.value = '';
    deliveryPayment.value = '';
  }

  void showAdvancedSearchBottomSheet() {
    Get.bottomSheet(
      AdvancedSearchBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
    );
  }
}
