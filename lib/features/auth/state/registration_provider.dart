import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grupus/features/auth/models/registration_model.dart';

const String _registrationDataKey = 'registration_data';

final registrationProvider =
    StateNotifierProvider<RegistrationProvider, RegistrationModel>(
      (ref) => RegistrationProvider(ref),
    );

class RegistrationProvider extends StateNotifier<RegistrationModel> {
  final Ref _ref;

  RegistrationProvider(this._ref)
    : super(
        const RegistrationModel(
          username: '',
          email: '',
          password: '',
          otp: 0,
          step: 0,
        ),
      ) {
    _loadFromPrefs();
  }

  // Load registration data from SharedPreferences
  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_registrationDataKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        state = RegistrationModel.fromJson(json);
      }
    } catch (e) {
      // If load fails, keep the default empty state
      print('Error loading registration data: $e');
    }
  }

  // Save state to SharedPreferences
  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_registrationDataKey, jsonEncode(state.toJson()));
    } catch (e) {
      print('Error saving registration data: $e');
    }
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
    _saveToPrefs();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
    _saveToPrefs();
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
    _saveToPrefs();
  }

  void updateOTP(int otp) {
    state = state.copyWith(otp: otp);
    _saveToPrefs();
  }

  void nextStep() {
    state = state.copyWith(step: state.step + 1);
    _saveToPrefs();
  }

  void previousStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
      _saveToPrefs();
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
    _saveToPrefs();
  }

  void reset() {
    state = const RegistrationModel(
      username: '',
      email: '',
      password: '',
      otp: 0,
      step: 0,
    );
    _clearPrefs();
  }

  // Clear data from SharedPreferences
  Future<void> _clearPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_registrationDataKey);
    } catch (e) {
      print('Error clearing registration data: $e');
    }
  }
}
