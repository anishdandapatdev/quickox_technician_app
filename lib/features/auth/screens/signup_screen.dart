import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/country_code.dart';
import '../widgets/rounded_phone_input.dart';
import 'otp_verification_screen.dart';

/// Customer Sign Up Screen: Phone number, Send OTP, and Sign in with Google
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  CountryCode _selectedCountry = CountryCode.defaultCountry;
  bool _isLoading = false;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final valid = _phoneController.text.trim().length >= 10;
    if (valid != _isValid) setState(() => _isValid = valid);
  }

  @override
  void dispose() {
    _phoneController
      ..removeListener(_onPhoneChanged)
      ..dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate sending OTP request
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    setState(() => _isLoading = false);

    final fullPhone = '${_selectedCountry.code} ${_phoneController.text.trim()}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(phoneNumber: fullPhone),
      ),
    );
  }

  void _handleGoogleSignIn() {
    // Navigate to OTP or Profile Setup for Google flow
    final fullPhone = '${_selectedCountry.code} ${_phoneController.text.trim()}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(
          phoneNumber: fullPhone.isNotEmpty ? fullPhone : '+91 98765 43210',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.xl),
                // ── Logo ──────────────────────────────────────────────────
                Image.asset(
                  AppAssets.logo,
                  height: 80,
                  fit: BoxFit.contain,
                  errorBuilder: (_, e, s) => const Icon(
                    Icons.home_repair_service_rounded,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Title & Subtitle ──────────────────────────────────────
                Text(AppStrings.signUpTitle, style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  AppStrings.signUpSubtitle,
                  style: AppTextStyles.bodyMd,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Rounded Phone Field ───────────────────────────────────
                RoundedPhoneInput(
                  controller: _phoneController,
                  selectedCountry: _selectedCountry,
                  onCountryChanged: (c) =>
                      setState(() => _selectedCountry = c),
                  validator: (v) {
                    if (v == null || v.trim().length < 10) {
                      return 'Enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Send OTP Button ───────────────────────────────────────
                GradientButton(
                  label: AppStrings.sendOtp,
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _handleSendOtp,
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Divider ───────────────────────────────────────────────
                const OrDivider(),
                const SizedBox(height: AppSpacing.lg),

                // ── Sign in with Google Button ────────────────────────────
                SocialLoginButton(
                  label: AppStrings.continueWithGoogle,
                  icon: const _GoogleLetterIcon(),
                  onPressed: _handleGoogleSignIn,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Already have account footer ───────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: AppTextStyles.bodyMd,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        AppStrings.logIn,
                        style: AppTextStyles.link,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleLetterIcon extends StatelessWidget {
  const _GoogleLetterIcon();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.google,
      width: 22,
      height: 22,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => const Icon(
        Icons.g_mobiledata_rounded,
        size: 22,
        color: Color(0xFF4285F4),
      ),
    );
  }
}
