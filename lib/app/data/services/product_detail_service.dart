import 'package:sacs_app/app/core/utils/api_service.dart';

class ProductDetailService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchProductDetails() async {
    try {
      // Making the API request
      final response = await _apiService.dioInstance.get('/product_details');
      print(
          'Full API response: ${response.data}'); // Debug: check full API response

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Check if response.data is not null and is a Map
        if (response.data != null && response.data is Map<String, dynamic>) {
          return response.data; // Return the entire response as a Map
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception(
            'Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e'); // Debug: print the error
      throw Exception('Error occurred: $e');
    }
  }
}
