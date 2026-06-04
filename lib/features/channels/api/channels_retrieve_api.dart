import 'package:dio/dio.dart';
import 'package:grupus/features/channels/models/channel_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/api_response.dart';

class ChannelsRetrieveApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> retrieveAllChannels({
    String? workspaceId,
    String? groupId,
  }) async {
    try {
      final query = <String, dynamic>{
        if (workspaceId != null && workspaceId.isNotEmpty)
          'workspace_id': workspaceId,
        if (groupId != null && groupId.isNotEmpty) 'group_id': groupId,
      };

      final response = await _dio.get(
        '/channels/',
        queryParameters: query.isEmpty ? null : query,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final List<dynamic> itemsList =
            (data is Map<String, dynamic> && data['results'] is List)
                ? data['results'] as List<dynamic>
                : (data is List)
                ? data
                : <dynamic>[];

        final channels =
            itemsList
                .whereType<Map>()
                .map(
                  (item) =>
                      ChannelModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList();

        final listResponse = ApiListResponse<ChannelModel>(
          items: channels,
          rawData: data is Map<String, dynamic> ? data : {},
        );

        return ApiResponse(
          success: true,
          message: 'Channels retrieved successfully',
          data: listResponse,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to retrieve channels: ${response.statusMessage}',
        data: {},
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Failed to retrieve channels',
          data: {},
        );
      }
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.message}',
        data: {},
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }

  Future<ApiResponse> retrieveChannel(String channelId) async {
    try {
      final response = await _dio.get('/channels/$channelId/');

      if (response.statusCode == 200) {
        final data = response.data;
        final rawChannel =
            (data is List && data.isNotEmpty) ? data.first : data;

        if (rawChannel is! Map) {
          return ApiResponse(
            success: false,
            message: 'Invalid channel payload',
            data: {},
          );
        }

        final channel = ChannelModel.fromJson(
          Map<String, dynamic>.from(rawChannel),
        );

        return ApiResponse(
          success: true,
          message: 'Channel retrieved successfully',
          data: channel,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to retrieve channel: ${response.statusMessage}',
        data: {},
      );
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiResponse(
          success: false,
          message: e.response?.data['message'] ?? 'Failed to retrieve channel',
          data: {},
        );
      }
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.message}',
        data: {},
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'An unexpected error occurred: $e',
        data: {},
      );
    }
  }
}
