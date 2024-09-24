import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/product_detail_service.dart';

class EnquiryFormController extends GetxController {
  var currentStep = 0.obs; // Observable for the current step
  final ProductDetailService _productDetailService = ProductDetailService();

  // Example dropdown values
  var categories = <String>[].obs;
  var brands = <String>[].obs;
  var products = <String>[].obs;

  List<String> formSteps = ['Enquiry Details', 'Customer Details'];

  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;
  var selectedProduct = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      final productDetails = await _productDetailService.fetchProductDetails();
      print('productDetails: ${productDetails}');
      categories.value = List<String>.from(productDetails['categories'] ?? []);
      brands.value = List<String>.from(productDetails['brands'] ?? []);
      products.value = List<String>.from(productDetails['products'] ?? []);
    } catch (e) {
      print('Error fetching data: $e'); // Debug: print the error
    } finally {}
  }

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
