/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Grupus';
  static const String appVersion = '1.0.0';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 1000);

  // Padding and Spacing
  static const double paddingXSmall = 4;
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;
  static const double paddingXLarge = 32;

  // Border Radius
  static const double borderRadiusSmall = 4;
  static const double borderRadiusMedium = 8;
  static const double borderRadiusLarge = 12;
  static const double borderRadiusXLarge = 20;

  // Icon Sizes
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double iconSizeXLarge = 48;

  // Font Sizes
  static const double fontSizeSmall = 12;
  static const double fontSizeMedium = 14;
  static const double fontSizeNormal = 16;
  static const double fontSizeLarge = 18;
  static const double fontSizeXLarge = 20;
  static const double fontSizeXXLarge = 24;
  static const double fontSizeTitle = 32;

  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration apiReadTimeout = Duration(seconds: 30);

  // Empty States
  static const String emptyStateMessage = 'No data available';
  static const String errorMessage = 'Something went wrong';
  static const String loadingMessage = 'Loading...';

  //API Endpoints
  static const String apiBaseUrl = 'http://192.168.1.5:8000';
}
