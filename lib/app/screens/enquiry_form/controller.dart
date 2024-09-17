import 'package:get/get.dart';

class EnquiryFormController extends GetxController {
  var currentStep = 1.obs; // Observable for the current step

  // Example dropdown values
  var categories = <String>['Mobiles', 'Tablets', 'Laptops'];
  var brands = <String>['Samsung', 'Apple', 'Google'];
  var products = <String>['Galaxy S23 Ultra', 'iPhone 14', 'Pixel 7'];

  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;
  var selectedProduct = ''.obs;

  // Method to move to the next step
  void goToNextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  // Method to submit the form
  void submitForm() {
    // Submit form logic here
  }

  // Method to add product
  void addProduct(String category, String brand, String product) {
    // Add product logic here
  }
}
