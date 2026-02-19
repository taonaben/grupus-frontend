import 'package:grupus/features/workspaces/api/workspace_types_api.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class WorkspaceTypesServices {
  var workspaceTypesApi = WorkspaceTypesApi();

  Future<List<Map<String, dynamic>>?> fetchWorkspaceTypes() async {
    try {
      var response = await workspaceTypesApi.fetchWorkspaceTypes();

      if (!response.success || response.data == null) {
        DevLogs.logError(
          'Failed to fetch workspace types: ${response.message}',
        );
        return null;
      }

      var data = response.data as ApiListResponse<Map<String, dynamic>>;
      return data.items;
    } catch (e) {
      DevLogs.logError('Error in WorkspaceTypesServices: $e');
      return null;
    }
  }
}
