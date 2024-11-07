import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';
import 'package:sacs_app/app/data/services/ready_for_delivery_service.dart';
import 'package:sacs_app/app/screens/home/widgets/search_widget.dart'; // Import your service

class SalesListController extends GetxController {
  final ReadyForDeliveryService _readyForDeliveryService =
      ReadyForDeliveryService();

  // Observable list to hold the fetched items
  var readyForDeliveryItems = <ReadyForDeliveryList>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReadyForDelivery(); // Call the API when the controller is initialized
  }

  // Method to fetch ready for delivery items
  void fetchReadyForDelivery() async {
    try {
      // Fetch data from the service
      var items = await _readyForDeliveryService.fetchReadyForDelivery();
      readyForDeliveryItems.assignAll(items); // Update the observable list
    } catch (e) {
      // Handle error, e.g., show a snackbar or log the error
      Get.snackbar('Error', 'Failed to fetch delivery items: $e');
    }
  }
}
