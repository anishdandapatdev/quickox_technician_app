import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/country_code.dart';
import '../widgets/country_picker_prefix.dart';
import 'otp_verification_screen.dart';
import 'signup_screen.dart';

/// Login screen — OTP-based phone authentication
/// Follows the Quickox design system: Royal Blue primary, white background.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ── State ──────────────────────────────────────────────────────────────────
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isValid = false;

  // ── Country data ───────────────────────────────────────────────────────────
  CountryCode _selectedCountry = CountryCode.defaultCountry;

  // ── Animation ──────────────────────────────────────────────────────────────
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeCtrl,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));

    _phoneController.addListener(_onPhoneChanged);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _phoneController
      ..removeListener(_onPhoneChanged)
      ..dispose();
    _fadeCtrl.dispose();
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

  void _appleLogin() {
    _googleLogin();
  }

  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
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
                    // ── Top Bar with back arrow ──────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.bgSecondary,
                            border: Border.all(color: AppColors.border),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

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

                    // ── Phone Field ───────────────────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.mobileNumber,
                        style: AppTextStyles.labelMd
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PhoneField(
                      controller: _phoneController,
                      selectedCountry: _selectedCountry,
                      onCountryChanged: (c) =>
                          setState(() => _selectedCountry = c),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Send OTP Button ───────────────────────────────────────
                    GradientButton(
                      label: AppStrings.sendOtp,
                      onPressed: _isValid ? _sendOtp : null,
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
                    const SizedBox(height: AppSpacing.md),
                    SocialLoginButton(
                      label: AppStrings.continueWithApple,
                      icon: const Icon(
                        Icons.apple,
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: _appleLogin,
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

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    required this.controller,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  final TextEditingController controller;
  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: '98765 43210',
        prefixIcon: CountryPickerPrefix(
          selected: selectedCountry,
          onChanged: onCountryChanged,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      validator: (value) {
        if (value == null || value.trim().length < 10) {
          return 'Enter a valid 10-digit mobile number';
        }
        return null;
      },
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const Text(
        'G',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4285F4),
          height: 1.3,
        ),
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
