import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grupus/features/workspaces/models/workspace_model.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class WorkspaceCard extends StatelessWidget {
  final WorkspaceModel workspace;

  const WorkspaceCard({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
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
                    style: Theme.of(context).textTheme.titleMedium,
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
              workspace.workspace_type_name,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            _buildMetadataSection(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataSection({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(AppConstants.gapMedium),
        Text(
          'Type: ${workspace.workspace_type_name}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (workspace.description != null) ...[
          const Gap(AppConstants.gapSmall),
          Text(
            workspace.description!,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
