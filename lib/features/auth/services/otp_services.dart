
import 'package:grupus/features/auth/api/registration_api.dart';
import 'package:grupus/shared/utils/logs.dart';

class OtpServices {
  var registrationApi = RegistrationApi();

  Future<bool> requestOTP(String email) async {
    try {
      final response = await registrationApi.requestOtp(email);

      if (!response.success) {
        DevLogs.logError("Request OTP failed: ${response.message}");
        return false;
      }

      return true;
    } catch (e) {
      DevLogs.logError("Error: $e");
      return false;
    }
  }

  Future<bool> verifyOTP(String email, int otp) async {
    try {
      final response = await registrationApi.verifyOtp(email, otp);

      if (!response.success) {
        DevLogs.logError("Verify OTP failed: ${response.message}");
        return false;
      }

      return true;
    } catch (e) {
      DevLogs.logError("Error: $e");
      return false;
    }
  }
}