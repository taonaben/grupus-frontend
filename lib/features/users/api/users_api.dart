import 'package:dio/dio.dart';
import 'package:grupus/features/users/models/user_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';

class UsersApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me/');

      if (response.statusCode == 200) {
        var data = response.data;

        // Handle null response data
        if (data == null) {
          return ApiResponse(
            success: false,
            message: 'Server returned empty user data',
            data: null,
          );
        }

        // Safely parse the response
        User user;
        try {
          if (data is Map) {
            // Convert dynamic map to Map<String, dynamic>
            Map<String, dynamic> typedData = Map<String, dynamic>.from(data);
            user = User.fromJson(_ensureValidUserData(typedData));
          } else if (data is List && data.isNotEmpty) {
            // Convert dynamic map from list to Map<String, dynamic>
            Map<String, dynamic> typedData = Map<String, dynamic>.from(
              data.first as Map,
            );
            user = User.fromJson(_ensureValidUserData(typedData));
          } else {
            return ApiResponse(
              success: false,
              message: 'Invalid user data format from server',
              data: null,
            );
          }
        } catch (e) {
          return ApiResponse(
            success: false,
            message: 'Failed to parse user data from server: $e',
            data: null,
          );
        }

        return ApiResponse(
          message: "User retrieved successfully",
          success: true,
          data: user,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to retrieve user: ${response.statusMessage}',
          data: null,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Failed to retrieve user',
          data: null,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Network error: ${e.message}',
          data: null,
        );
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Ensures the user data from server is valid and has required nested objects
  /// Safely converts dynamic maps to Map<String, dynamic>
  /// Returns a safe Map with null fields converted to empty objects
  Map<String, dynamic> _ensureValidUserData(Map<String, dynamic> data) {
    return {
      'id': data['id'],
      'username': data['username'] ?? 'Unknown',
      'email': data['email'] ?? '',
      'is_email_verified': data['is_email_verified'] ?? false,
      'profile': _convertToMap(data['profile']),
      'stats': _convertToMap(data['stats']),
      'subscription': _convertToMap(data['subscription']),
    };
  }

  /// Safely converts any value to a Map<String, dynamic>
  /// Returns empty map if value is not a map or is null
  Map<String, dynamic> _convertToMap(dynamic value) {
    if (value == null) return {};
    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (e) {
        return {};
      }
    }
    return {};
  }
}
