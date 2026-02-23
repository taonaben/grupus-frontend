import 'package:dio/dio.dart';
import 'package:grupus/features/workspaces/models/workspace_create_model.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';

class WorkspaceCreateApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> createWorkspace(WorkspaceCreateModel workspace) async {
    try {
      final response = await _dio.post('/workspace/', data: workspace.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "Workspace added successfully",
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
