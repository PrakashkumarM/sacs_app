import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/text_string.dart';

class EnquiryFormController extends GetxController {
  var currentStep = 0.obs; // Observable for the current step

  // Example dropdown values
  var categories = <String>['Mobiles', 'Tablets', 'Laptops'];
  var brands = <String>['Samsung', 'Apple', 'Google'];
  var products = <String>['Galaxy S23 Ultra', 'iPhone 14', 'Pixel 7'];
  List<String> formSteps = ['Enquiry Details', 'Customer Details'];

  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;
  var selectedProduct = ''.obs;

  // Method to move to the next step
  void goBackOrNext(bool isBack) {
    if ((currentStep.value <= formSteps.length && isBack) ||
        (currentStep.value < formSteps.length)) {
      isBack ? currentStep.value-- : currentStep.value++;
    }
  }

  // Method to submit the form
  void submitForm() {
    // Submit form logic here
    NavigationHelper.navigateAndClearStack(TextString.dashboard,
        arguments: {'tabIndex': 1});
  }

  // Method to add product
  void addProduct(String category, String brand, String product) {
    // Add product logic here
  }
}
