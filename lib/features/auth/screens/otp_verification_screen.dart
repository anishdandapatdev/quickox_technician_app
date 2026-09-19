import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/common_widgets.dart';
import 'profile_setup_screen.dart';

/// OTP Verification screen for the user app
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  int _resendCountdown = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() => _resendCountdown = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    if (_otpCode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 6 digits of the OTP code'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate OTP verification API call
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to profile setup screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileSetupScreen(phoneNumber: widget.phoneNumber),
      ),
    );
  }

  void _resendCode() {
    if (_resendCountdown > 0) return;
    _startResendTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new OTP has been sent to your mobile number'),
        backgroundColor: AppColors.success,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.lg),
              // Icon Badge
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Title & Subtitle
              Text(AppStrings.verifyPhone, style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.otpSubtitle,
                style: AppTextStyles.bodyMd,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.phoneNumber,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Edit',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // 6-digit OTP input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: AppTextStyles.h3.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        fillColor: _controllers[index].text.isNotEmpty
                            ? AppColors.primary.withValues(alpha: 0.05)
                            : AppColors.bgSecondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          borderSide: const BorderSide(
                            color: AppColors.borderFocus,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {});
                        if (val.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        if (_otpCode.length == 6) {
                          _verifyOtp();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Verify & Continue Button
              GradientButton(
                label: AppStrings.verifyOtp,
                isLoading: _isLoading,
                onPressed: _otpCode.length == 6 ? _verifyOtp : null,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Resend countdown or action
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.didntReceive, style: AppTextStyles.bodyMd),
                  GestureDetector(
                    onTap: _resendCountdown == 0 ? _resendCode : null,
                    child: Text(
                      _resendCountdown > 0
                          ? '${AppStrings.resendCode} in ${_resendCountdown}s'
                          : AppStrings.resendCode,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: _resendCountdown > 0
                            ? AppColors.textMuted
                            : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
