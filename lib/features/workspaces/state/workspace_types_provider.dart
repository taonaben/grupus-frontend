import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/workspaces/services/workspace_types_services.dart';
import 'package:grupus/shared/utils/logs.dart';

final allWorkspaceTypesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  try {
    return WorkspaceTypesServices().fetchWorkspaceTypes().then((value) {
      if (value == null) {
        DevLogs.logError('Failed to retrieve workspace types');
        return [];
      }

      return value;
    });
  } catch (e) {
    DevLogs.logError('Error in allWorkspaceTypesProvider: $e');
    return [];
  }
});
