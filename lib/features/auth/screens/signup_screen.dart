import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/country_code.dart';
import '../widgets/country_picker_prefix.dart';
import 'otp_verification_screen.dart';

/// Customer Sign Up Screen: Phone number, Send OTP, and Sign in with Google
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  CountryCode _selectedCountry = CountryCode.defaultCountry;
  bool _isLoading = false;
  bool _isValid = false;

  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animCtrl,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));

    _phoneController.addListener(_onPhoneChanged);
    _animCtrl.forward();
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
    _animCtrl.dispose();
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
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.sm),
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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

                    // ── Mobile Number Field ───────────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.mobileNumber,
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: AppTextStyles.bodyLg.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: '98765 43210',
                        prefixIcon: CountryPickerPrefix(
                          selected: _selectedCountry,
                          onChanged: (c) => setState(() => _selectedCountry = c),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
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
                      onPressed: _isValid ? _handleSendOtp : null,
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
                    const SizedBox(height: AppSpacing.md),

                    // ── Sign in with Apple Button ─────────────────────────────
                    SocialLoginButton(
                      label: AppStrings.continueWithApple,
                      icon: const Icon(
                        Icons.apple,
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
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
        ),
      ),
    );
  }
}

class _GoogleLetterIcon extends StatelessWidget {
  const _GoogleLetterIcon();

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
