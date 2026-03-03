import 'package:grupus/features/users/api/users_api.dart';
import 'package:grupus/features/users/models/user_model.dart';
import 'package:grupus/shared/models/api_list_response.dart';
import 'package:grupus/shared/utils/logs.dart';

class UserServices {
  var userRetrieveApi = UsersApi();

  /// Retrieves the current user, handling null data safely
  /// Returns null if user retrieval fails
  Future<User?> getCurrentUser() async {
    try {
      var response = await userRetrieveApi.getCurrentUser();

      if (!response.success || response.data == null) {
        DevLogs.logError('Failed to retrieve user: ${response.message}');
        return null;
      }

      // response.data is already a User object from the API
      if (response.data is User) {
        return response.data as User;
      }

      DevLogs.logError(
        'Unexpected data type from API: ${response.data.runtimeType}',
      );
      return null;
    } catch (e) {
      DevLogs.logError('Error in UserServices.getCurrentUser: $e');
      return null;
    }
  }
}
