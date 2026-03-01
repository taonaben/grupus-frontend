import 'package:dio/dio.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';

class UsersApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me/');

      if (response.statusCode == 200) {
        return ApiResponse(
          message: "User retrieved successfully",
          success: true,
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to retrieve user: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message:
              e.response?.data['message'] ?? 'Failed to retrieve user',
          data: {},
        );
      } else {
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