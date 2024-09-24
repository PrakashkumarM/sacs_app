import 'package:sacs_app/app/core/utils/api_service.dart';

class ProductDetailService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchProductDetails() async {
    try {
      final response = await _apiService.dioInstance.get('/product_details');
      print('API response: ${response.data}'); // Debug: check API response
      print(
          'Status response: ${response.statusCode}'); // Debug: check status code

      if (response.statusCode == 200) {
        // Check if response.data is not null and is a Map
        if (response.data != null && response.data is Map<String, dynamic>) {
          print(response.data);
          return response.data as Map<String, dynamic>;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      print('Error occurred: $e'); // Debug: print the error
      throw Exception('Error occurred: $e');
    }
  }
}
