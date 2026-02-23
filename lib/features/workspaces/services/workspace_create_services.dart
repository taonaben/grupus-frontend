import 'package:grupus/features/workspaces/api/workspace_create_api.dart';
import 'package:grupus/features/workspaces/models/workspace_create_model.dart';
import 'package:grupus/shared/utils/api_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class WorkspaceCreateServices {
  Future<ApiResponse> createWorkspace(WorkspaceCreateModel workspace) async {
    try {
      // Call the API to create the workspace
      final response = await WorkspaceCreateApi().createWorkspace(workspace);
      if (!response.success) {
        DevLogs.logError("Failed to create workspace: ${response.message}");
      }
      return response;
    } catch (e) {
      DevLogs.logError("Exception occurred while creating workspace: $e");
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
