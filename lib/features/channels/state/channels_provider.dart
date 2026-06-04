import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/channels/models/channel_model.dart';
import 'package:grupus/features/channels/services/channels_retrieve_services.dart';

class ChannelScope {
  final String? workspaceId;
  final String? groupId;

  const ChannelScope({this.workspaceId, this.groupId})
    : assert(
        (workspaceId != null && workspaceId != '') ||
            (groupId != null && groupId != ''),
        'Either workspaceId or groupId must be provided.',
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChannelScope &&
            other.workspaceId == workspaceId &&
            other.groupId == groupId);
  }

  @override
  int get hashCode => Object.hash(workspaceId, groupId);
}

final channelsRetrieveServiceProvider = Provider<ChannelsRetrieveServices>((
  ref,
) {
  return ChannelsRetrieveServices();
});

final channelsByScopeProvider = FutureProvider.autoDispose
    .family<List<ChannelModel>, ChannelScope>((ref, scope) async {
      final service = ref.read(channelsRetrieveServiceProvider);
      final response = await service.retrieveAllChannels(
        workspaceId: scope.workspaceId,
        groupId: scope.groupId,
      );
      return response?.items ?? const <ChannelModel>[];
    });

final defaultChannelByScopeProvider = FutureProvider.autoDispose
    .family<ChannelModel?, ChannelScope>((ref, scope) async {
      final channels = await ref.watch(channelsByScopeProvider(scope).future);
      if (channels.isEmpty) {
        return null;
      }

      final preferred = channels.where(
        (channel) => channel.name.toLowerCase().trim() == 'batch 1',
      );
      return preferred.isNotEmpty ? preferred.first : channels.first;
    });

final selectedChannelIdByScopeProvider = StateProvider.autoDispose
    .family<String?, ChannelScope>((ref, scope) {
      return null;
    });

final activeChannelByScopeProvider = Provider.autoDispose
    .family<ChannelModel?, ChannelScope>((ref, scope) {
      final channelsAsync = ref.watch(channelsByScopeProvider(scope));
      final selectedChannelId = ref.watch(
        selectedChannelIdByScopeProvider(scope),
      );

      final channels = channelsAsync.valueOrNull;
      if (channels == null || channels.isEmpty) {
        return null;
      }

      if (selectedChannelId != null) {
        for (final channel in channels) {
          if (channel.id == selectedChannelId) {
            return channel;
          }
        }
      }

      final preferred = channels.where(
        (channel) => channel.name.toLowerCase().trim() == 'batch 1',
      );
      return preferred.isNotEmpty ? preferred.first : channels.first;
    });
