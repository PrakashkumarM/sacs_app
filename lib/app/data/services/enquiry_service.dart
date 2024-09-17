import 'package:dio/dio.dart';
import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';

class EnquiryService {
  final ApiService _apiService = ApiService();

  Future<List<Enquiry>> fetchEnquiries() async {
    try {
      final response = await _apiService.dioInstance.get('/enquiries');
      List<dynamic> data = response.data;

      return data.map((json) => Enquiry.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching enquiries: $e");
      return [];
    }
  }
}
