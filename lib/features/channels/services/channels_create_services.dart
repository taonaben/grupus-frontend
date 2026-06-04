import 'package:grupus/features/channels/api/channels_create_api.dart';
import 'package:grupus/features/channels/models/channel_model.dart';
import 'package:grupus/shared/utils/api_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class ChannelsCreateServices {
  final ChannelsCreateApi channelsCreateApi;

  ChannelsCreateServices({ChannelsCreateApi? channelsCreateApi})
    : channelsCreateApi = channelsCreateApi ?? ChannelsCreateApi();

  Future<ApiResponse> createChannel(Map<String, dynamic> payload) async {
    try {
      final response = await channelsCreateApi.createChannel(payload);
      if (!response.success) {
        DevLogs.logError('Failed to create channel: ${response.message}');
      }
      return response;
    } catch (e) {
      DevLogs.logError('Exception while creating channel: $e');
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> updateChannel(
    String channelId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await channelsCreateApi.updateChannel(
        channelId,
        payload,
      );
      if (!response.success) {
        DevLogs.logError('Failed to update channel: ${response.message}');
      }
      return response;
    } catch (e) {
      DevLogs.logError('Exception while updating channel: $e');
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> patchChannel(
    String channelId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await channelsCreateApi.patchChannel(channelId, payload);
      if (!response.success) {
        DevLogs.logError('Failed to patch channel: ${response.message}');
      }
      return response;
    } catch (e) {
      DevLogs.logError('Exception while patching channel: $e');
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> deleteChannel(String channelId) async {
    try {
      final response = await channelsCreateApi.deleteChannel(channelId);
      if (!response.success) {
        DevLogs.logError('Failed to delete channel: ${response.message}');
      }
      return response;
    } catch (e) {
      DevLogs.logError('Exception while deleting channel: $e');
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  ChannelModel? parseChannelFromResponse(ApiResponse response) {
    final data = response.data;
    if (data is ChannelModel) {
      return data;
    }
    return null;
  }
}
