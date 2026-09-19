/// Border radius tokens — mirrors design-system.md
abstract final class AppRadius {
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

/// Spacing scale (8-pt grid)
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

/// Asset paths — single source of truth for all image / icon paths
abstract final class AppAssets {
  AppAssets._();
  static const String logo = 'assets/images/icon_logo.jpeg';
}

/// App-wide string constants
abstract final class AppStrings {
  AppStrings._();
  static const String appName = 'Quickox Technician';
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle = 'Log in to continue';
  static const String mobileNumber = 'Enter mobile number';
  static const String sendOtp = 'Send OTP';
  static const String orContinueWith = 'or continue with';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String newToQuickox = 'New to Quickox? ';
  static const String createAccount = 'Create an account';
}
