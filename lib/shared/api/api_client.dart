import 'package:dio/dio.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';

class ApiClient {
  /// List of endpoints that don't require Authorization header
  static const List<String> _publicEndpoints = [
    '/users/login/',
    '/auth/jwt/refresh/',
    '/auth/jwt/verify/',
    '/auth/logout/',
  ];

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiReadTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            // Only add Authorization header if the endpoint requires it
            if (!_publicEndpoints.contains(options.path)) {
              final token = await getSP('accessToken');
              if (token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }
            }
          } catch (_) {}
          handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;
}
