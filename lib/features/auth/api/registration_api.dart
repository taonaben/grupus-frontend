import 'package:dio/dio.dart';
import 'package:grupus/features/auth/models/user_create_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class RegistrationApi {
  final Dio _dio = ApiClient().dio;

  //!! REQUEST OTP API CALL
  Future<ApiResponse> requestOtp(String email) async {
    try {
      final response = await _dio.post(
        '/auth/request-otp/',
        data: {'email': email},
      );

      DevLogs.logInfo(
        "Request OTP status code ${response.statusCode}: ${response.statusMessage}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          message: response.data['message'] ?? "OTP sent successfully",
          success: true,
          data: response.data,
        );
      } else {
        DevLogs.logError(
          "Request OTP failed with status code ${response.statusCode}: ${response.statusMessage}",
        );

        return ApiResponse(
          success: false,
          message: response.data['message'] ?? 'Failed to send OTP',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['detail'] ?? 'Failed to send OTP',
          data: {},
        );
      } else {
        DevLogs.logError("Network error: ${e.message}");
        return ApiResponse(
          success: false,
          message: 'Network error: ${e.message}',
          data: {},
        );
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //!! VERIFY OTP API CALL
  Future<ApiResponse> verifyOtp(String email, int otp) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp/',
        data: {'email': email, 'token': otp},
      );

      DevLogs.logInfo(
        "Verify OTP status code ${response.statusCode}: ${response.statusMessage}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          message: response.data['detail'] ?? "OTP verified successfully",
          success: true,
          data: response.data,
        );
      } else {
        DevLogs.logError(
          "Verify OTP failed with status code ${response.statusCode}: ${response.statusMessage}",
        );

        return ApiResponse(
          success: false,
          message: response.data['detail'] ?? 'Invalid OTP',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['detail'] ?? 'Invalid OTP',
          data: {},
        );
      } else {
        DevLogs.logError("Network error: ${e.message}");
        return ApiResponse(
          success: false,
          message: 'Network error: ${e.message}',
          data: {},
        );
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //!! REGISTER API CALL
  Future<ApiResponse> register(UserCreateModel data) async {
    try {
      final response = await _dio.post('/auth/users/', data: data.toJson());

      DevLogs.logInfo(
        "Register status code ${response.statusCode}: ${response.statusMessage}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          message: response.data['message'] ?? "Registration successful",
          success: true,
          data: response.data,
        );
      } else {
        DevLogs.logError(
          "Register failed with status code ${response.statusCode}: ${response.statusMessage}",
        );

        return ApiResponse(
          success: false,
          message: response.data['message'] ?? 'Registration failed',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Registration failed',
          data: {},
        );
      } else {
        DevLogs.logError("Network error: ${e.message}");
        return ApiResponse(
          success: false,
          message: 'Network error: ${e.message}',
          data: {},
        );
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
