import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Bookings / Orders History Screen
class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.labelMd,
          tabs: const [
            Tab(text: 'Active (1)'),
            Tab(text: 'Completed (2)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ── Active Bookings Tab ───────────────────────────────────────────
          ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _BookingCard(
                orderId: 'QX-98241',
                serviceName: 'AC Deep Clean & Jet Service',
                dateTime: 'Today, 2:30 PM',
                status: 'Technician Dispatched',
                statusColor: AppColors.primary,
                technicianName: 'Sanjay Mukherjee',
                technicianPhone: '+91 98321 45670',
                isActive: true,
              ),
            ],
          ),

          // ── Completed Bookings Tab ────────────────────────────────────────
          ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _BookingCard(
                orderId: 'QX-87119',
                serviceName: 'Switchboard & Socket Installation',
                dateTime: '12 Sep 2026, 11:00 AM',
                status: 'Completed',
                statusColor: AppColors.success,
                technicianName: 'Amitava Roy',
                technicianPhone: '+91 98765 12345',
                isActive: false,
              ),
              const SizedBox(height: AppSpacing.md),
              _BookingCard(
                orderId: 'QX-84902',
                serviceName: 'Bathroom Tap Leakage Repair',
                dateTime: '28 Aug 2026, 4:15 PM',
                status: 'Completed',
                statusColor: AppColors.success,
                technicianName: 'Bikash Das',
                technicianPhone: '+91 98450 67890',
                isActive: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.orderId,
    required this.serviceName,
    required this.dateTime,
    required this.status,
    required this.statusColor,
    required this.technicianName,
    required this.technicianPhone,
    required this.isActive,
  });

  final String orderId;
  final String serviceName;
  final String dateTime;
  final String status;
  final Color statusColor;
  final String technicianName;
  final String technicianPhone;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: AppTextStyles.labelSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            serviceName,
            style: AppTextStyles.h3.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(dateTime, style: AppTextStyles.bodySm),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.bgTertiary,
                child: Icon(Icons.person, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      technicianName,
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Certified Technician',
                      style: AppTextStyles.bodySm.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (isActive)
                IconButton(
                  icon: const Icon(Icons.phone_rounded, color: AppColors.success),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling $technicianName ($technicianPhone)...'),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
