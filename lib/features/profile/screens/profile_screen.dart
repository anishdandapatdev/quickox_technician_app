import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/screens/login_screen.dart';

/// User Profile & Account Settings Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── User Header Card ─────────────────────────────────────────────
            Container(
              color: AppColors.bgPrimary,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: const Text(
                      'RS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rahul Sharma',
                          style: AppTextStyles.h3.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'rahul.sharma@gmail.com',
                          style: AppTextStyles.bodySm,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '+91 98765 43210',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // ── Quickox Care Membership Badge ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: Color(0xFFFBBF24),
                      size: 32,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quickox Care Plus',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Active until 15 Sept 2027',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Menu Options ──────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Saved Addresses',
                    subtitle: 'Home, Office, Other',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  _ProfileMenuItem(
                    icon: Icons.payment_rounded,
                    title: 'Payment Methods',
                    subtitle: 'UPI, Cards, Netbanking',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  _ProfileMenuItem(
                    icon: Icons.headset_mic_outlined,
                    title: 'Help & 24/7 Support',
                    subtitle: 'Chat or call our support team',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  _ProfileMenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms & Privacy Policy',
                    subtitle: 'Service rules & data security',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Logout Button ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  label: const Text('Log Out'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Log Out'),
                        content: const Text(
                          'Are you sure you want to log out from Quickox?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                            ),
                            onPressed: () {
                              Navigator.pop(ctx);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text('Log Out'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: Text(title, style: AppTextStyles.labelMd),
      subtitle: Text(subtitle, style: AppTextStyles.bodySm),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
