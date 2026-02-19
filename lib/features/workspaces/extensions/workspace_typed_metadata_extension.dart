import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/features/workspaces/models/workspace_types/index.dart';

/// Convenient type-safe getters for workspace metadata
extension WorkspaceTypedMetadataExtension on WorkspaceModel {
  /// Get metadata cast to CohortModel if workspace type is 'cohort'
  CohortModel? get asCohort =>
      typedMetadata is CohortModel ? typedMetadata as CohortModel : null;

  /// Get metadata cast to CourseModel if workspace type is 'course'
  CourseModel? get asCourse =>
      typedMetadata is CourseModel ? typedMetadata as CourseModel : null;

  /// Get metadata cast to EventModel if workspace type is 'event'
  EventModel? get asEvent =>
      typedMetadata is EventModel ? typedMetadata as EventModel : null;

  /// Get metadata cast to HackathonModel if workspace type is 'hackathon'
  HackathonModel? get asHackathon =>
      typedMetadata is HackathonModel ? typedMetadata as HackathonModel : null;

  /// Get metadata cast to ModuleModel if workspace type is 'module'
  ModuleModel? get asModule =>
      typedMetadata is ModuleModel ? typedMetadata as ModuleModel : null;

  /// Get metadata cast to ProjectModel if workspace type is 'project'
  ProjectModel? get asProject =>
      typedMetadata is ProjectModel ? typedMetadata as ProjectModel : null;

  /// Get metadata cast to ResearchModel if workspace type is 'research'
  ResearchModel? get asResearch =>
      typedMetadata is ResearchModel ? typedMetadata as ResearchModel : null;

  /// Check if metadata has been successfully typed
  bool get hasTypedMetadata => typedMetadata != null;

  /// Get the metadata as its typed model, or fall back to generic metadata
  dynamic get metadataAsTyped => typedMetadata ?? metadata;
}
