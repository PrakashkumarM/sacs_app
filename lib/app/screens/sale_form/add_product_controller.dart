import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  // Observable lists for dropdown items
  final categories = ['Category 1', 'Category 2', 'Category 3'].obs;
  final brands =
      ['Brand 1', 'Brand 2', 'Brand 3', 'Brand 4', 'Brand 5', 'Brand 6'].obs;
  final products = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    'Product 6'
  ].obs;
  final deliveryStatuses = [
    'DeliveryStatus 1',
    'DeliveryStatus 2',
    'DeliveryStatus 3',
    'DeliveryStatus 4',
    'DeliveryStatus 5',
    'DeliveryStatus 6'
  ].obs;
  final deliveryTypes = [
    'DeliveryType 1',
    'DeliveryType 2',
    'DeliveryType 3',
    'DeliveryType 4',
    'DeliveryType 5'
  ].obs;
  final deliveryPayments =
      ['Payment 1', 'Payment 2', 'Payment 3', 'Payment 4'].obs;

  // Selected values
  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;
  var selectedProduct = ''.obs;
  var selectedDeliveryStatus = ''.obs;
  var selectedDeliveryType = ''.obs;
  var selectedDeliveryPayment = ''.obs;
  var imagePath = ''.obs;

  // Controllers for text input
  final TextEditingController productAmountController = TextEditingController();
  final TextEditingController deliveryChargeController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();

  // Other observable flags
  var isAddonProduct = false.obs;
  var useCustomerAddress = false.obs;

  // Update the image path
  void updateImage(String imgPath) {
    imagePath.value = imgPath;
  }

  // Dispose controllers properly
  @override
  void onClose() {
    productAmountController.dispose();
    deliveryChargeController.dispose();
    addressController.dispose();
    serialNumberController.dispose();
    super.onClose();
  }
}
