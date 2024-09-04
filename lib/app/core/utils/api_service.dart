import 'package:dio/dio.dart' as dio;

class ApiService {
  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: 'http://192.168.8.31:3000',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // continue
        },
        onError: (dio.DioException error, handler) {
          print('Error: ${error.message}');
          return handler.next(error); // continue
        },
      ),
    );
  }

  dio.Dio get dioInstance => _dio;
}
