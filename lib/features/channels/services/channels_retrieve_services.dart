import 'package:grupus/features/channels/api/channels_retrieve_api.dart';
import 'package:grupus/features/channels/models/channel_model.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class ChannelsRetrieveServices {
  final ChannelsRetrieveApi channelsRetrieveApi;

  ChannelsRetrieveServices({ChannelsRetrieveApi? channelsRetrieveApi})
    : channelsRetrieveApi = channelsRetrieveApi ?? ChannelsRetrieveApi();

  Future<ApiListResponse<ChannelModel>?> retrieveAllChannels({
    String? workspaceId,
    String? groupId,
  }) async {
    try {
      final response = await channelsRetrieveApi.retrieveAllChannels(
        workspaceId: workspaceId,
        groupId: groupId,
      );

      if (!response.success || response.data == null) {
        DevLogs.logError('Failed to retrieve channels: ${response.message}');
        return null;
      }

      return response.data as ApiListResponse<ChannelModel>;
    } catch (e) {
      DevLogs.logError('Error in ChannelsRetrieveServices: $e');
      return null;
    }
  }

  Future<ChannelModel?> retrieveChannel(String channelId) async {
    try {
      final response = await channelsRetrieveApi.retrieveChannel(channelId);

      if (!response.success || response.data == null) {
        DevLogs.logError('Failed to retrieve channel: ${response.message}');
        return null;
      }

      return response.data as ChannelModel;
    } catch (e) {
      DevLogs.logError('Error retrieving channel: $e');
      return null;
    }
  }

  Future<ChannelModel?> resolveDefaultChannel({
    String? workspaceId,
    String? groupId,
    String preferredName = 'batch 1',
  }) async {
    final channelsResponse = await retrieveAllChannels(
      workspaceId: workspaceId,
      groupId: groupId,
    );

    final channels = channelsResponse?.items ?? const <ChannelModel>[];
    if (channels.isEmpty) {
      return null;
    }

    final preferred = channels.where(
      (channel) => channel.name.toLowerCase().trim() == preferredName,
    );

    return preferred.isNotEmpty ? preferred.first : channels.first;
  }
}
