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
  static const String technician = 'assets/images/technician.png';
  static const String technicianRohit = 'assets/images/technician_rohit.png';
  static const String technicianAvatar = 'assets/images/technician_avatar.jpg';
  static const String refrigeratorTechnician =
      'assets/images/refrigerator_technician.jpg';
}

/// App-wide string constants
abstract final class AppStrings {
  AppStrings._();
  static const String appName = 'Quickox';

  // ── Auth & Sign In ────────────────────────────────────────────────────────
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
  static const String signUpTitle = 'Create Account';
  static const String signUpSubtitle = 'Sign up to book trusted home services instantly';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String logIn = 'Log in';

  // ── OTP Verification ───────────────────────────────────────────────────────
  static const String verifyPhone = 'Verify Phone';
  static const String otpSubtitle = 'Enter the 6-digit code sent to';
  static const String verifyOtp = 'Verify & Continue';
  static const String resendCode = 'Resend Code';
  static const String didntReceive = "Didn't receive the code? ";

  // ── Profile Setup ──────────────────────────────────────────────────────────
  static const String profileSetupTitle = 'Set Up Profile';
  static const String profileSetupSubtitle = 'Tell us a bit about yourself to personalize your experience';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'e.g. Rahul Sharma';
  static const String email = 'Email / Gmail';
  static const String emailHint = 'e.g. rahul@gmail.com';
  static const String location = 'Location / Address';
  static const String locationHint = 'e.g. Haldia Central, West Bengal';
  static const String completeSetup = 'Complete & Get Started';

  // ── Navigation Tabs ────────────────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navServices = 'Services';
  static const String navMembership = 'Membership';
  static const String navBook = 'Book';
  static const String navProfile = 'Profile';
}
