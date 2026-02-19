import 'package:grupus/features/workspaces/models/workspace_types/index.dart';
import 'package:grupus/shared/utils/logs.dart';

/// Maps workspace type names to their corresponding model classes
/// and provides casting functionality for metadata
class WorkspaceTypeMapper {
  /// Cast generic metadata to its corresponding workspace type model
  ///
  /// Returns the typed model instance or null if casting fails
  static Object? castMetadata(
    String workspaceTypeName,
    Map<String, dynamic>? metadata,
  ) {
    if (metadata == null || metadata.isEmpty) {
      DevLogs.logWarning(
        'Metadata is null or empty for workspace type: $workspaceTypeName',
      );
      return null;
    }

    try {
      DevLogs.logInfo(
        'Attempting to cast metadata for type "$workspaceTypeName": $metadata',
      );

      final result = switch (workspaceTypeName.toLowerCase().trim()) {
        'cohort' => CohortModel.fromJson(metadata),
        'course' => CourseModel.fromJson(metadata),
        'event' => EventModel.fromJson(metadata),
        'hackathon' => HackathonModel.fromJson(metadata),
        'module' => ModuleModel.fromJson(metadata),
        'project' => ProjectModel.fromJson(metadata),
        'research' => ResearchModel.fromJson(metadata),
        _ => null,
      };

      if (result == null) {
        DevLogs.logWarning('Unknown workspace type: $workspaceTypeName');
      } else {
        DevLogs.logInfo('Successfully cast metadata to ${result.runtimeType}');
      }

      return result;
    } catch (e, stackTrace) {
      DevLogs.logError(
        'Failed to cast metadata for workspace type "$workspaceTypeName"\n'
        'Metadata: $metadata\n'
        'Error: $e\n'
        'StackTrace: $stackTrace',
      );
      return null;
    }
  }
}
