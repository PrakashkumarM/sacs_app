import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sacs_app/app/core/utils/api_service.dart';
import 'package:sacs_app/app/data/models/enquiry_model.dart';
import 'package:sacs_app/app/data/services/enquiry_service.dart';
import 'api_test.mocks.dart'; // Import the generated mocks

// Use @GenerateMocks to generate mock classes for Dio and ApiService
@GenerateMocks([Dio, ApiService])
void main() {
  late MockApiService mockApiService;
  late EnquiryService enquiryService;

  setUp(() {
    // Create mock instances
    mockApiService = MockApiService();
    enquiryService = EnquiryService(apiService: mockApiService);
  });

  test('fetchEnquiries returns list of Enquiry on success', () async {
    // Create a mock Dio instance
    final mockDio = MockDio();

    // Stub the `dioInstance` method to return the mock Dio
    when(mockApiService.dioInstance).thenReturn(mockDio);

    // Stub the `get` method to return a mock response
    when(mockDio.get('/enquiries')).thenAnswer(
      (_) async => Response(
        data: [
          {
            "customer_name": "Abdul",
            "mobile": "9459459458",
            "enquiry_date": "5/07/2022",
            "product_name": "Samsung Home theatre",
            "enquiry_status": "enquired",
            "enquired_by": "John snow",
            "branch": "Town Hall Road - Madurai"
          } // Mock data
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/enquiries'),
      ),
    );

    // Call the fetchEnquiries method and verify the result
    final result = await enquiryService.fetchEnquiries();
    print('result:$result');
    expect(result, isA<List<Enquiry>>());
  });

  // test('fetchEnquiries returns empty list on error', () async {
  //   final mockDio = MockDio();
  //   when(mockApiService.dioInstance).thenReturn(mockDio);

  //   // Stub the `get` method to throw an error
  //   when(mockDio.get('/enquiries')).thenThrow(DioException(
  //     type: DioExceptionType.connectionTimeout,
  //     requestOptions: RequestOptions(path: '/enquiries'),
  //   ));

  //   final result = await enquiryService.fetchEnquiries();
  //   print('result"$result');
  //   expect(result, isEmpty);
  // });
}
