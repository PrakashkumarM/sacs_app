import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacs_app/app/core/utils/snackbar_helper.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class ApiService {
  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: 'https://e280-183-82-241-158.ngrok-free.app',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.uri} ${options.path}');
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // continue
        },
        onError: (dio.DioException error, handler) {
          print('Error: ${error.message}');
          _handleError(error);
          return handler.next(error); // continue
        },
      ),
    );
  }

  dio.Dio get dioInstance => _dio;

  // Method to handle errors and show toast messages
  void _handleError(dio.DioException error) {
    String message;
    print(error);
    if (error.type == dio.DioExceptionType.connectionTimeout) {
      message = "Connection timeout. Please try again.";
    } else if (error.type == dio.DioExceptionType.receiveTimeout) {
      message = "Receive timeout. Please try again.";
    } else if (error.type == dio.DioExceptionType.sendTimeout) {
      message = "Send timeout. Please try again.";
    } else if (error.type == dio.DioExceptionType.cancel) {
      message = "Request was cancelled.";
    } else if (error.response != null) {
      // Handle HTTP error responses
      switch (error.response?.statusCode) {
        case 400:
          message = "Bad request. Please check your input.";
          break;
        case 401:
          message = "Unauthorized. Please login again.";
          break;
        case 403:
          message = "Forbidden. You don't have permission.";
          break;
        case 404:
          message = "Not found. Please check the URL.";
          break;
        case 500:
          message = "Internal server error. Please try again later.";
          break;
        default:
          message = "Unexpected error occurred.";
          break;
      }
    } else {
      // For other types of errors
      message = "An unexpected error occurred.";
    }
    SnackbarHelper.showSnackbar(
      title: 'Error',
      message: message,
      position: SnackPosition.TOP,
      backgroundColor: CustomColors.error,
    );
  }
}
