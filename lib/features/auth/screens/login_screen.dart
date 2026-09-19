import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/common_widgets.dart';

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
  static const _defaultCountry = _CountryCode(
    flag: '🇮🇳',
    code: '+91',
    iso: 'IN',
  );
  _CountryCode _selectedCountry = _defaultCountry;

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
    // TODO: wire up Firebase phone auth / your OTP service
    await Future.delayed(const Duration(seconds: 2)); // simulate network
    if (mounted) setState(() => _isLoading = false);
  }

  void _googleLogin() {
    // TODO: implement Google sign-in
  }

  void _appleLogin() {
    // TODO: implement Apple sign-in
  }

  void _createAccount() {
    // TODO: navigate to RegisterScreen
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
                vertical: AppSpacing.xxl,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      icon: _GoogleIcon(),
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
  final _CountryCode selectedCountry;
  final ValueChanged<_CountryCode> onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style:
          AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: '98765 43210',
        prefixIcon: _CountryPicker(
          selected: selectedCountry,
          onChanged: onCountryChanged,
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
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

class _CountryPicker extends StatelessWidget {
  const _CountryPicker({
    required this.selected,
    required this.onChanged,
  });

  final _CountryCode selected;
  final ValueChanged<_CountryCode> onChanged;

  static const _countries = [
    _CountryCode(flag: '🇮🇳', code: '+91', iso: 'IN'),
    _CountryCode(flag: '🇺🇸', code: '+1', iso: 'US'),
    _CountryCode(flag: '🇬🇧', code: '+44', iso: 'GB'),
    _CountryCode(flag: '🇦🇺', code: '+61', iso: 'AU'),
    _CountryCode(flag: '🇦🇪', code: '+971', iso: 'AE'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final chosen = await showModalBottomSheet<_CountryCode>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          builder: (_) => _CountryPickerSheet(
            countries: _countries,
            selected: selected,
          ),
        );
        if (chosen != null) onChanged(chosen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selected.flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 4),
            Text(
              selected.code,
              style: AppTextStyles.labelMd
                  .copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: AppColors.textMuted),
            const SizedBox(width: 4),
            Container(
              width: 1,
              height: 20,
              color: AppColors.border,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatelessWidget {
  const _CountryPickerSheet({
    required this.countries,
    required this.selected,
  });

  final List<_CountryCode> countries;
  final _CountryCode selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Select Country', style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border),
          ...countries.map(
            (c) => ListTile(
              leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
              title: Text(
                '${c.iso}  ${c.code}',
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.textPrimary),
              ),
              trailing: c == selected
                  ? const Icon(Icons.check_circle_rounded,
                      color: AppColors.primary)
                  : null,
              onTap: () => Navigator.pop(context, c),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
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

// ── Data model ─────────────────────────────────────────────────────────────────

class _CountryCode {
  const _CountryCode({
    required this.flag,
    required this.code,
    required this.iso,
  });

  final String flag;
  final String code;
  final String iso;

  @override
  bool operator ==(Object other) =>
      other is _CountryCode && other.iso == iso;

  @override
  int get hashCode => iso.hashCode;
}
