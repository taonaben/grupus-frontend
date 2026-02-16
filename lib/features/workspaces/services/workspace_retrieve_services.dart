import 'package:grupus/features/workspaces/api/workspace_retrieve_api.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class WorkspaceRetrieveServices {
  var workspaceRetrieveApi = WorkspaceRetrieveApi();

  Future<ApiListResponse<WorkspaceModel>?> retrieveAllWorkspaces() async {
    try {
      var response = await workspaceRetrieveApi.retrieveAllWorkspaces();

      if (!response.success || response.data == null) {
        DevLogs.logError('Failed to retrieve workspaces: ${response.message}');
        return null;
      }

      return response.data as ApiListResponse<WorkspaceModel>;
    } catch (e) {
      DevLogs.logError('Error in WorkspaceRetrieveServices: $e');
      return null;
    }
  }
}
