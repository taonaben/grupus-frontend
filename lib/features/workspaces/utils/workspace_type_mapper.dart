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
      return null;
    }

    try {
      switch (workspaceTypeName.toLowerCase().trim()) {
        case 'cohort':
          return CohortModel.fromJson(metadata);
        case 'course':
          return CourseModel.fromJson(metadata);
        case 'event':
          return EventModel.fromJson(metadata);
        case 'hackathon':
          return HackathonModel.fromJson(metadata);
        case 'module':
          return ModuleModel.fromJson(metadata);
        case 'project':
          return ProjectModel.fromJson(metadata);
        case 'research':
          return ResearchModel.fromJson(metadata);
        default:
          DevLogs.logWarning('Unknown workspace type: $workspaceTypeName');
          return null;
      }
    } catch (e) {
      DevLogs.logWarning(
        'Failed to cast metadata for workspace type $workspaceTypeName: $e',
      );
      return null;
    }
  }
}
