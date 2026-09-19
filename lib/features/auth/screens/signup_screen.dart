import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/country_code.dart';
import '../widgets/country_picker_prefix.dart';

/// Technician registration / sign up screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // ── Form Controllers ────────────────────────────────────────────────────────
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController(text: 'Haldia Central');

  CountryCode _selectedCountry = CountryCode.defaultCountry;
  String? _selectedTrade;
  String? _selectedExperience;
  bool _agreedToTerms = true;
  bool _isLoading = false;

  // ── Trade / Skill options with icons ─────────────────────────────────────────
  static const List<_TradeOption> _tradeOptions = [
    _TradeOption(label: 'Electrician', icon: Icons.bolt_rounded),
    _TradeOption(label: 'Plumber', icon: Icons.water_drop_rounded),
    _TradeOption(label: 'AC Repair & Service', icon: Icons.ac_unit_rounded),
    _TradeOption(label: 'Home Appliance Repair', icon: Icons.home_repair_service_rounded),
    _TradeOption(label: 'Carpenter', icon: Icons.carpenter_rounded),
    _TradeOption(label: 'Painter & Decorator', icon: Icons.format_paint_rounded),
    _TradeOption(label: 'Cleaning Specialist', icon: Icons.cleaning_services_rounded),
  ];

  static const List<String> _experienceOptions = [
    'Less than 1 year',
    '1 - 3 years',
    '3 - 5 years',
    '5 - 10 years',
    '10+ years (Master Technician)',
  ];

  // ── Animation ──────────────────────────────────────────────────────────────
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

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the partner terms to proceed.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulated network onboarding call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        icon: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: Color(0xFFDCFCE7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 36,
          ),
        ),
        title: Text(
          'Application Submitted!',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Welcome to Quickox! Our operations dispatcher will verify your details and activate your partner account shortly.',
          style: AppTextStyles.bodyMd,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx); // Close dialog
                Navigator.pop(context); // Return to login
              },
              child: const Text('Back to Login'),
            ),
          ),
        ],
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
        title: const Text('Partner Registration'),
        centerTitle: true,
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
                    // ── Header Branding ──────────────────────────────────────
                    Image.asset(
                      AppAssets.logo,
                      height: 72,
                      fit: BoxFit.contain,
                      errorBuilder: (_, e, s) => const Icon(
                        Icons.home_repair_service_rounded,
                        size: 56,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(AppStrings.joinQuickox, style: AppTextStyles.h2),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      AppStrings.signUpSubtitle,
                      style: AppTextStyles.bodyMd,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Full Name Field ───────────────────────────────────────
                    _FormFieldLabel(label: AppStrings.fullName, isRequired: true),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: AppStrings.fullNameHint,
                        prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().length < 2) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // ── Mobile Number Field with Country Picker ────────────────
                    _FormFieldLabel(label: AppStrings.mobileNumber, isRequired: true),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: '98765 43210',
                        prefixIcon: CountryPickerPrefix(
                          selected: _selectedCountry,
                          onChanged: (c) => setState(() => _selectedCountry = c),
                        ),
                        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().length < 10) {
                          return 'Enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // ── Email Field ───────────────────────────────────────────
                    _FormFieldLabel(label: AppStrings.email, isRequired: false),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: AppStrings.emailHint,
                        prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted),
                      ),
                      validator: (v) {
                        if (v != null && v.isNotEmpty && !v.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // ── Primary Trade / Skill Dropdown ────────────────────────
                    _FormFieldLabel(label: AppStrings.primaryTrade, isRequired: true),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedTrade,
                      hint: Text(
                        AppStrings.selectTrade,
                        style: AppTextStyles.bodyMd.copyWith(color: AppColors.textMuted),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textMuted),
                      dropdownColor: AppColors.bgPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      items: _tradeOptions.map((trade) {
                        return DropdownMenuItem<String>(
                          value: trade.label,
                          child: Row(
                            children: [
                              Icon(trade.icon, size: 20, color: AppColors.primary),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                trade.label,
                                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedTrade = v),
                      validator: (v) => v == null ? 'Please select your trade' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // ── Service City / Zone ───────────────────────────────────
                    _FormFieldLabel(label: AppStrings.serviceCity, isRequired: true),
                    const SizedBox(height: AppSpacing.xs),
                    TextFormField(
                      controller: _cityController,
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: AppStrings.serviceCityHint,
                        prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textMuted),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Please enter your service city or zone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // ── Experience Dropdown ───────────────────────────────────
                    _FormFieldLabel(label: AppStrings.experience, isRequired: true),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedExperience,
                      hint: Text(
                        AppStrings.selectExperience,
                        style: AppTextStyles.bodyMd.copyWith(color: AppColors.textMuted),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textMuted),
                      dropdownColor: AppColors.bgPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      items: _experienceOptions.map((exp) {
                        return DropdownMenuItem<String>(
                          value: exp,
                          child: Text(
                            exp,
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedExperience = v),
                      validator: (v) => v == null ? 'Please select your experience' : null,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Terms Checkbox ────────────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agreedToTerms,
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
                            child: Text(
                              AppStrings.termsNotice,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Submit Button ─────────────────────────────────────────
                    GradientButton(
                      label: AppStrings.registerButton,
                      isLoading: _isLoading,
                      onPressed: _handleRegister,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // ── Divider ───────────────────────────────────────────────
                    const OrDivider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Social Sign-in Options ────────────────────────────────
                    SocialLoginButton(
                      label: AppStrings.continueWithGoogle,
                      icon: const _GoogleLetterIcon(),
                      onPressed: () {
                        // TODO: Implement Google partner OAuth
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SocialLoginButton(
                      label: AppStrings.continueWithApple,
                      icon: const Icon(
                        Icons.apple,
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () {
                        // TODO: Implement Apple partner OAuth
                      },
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // ── Already have account footer ───────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.alreadyRegistered, style: AppTextStyles.bodyMd),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(AppStrings.logIn, style: AppTextStyles.link),
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

// ── Private Helper Widgets ────────────────────────────────────────────────────

class _FormFieldLabel extends StatelessWidget {
  const _FormFieldLabel({
    required this.label,
    required this.isRequired,
  });

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: label,
          style: AppTextStyles.labelMd.copyWith(color: AppColors.textSecondary),
          children: [
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.error),
              ),
          ],
        ),
      ),
    );
  }
}

class _TradeOption {
  const _TradeOption({required this.label, required this.icon});
  final String label;
  final IconData icon;
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
