import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/country_code.dart';
import '../widgets/rounded_phone_input.dart';
import 'otp_verification_screen.dart';
import 'signup_screen.dart';

/// Login screen — OTP-based phone authentication
/// Follows the Quickox design system: Royal Blue primary, white background.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ── State ──────────────────────────────────────────────────────────────────
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isValid = false;

  // ── Country data ───────────────────────────────────────────────────────────
  CountryCode _selectedCountry = CountryCode.defaultCountry;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneController
      ..removeListener(_onPhoneChanged)
      ..dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final valid = _phoneController.text.trim().length >= 10;
    if (valid != _isValid) setState(() => _isValid = valid);
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);

    final fullPhone = '${_selectedCountry.code} ${_phoneController.text.trim()}';
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(phoneNumber: fullPhone),
      ),
    );
  }

  void _googleLogin() {
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


  void _createAccount() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const SignUpScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
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
                _Logo(),
                const SizedBox(height: AppSpacing.xl),

                // ── Welcome Text ──────────────────────────────────────────
                Text(AppStrings.welcomeBack, style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  AppStrings.loginSubtitle,
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
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return 'Enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Send OTP Button ───────────────────────────────────────
                GradientButton(
                  label: AppStrings.sendOtp,
                  onPressed: _isLoading ? null : _sendOtp,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Divider ───────────────────────────────────────────────
                const OrDivider(),
                const SizedBox(height: AppSpacing.lg),

                // ── Social Buttons ────────────────────────────────────────
                SocialLoginButton(
                  label: AppStrings.continueWithGoogle,
                  icon: const _GoogleIcon(),
                  onPressed: _googleLogin,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Sign Up Link ──────────────────────────────────────────
                _SignUpFooter(onTap: _createAccount),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      height: 90,
      fit: BoxFit.contain,
      errorBuilder: (_, e, s) => const Icon(
        Icons.home_repair_service_rounded,
        size: 72,
        color: AppColors.primary,
      ),
    );
  }
}


class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

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

class _SignUpFooter extends StatelessWidget {
  const _SignUpFooter({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.newToQuickox, style: AppTextStyles.bodyMd),
        GestureDetector(
          onTap: onTap,
          child: Text(AppStrings.createAccount, style: AppTextStyles.link),
        ),
      ],
    );
  }
}
