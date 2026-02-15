import 'package:grupus/features/auth/api/registration_api.dart';
import 'package:grupus/features/auth/models/registration_model.dart';
import 'package:grupus/features/auth/models/user_create_model.dart';
import 'package:grupus/shared/utils/logs.dart';

class RegisterServices {
  var registrationApi = RegistrationApi();

  Future<bool> registerUser(RegistrationModel registrationData) async {
    try {
      UserCreateModel userCreateData = UserCreateModel(
        username: registrationData.username,
        email: registrationData.email,
        password: registrationData.password,
        password2: registrationData.password,
        firstName: registrationData.firstName,
        lastName: registrationData.lastName,
        isEmailVerified: registrationData.isEmailVerified,
        bio: registrationData.bio,
        profilePicture: registrationData.profilePicture,
        preferredLanguage: registrationData.preferredLanguage,
        notificationSettings: registrationData.notificationSettings,
      );

      DevLogs.logInfo("Registering user with data: ${userCreateData.toJson()}");

      final response = await registrationApi.register(userCreateData);

      DevLogs.logInfo(
        "Registration response: ${response.message}, success: ${response.success}",
      );

      if (!response.success) {
        DevLogs.logError("Registration failed: ${response.message}");
        return Future.value(false);
      }

      return Future.value(true);
    } catch (e) {
      DevLogs.logError("Error during registration: $e");
      return Future.value(false);
    }
  }
}
