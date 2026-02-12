import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/auth/models/registration_model.dart';

final registrationProvider =
    StateNotifierProvider<RegistrationProvider, RegistrationModel>(
  (ref) => RegistrationProvider(),
);

class RegistrationProvider extends StateNotifier<RegistrationModel> {
  RegistrationProvider()
      : super(const RegistrationModel(
          username: '',
          email: '',
          password: '',
          otp: 0,
          step: 0,
        ));

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateOTP(int otp) {
    state = state.copyWith(otp: otp);
  }

  void nextStep() {
    state = state.copyWith(step: state.step + 1);
  }

  void previousStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
    }
  }


  void updatePersonalInfo({
    String? firstName,
    String? lastName,
    String? bio,
    String? profilePicture,
    String? preferredLanguage,
    String? notificationSettings,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      bio: bio,
      profilePicture: profilePicture,
      preferredLanguage: preferredLanguage,
      notificationSettings: notificationSettings,
    );
  }

  void reset() {
    state = const RegistrationModel(
      username: '',
      email: '',
      password: '',
      otp: 0,
      step: 0,
    );
  }
}