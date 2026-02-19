import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
// baseUrl is provided by `ApiClient` now; removed redundant AppConstants import

class LoginApi {
  final Dio _dio = ApiClient().dio;

  //!! LOGIN API CALL
  Future<ApiResponse> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/users/login/',
        data: {'username': username, 'password': password},
      );

      String? oldAccessToken = await getSP("accessToken");
      String? oldRefreshToken = await getSP("refreshToken");

      if (oldAccessToken.isNotEmpty || oldRefreshToken.isNotEmpty) {
        DevLogs.logInfo(
          "Existing tokens found, clearing them before saving new ones",
        );
        await removeSP("accessToken");
        await removeSP("refreshToken");
      }

      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Login Successful",
          success: true,
          data: response.data,
        );
      } else {
        DevLogs.logError(
          "Login failed with status code ${response.statusCode}: ${response.statusMessage}",
        );

        return ApiResponse(
          success: false,
          message: 'Login failed: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Login failed',
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

  //!! VERIFY TOKEN API CALL
  Future<ApiResponse> verifyToken() async {
    final String token = await getSP("accessToken");

    if (token.isEmpty) {
      return ApiResponse(success: false, message: 'No token found', data: {});
    }

    try {
      final response = await _dio.post(
        '/auth/jwt/verify/',
        data: {'token': token},
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Token Verified",
          success: true,
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Token verification failed: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Token verification failed',
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
      DevLogs.logError("An unexpected error occurred: $e");
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }

  Future<ApiResponse> refreshToken() async {
    final String refreshToken = await getSP("refreshToken");

    if (refreshToken.isEmpty) {
      return ApiResponse(
        success: false,
        message: 'No refresh token found',
        data: {},
      );
    }

    try {
      final response = await _dio.post(
        '/auth/jwt/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Token Refreshed",
          success: true,
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Token refresh failed: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Token refresh failed',
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
      DevLogs.logError("An unexpected error occurred: $e");
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }

  Future<ApiResponse> logout() async {
    try {
      final refreshToken = await getSP("refreshToken");

      if (refreshToken.isEmpty) {
        return ApiResponse(
          success: false,
          message: 'No refresh token found',
          data: {},
        );
      }

      final response = await _dio.post(
        '/auth/logout/',
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Logout Successful",
          success: true,
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Logout failed: ${response.statusMessage}',
          data: response.data,
        );
      }
    } catch (e) {
      DevLogs.logError("Logout failed: $e");
      return ApiResponse(
        success: false,
        message: 'Logout failed: $e',
        data: {},
      );
    }
  }
}
