import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/features/workspaces/services/workspace_retrieve_services.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/logs.dart';

final allWorkspacesProvider = FutureProvider<List<WorkspaceModel>>((ref) async {
  try {
    return WorkspaceRetrieveServices().retrieveAllWorkspaces().then((value) {
      if (value == null) {
        DevLogs.logError('Failed to retrieve workspaces');
        return [];
      }
      return value.items;
    });
  } catch (e) {
    DevLogs.logError('Error in allWorkspacesProvider: $e');
    return [];
  }
});
