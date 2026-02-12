import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final String username;
  final String email;
  final String password;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? bio;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'preferred_language')
  final String? preferredLanguage;
  @JsonKey(name: 'notification_settings')
  final String? notificationSettings;
  final int? otp; // Store as String for leading zeros
  final int step;

  const RegistrationModel({
    required this.username,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.bio,
    this.profilePicture,
    this.preferredLanguage,
    this.notificationSettings,
    this.otp,
    this.step = 0,
  });

  RegistrationModel copyWith({
    String? username,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? bio,
    String? profilePicture,
    String? preferredLanguage,
    String? notificationSettings,
    int? otp,
    int? step,
  }) {
    return RegistrationModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      otp: otp ?? this.otp,
      step: step ?? this.step,
    );
  }

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}
