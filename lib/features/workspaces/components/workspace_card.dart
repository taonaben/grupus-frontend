import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/chat/views/chat_screen.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/features/workspaces/models/workspace_types/cohort_model.dart';
import 'package:grupus/features/workspaces/models/workspace_types/course_model.dart';
import 'package:grupus/features/workspaces/models/workspace_types/event_model.dart';
import 'package:grupus/features/workspaces/models/workspace_types/module_model.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';
import 'package:grupus/shared/utils/string_methods.dart';

class WorkspaceCard extends StatelessWidget {
  final WorkspaceModel workspace;

  const WorkspaceCard({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String accessToken = await getSP("accessToken") ?? '';
        if (accessToken.isEmpty) {
          DevLogs.logError("No access token found in shared preferences.");
          // Handle the case where the token is missing, e.g., show an error message or redirect to login
          return;
        }
        context.pushNamed(
          'chat',
          extra: ChatScreenConfig(
            roomId: workspace.id!,
            roomName: workspace.name,
            baseUrl: AppConstants.apiBaseUrl,
            token: accessToken,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: AppConstants.paddingMedium,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workspace.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz_outlined),
                  ),
                ],
              ),
              // const Gap(AppConstants.gapSmall),
              Text(
                capitalize(workspace.workspace_type_name.trim()),
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              _buildMetadataSection(workspace),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataSection(WorkspaceModel workspace) {
    return switch (workspace.workspace_type_name.toLowerCase().trim()) {
      'cohort' => _cohortWidget(
        cohortData: workspace.typedMetadata as CohortModel?,
      ),
      'course' => _courseWidget(
        courseData: workspace.typedMetadata as CourseModel?,
      ),
      'module' => _moduleWidget(
        moduleData: workspace.typedMetadata as ModuleModel?,
      ),
      'event' => _eventWidget(
        eventData: workspace.typedMetadata as EventModel?,
      ),
      _ => _genericMetadataWidget(metadata: workspace.metadata),
    };
  }

  Widget _genericMetadataWidget({required Map<String, dynamic>? metadata}) {
    if (metadata == null || metadata.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          metadata.entries.map((entry) {
            return Text('${entry.key}: ${entry.value}');
          }).toList(),
    );
  }

  Widget _cohortWidget({required CohortModel? cohortData}) {
    if (cohortData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mentor: ${cohortData.mentor}'),
        Text(
          '${formatDayDate(cohortData.start_date)} - ${formatDayDate(cohortData.end_date)}',
        ),
      ],
    );
  }

  Widget _courseWidget({required CourseModel? courseData}) {
    if (courseData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Instructor: ${courseData.coordinator}'),
        // Text('Duration: ${courseData.duration}'),
        // Text('Level: ${courseData.level}'),
      ],
    );
  }

  Widget _moduleWidget({required ModuleModel? moduleData}) {
    if (moduleData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(moduleData.module_code),
        // Text('Duration: ${moduleData.duration}'),
        // Text('Level: ${moduleData.level}'),
      ],
    );
  }

  Widget _eventWidget({required EventModel? eventData}) {
    if (eventData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location: ${eventData.location}'),
        Text(
          '${formatDayDate(eventData.start_date)} - ${formatDayDate(eventData.end_date)}',
        ),
        // Text('Duration: ${eventData.}'),
      ],
    );
  }
}
