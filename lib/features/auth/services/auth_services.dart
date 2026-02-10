import 'package:grupus/features/auth/api/login_api.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';

class AuthServices {
  var authApi = LoginApi();

  Future<bool> login(String username, String password) async {
    username = username.trim();
    password = password.trim();

    try {
      final response = await authApi.login(username, password);

      if (!response.success) {
        return false;
      }

      final accessToken = response.data['access']?.toString();
      final refreshToken = response.data['refresh']?.toString();
      final userId = response.data['user']["id"]?.toString();

      DevLogs.logInfo("user id $userId");

      if (accessToken == null || refreshToken == null) {
        DevLogs.logError("Login failed: Missing tokens or user ID in response");
        return false;
      }

      await saveSP("accessToken", accessToken);
      await saveSP("refreshToken", refreshToken);
      // await saveSP("userId", userId);

      return true;
    } catch (e) {
      DevLogs.logError("Error: $e");
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await authApi.logout();

      if (!response.success) {
        DevLogs.logError("Logout failed: ${response.message}");
        return false;
      }

      await removeSP("accessToken");
      await removeSP("refreshToken");

      return true;
    } catch (e) {
      DevLogs.logError("Error: $e");
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final verifyAccess = await authApi.verifyToken();

      // Access token is valid, user is logged in
      if (verifyAccess.success) {
        return true;
      }

      // Access token expired, try to refresh
      final refreshTokenResponse = await authApi.refreshToken();

      if (!refreshTokenResponse.success) {
        return false;
      }

      final newAccessToken = refreshTokenResponse.data['access']?.toString();

      if (newAccessToken == null) {
        return false;
      }

      await saveSP("accessToken", newAccessToken);
      return true;
    } catch (e) {
      DevLogs.logError("Error: $e");
      return false;
    }
  }
}
