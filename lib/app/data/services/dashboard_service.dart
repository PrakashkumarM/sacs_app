import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/models/dashboard_model.dart';

class DashboardService {
  final ApiService _apiService = ApiService();

  Future<Dashboard?> fetchDashboardData() async {
    try {
      final response = await _apiService.dioInstance.get('/dashboard');
      Map<String, dynamic> data = response.data;
      print("Dashboarddata:$data");
      return Dashboard.fromJson(data);
    } catch (e) {
      print("Error fetching dashboard data: $e");
      return null;
    }
  }
}
