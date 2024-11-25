import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';

class EnquiryService {
  final ApiService _apiService;

  EnquiryService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<Enquiry>> fetchEnquiries({
    String? startDate,
    String? endDate,
    String? status,
  }) async {
    try {
      final response = await _apiService.dioInstance.get(
        '/enquiries',
        queryParameters: {
          if (startDate != null && startDate.isNotEmpty)
            'start_date': startDate,
          if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );
      List<dynamic> data = response.data;

      return data.map((json) => Enquiry.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching enquiries: $e");
      return [];
    }
  }
}
