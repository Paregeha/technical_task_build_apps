import 'package:dio/dio.dart';
import 'package:tech_task/core/errors/app_exception.dart';

class ErrorHandler {
  static AppException handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    if (error is AppException) {
      return error;
    }

    return const AppException('Unexpected error occurred. Please try again.');
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const AppException(
          'Connection timeout. Please check your internet and try again.',
        );

      case DioExceptionType.sendTimeout:
        return const AppException(
          'Request timeout while sending data. Please try again.',
        );

      case DioExceptionType.receiveTimeout:
        return const AppException(
          'Server response timeout. Please try again later.',
        );

      case DioExceptionType.badCertificate:
        return const AppException(
          'Secure connection error. Please try again later.',
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return const AppException('Request was cancelled.');

      case DioExceptionType.connectionError:
        return const AppException(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.unknown:
        return const AppException('Network error occurred. Please try again.');
    }
  }

  static AppException _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const AppException('Bad request.');
      case 401:
        return const AppException('Unauthorized request.');
      case 403:
        return const AppException('Access denied.');
      case 404:
        return const AppException('Requested data was not found.');
      case 500:
        return const AppException('Server error. Please try again later.');
      case 502:
        return const AppException('Bad gateway. Please try again later.');
      case 503:
        return const AppException(
          'Service unavailable. Please try again later.',
        );
      default:
        return AppException(
          'Request failed with status code: ${statusCode ?? 'unknown'}.',
        );
    }
  }
}
