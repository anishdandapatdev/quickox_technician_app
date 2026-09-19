import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Membership & Subscription Plans Screen
class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        title: const Text('Quickox Care Club'),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // Hero Intro Banner
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.bgDark,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFFFBBF24),
                    size: 48,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Zero Labor Charges, Priority Dispatches',
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Join thousands of happy homeowners with an annual maintenance subscription.',
                    style: AppTextStyles.bodySm.copyWith(
                      color: const Color(0xFFCBD5E1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Plan 1: Essential
            _PlanCard(
              title: 'Essential Care',
              price: '₹499',
              period: '/year',
              isPopular: false,
              features: const [
                '2 Free Home Safety Audits / year',
                '15% discount on all service labor',
                'Standard 60-min emergency dispatch',
                '30-day post-service warranty',
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Plan 2: Plus (Most Popular)
            _PlanCard(
              title: 'Plus Care',
              price: '₹999',
              period: '/year',
              isPopular: true,
              features: const [
                'Unlimited Free Home Safety Audits',
                '100% Free Labor on Electrical & Plumbing',
                'Priority 30-min Emergency Dispatch',
                '10% Flat Discount on Spare Parts',
                'Dedicated Home Service Manager',
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Plan 3: Pro
            _PlanCard(
              title: 'Pro Complete',
              price: '₹1,799',
              period: '/year',
              isPopular: false,
              features: const [
                'All Plus Care Benefits included',
                'Free AC Jet Service (2 Units / year)',
                'Water Purifier & RO Health Check',
                'Zero Cancellation & Rescheduling Fees',
                'VIP 24/7 Phone Support',
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.isPopular,
    required this.features,
  });

  final String title;
  final String price;
  final String period;
  final bool isPopular;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: isPopular ? AppColors.primary : AppColors.border,
          width: isPopular ? 2 : 1,
        ),
        boxShadow: [
          if (isPopular)
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg - 2),
                ),
              ),
              child: const Text(
                'MOST POPULAR CHOICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTextStyles.h3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          price,
                          style: AppTextStyles.h2.copyWith(
                            color: isPopular
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(period, style: AppTextStyles.bodySm),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(color: AppColors.border),
                const SizedBox(height: AppSpacing.md),
                ...features.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            f,
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: isPopular
                      ? ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Subscribed to $title'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                          child: const Text('Subscribe Now'),
                        )
                      : OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selected $title'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                          child: const Text('Select Plan'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
