import 'package:dio/dio.dart';
import 'package:grupus/features/channels/models/channel_model.dart';
import 'package:grupus/shared/api/api_client.dart';
import 'package:grupus/shared/utils/api_response.dart';

class ChannelsCreateApi {
  final Dio _dio = ApiClient().dio;

  Future<ApiResponse> createChannel(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post('/channels/', data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final channel =
            (data is Map)
                ? ChannelModel.fromJson(Map<String, dynamic>.from(data))
                : null;

        return ApiResponse(
          success: true,
          message: 'Channel created successfully',
          data: channel ?? data,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to create channel: ${response.statusMessage}',
        data: response.data,
      );
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data['message'] ?? 'Failed to create channel',
        data: e.response?.data,
      );
    } catch (e) {
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> updateChannel(
    String channelId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await _dio.put('/channels/$channelId/', data: payload);

      if (response.statusCode == 200) {
        final data = response.data;
        final channel =
            (data is Map)
                ? ChannelModel.fromJson(Map<String, dynamic>.from(data))
                : null;

        return ApiResponse(
          success: true,
          message: 'Channel updated successfully',
          data: channel ?? data,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to update channel: ${response.statusMessage}',
        data: response.data,
      );
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data['message'] ?? 'Failed to update channel',
        data: e.response?.data,
      );
    } catch (e) {
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> patchChannel(
    String channelId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await _dio.patch('/channels/$channelId/', data: payload);

      if (response.statusCode == 200) {
        final data = response.data;
        final channel =
            (data is Map)
                ? ChannelModel.fromJson(Map<String, dynamic>.from(data))
                : null;

        return ApiResponse(
          success: true,
          message: 'Channel patched successfully',
          data: channel ?? data,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to patch channel: ${response.statusMessage}',
        data: response.data,
      );
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data['message'] ?? 'Failed to patch channel',
        data: e.response?.data,
      );
    } catch (e) {
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }

  Future<ApiResponse> deleteChannel(String channelId) async {
    try {
      final response = await _dio.delete('/channels/$channelId/');

      if (response.statusCode == 200 ||
          response.statusCode == 202 ||
          response.statusCode == 204) {
        return ApiResponse(
          success: true,
          message: 'Channel deleted successfully',
          data: response.data,
        );
      }

      return ApiResponse(
        success: false,
        message: 'Failed to delete channel: ${response.statusMessage}',
        data: response.data,
      );
    } on DioException catch (e) {
      return ApiResponse(
        success: false,
        message: e.response?.data['message'] ?? 'Failed to delete channel',
        data: e.response?.data,
      );
    } catch (e) {
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
