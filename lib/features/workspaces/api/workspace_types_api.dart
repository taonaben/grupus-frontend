import 'package:dio/dio.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/api_response.dart';

class WorkspaceTypesApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> fetchWorkspaceTypes() async {
    try {
      final response = await _dio.get('/workspace/types/');
      var data = response.data;
      List<Map<String, dynamic>> itemsList =
          (data['results'] as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      final listResponse = ApiListResponse<Map<String, dynamic>>(
        items: itemsList,
        rawData: data is Map<String, dynamic> ? data : {'results': itemsList},
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Workspace types retrieved successfully",
          success: true,
          data: listResponse,
        );
      } else {
        return ApiResponse(
          success: false,
          message:
              'Failed to retrieve workspace types: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to retrieve workspace types: ${e.message}',
        data: {},
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }

  Future<ApiResponse> fetchWorkspaceType(String typeId) async {
    try {
      final response = await _dio.get('/workspace/types/$typeId/');

      if (response.statusCode == 200) {
        return ApiResponse(
          message: "Workspace type retrieved successfully",
          success: true,
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message:
              'Failed to retrieve workspace type: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: 'Failed to retrieve workspace type: ${e.message}',
        data: {},
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }
}
