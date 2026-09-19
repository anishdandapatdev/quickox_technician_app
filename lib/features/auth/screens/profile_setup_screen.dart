import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../navigation/main_navigation_screen.dart';

/// User Profile Setup Screen after OTP verification
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController(text: 'Haldia Central, WB');

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _useCurrentLocation() {
    setState(() {
      _locationController.text = 'Haldia Central, Purba Medinipur, WB';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location detected: Haldia Central'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleCompleteSetup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate saving profile to backend / Firestore
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to Main Screen with 5 bottom navigation tabs
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
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
            vertical: AppSpacing.xl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.md),

                // ── Avatar with Camera badge ─────────────────────────────────
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 52,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Title & Subtitle ─────────────────────────────────────────
                Text(AppStrings.profileSetupTitle, style: AppTextStyles.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  AppStrings.profileSetupSubtitle,
                  style: AppTextStyles.bodyMd,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Name Field ───────────────────────────────────────────────
                _InputLabel(label: AppStrings.fullName),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: AppStrings.fullNameHint,
                    prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().length < 2) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Email / Gmail Field ──────────────────────────────────────
                _InputLabel(label: AppStrings.email),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: AppStrings.emailHint,
                    prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your email or Gmail address';
                    }
                    if (!val.contains('@') || !val.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Location / Address Field ─────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _InputLabel(label: AppStrings.location),
                    GestureDetector(
                      onTap: _useCurrentLocation,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.my_location_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Use Current',
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _locationController,
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: AppStrings.locationHint,
                    prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textMuted),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your location or address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Submit Button ────────────────────────────────────────────
                GradientButton(
                  label: AppStrings.completeSetup,
                  isLoading: _isLoading,
                  onPressed: _handleCompleteSetup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.labelMd.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
