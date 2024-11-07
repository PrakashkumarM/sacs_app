import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';

class ReadyForDeliveryService {
  final ApiService _apiService = ApiService();

  // Fetch ready for delivery items from the API
  Future<List<ReadyForDeliveryList>> fetchReadyForDelivery() async {
    try {
      // Fetch data from the API endpoint
      final response = await _apiService.dioInstance.get('/ready_for_delivery');

      // Log the response data to verify it's the correct structure
      print('ReadyForDelivery data: ${response.data}');

      // Extract the "ready_for_delivery" array from the response data
      List<dynamic> data = response.data;

      // Map the JSON data to a list of ReadyForDelivery objects
      return data.map((json) => ReadyForDeliveryList.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching ready for delivery items: $e");
      return [];
    }
  }
}
