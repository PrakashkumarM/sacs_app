import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/navigation_helper.dart';
import 'package:sacs_app/app/core/values/text_string.dart';
import 'package:sacs_app/app/data/services/product_detail_service.dart';
import 'package:sacs_app/app/screens/enquiry_form/customer_details_form_controller.dart';

class EnquiryFormController extends GetxController {
  var currentStep = 0.obs; // Observable for the current step
  final ProductDetailService _productDetailService = ProductDetailService();
  final controller = Get.put(CustomerDetailsFormController());

  // Dropdown values as strings
  var categories = <String>[].obs;
  var brands = <String>[].obs;
  var products = <String>[].obs;
  var locations = <String>[].obs;

  List<String> formSteps = ['Enquiry Details', 'Customer Details'];

  var selectedCategory = ''.obs;
  var selectedBrand = ''.obs;
  var selectedProduct = ''.obs;
  var selectedLocation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails(); // Fetch details on initialization
  }

  // Method to fetch product details from API
  Future<void> fetchProductDetails() async {
    try {
      final productDetailsResponse =
          await _productDetailService.fetchProductDetails();

      // Directly use the keys in the response
      if (productDetailsResponse == null) {
        throw Exception("Error: Response is null");
      }

      // Update the observable lists directly with string values
      categories.value = List<String>.from(
          productDetailsResponse['categories'].map((item) => item['value']));

      brands.value = List<String>.from(
          productDetailsResponse['brands'].map((item) => item['value']));

      products.value = List<String>.from(
          productDetailsResponse['products'].map((item) => item['value']));

      locations.value = List<String>.from(
          productDetailsResponse['locations'].map((item) => item['value']));
    } catch (e) {
      print('Error fetching data: $e');
    }
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
