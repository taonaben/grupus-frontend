import 'package:dio/dio.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/api_response.dart';

class WorkspaceRetrieveApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> retrieveWorkspace(String workspaceId) async {
    try {
      final response = await _dio.get('/workspace/$workspaceId/');

      if (response.statusCode == 200) {
        var data = response.data;

        WorkspaceModel workspace =
            (data is List)
                ? WorkspaceModel.fromJson(data.first)
                : WorkspaceModel.fromJson(data);

        return ApiResponse(
          message: "Workspace retrieved successfully",
          success: true,
          data: workspace,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to retrieve workspace: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message:
              e.response?.data['message'] ?? 'Failed to retrieve workspace',
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

  Future<ApiResponse> retrieveAllWorkspaces() async {
    try {
      final response = await _dio.get('/workspace/');

      if (response.statusCode == 200) {
        var data = response.data;

        // Handle both paginated (with 'results' key) and direct list responses
        List<dynamic> itemsList =
            (data['results'] is List)
                ? data['results']
                : (data is List)
                ? data
                : [];

        List<WorkspaceModel> workspaces =
            itemsList
                .map(
                  (item) =>
                      WorkspaceModel.fromJson(item as Map<String, dynamic>),
                )
                .toList();

        final listResponse = ApiListResponse<WorkspaceModel>(
          items: workspaces,
          rawData: data is Map<String, dynamic> ? data : {},
        );

        return ApiResponse(
          message: "Workspaces retrieved successfully",
          success: true,
          data: listResponse,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to retrieve workspaces: ${response.statusMessage}',
          data: {},
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message:
              e.response?.data['message'] ?? 'Failed to retrieve workspaces',
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
