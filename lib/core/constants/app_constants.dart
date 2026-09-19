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

  // ── Sign Up ────────────────────────────────────────────────────────────────
  static const String joinQuickox = 'Join as Partner';
  static const String signUpSubtitle = 'Register as a certified service technician';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'e.g. Rahul Sharma';
  static const String email = 'Email Address';
  static const String emailHint = 'e.g. rahul.sharma@example.com';
  static const String primaryTrade = 'Primary Skill / Trade';
  static const String selectTrade = 'Select your trade';
  static const String serviceCity = 'Service City / Zone';
  static const String serviceCityHint = 'e.g. Haldia Central';
  static const String experience = 'Experience';
  static const String selectExperience = 'Years of experience';
  static const String termsNotice = 'I agree to the Quickox Partner Terms and Service Standards';
  static const String registerButton = 'Register as Technician';
  static const String alreadyRegistered = 'Already registered? ';
  static const String logIn = 'Log in';
}
