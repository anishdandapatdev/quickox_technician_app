import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'category_detail_screen.dart';

/// Service Categories Catalog Screen matching the updated Quickox UI design
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({
    super.key,
    this.onNavigateTab,
  });

  final ValueChanged<int>? onNavigateTab;

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<_CategoryItem> _allCategories = [
    _CategoryItem(
      title: 'Home Service',
      description: 'AC, Electrical, Plumbing, RO & Appliance Repair',
      imageUrl:
          'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['AC Repair', 'Plumbing', 'Appliance Repair'],
      fallbackIcon: Icons.home_repair_service_rounded,
    ),
    _CategoryItem(
      title: 'Food Delivery',
      description: 'Tiffin, Home Cooked Meals, Restaurant Food',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['Home Food', 'Restaurants', 'Tiffin'],
      fallbackIcon: Icons.restaurant_rounded,
    ),
    _CategoryItem(
      title: 'Bike & Cab Service',
      description: 'Bike repair, Car service, Cab booking',
      imageUrl:
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['Bike Service', 'Car Service', 'Cab Booking'],
      fallbackIcon: Icons.directions_car_rounded,
    ),
    _CategoryItem(
      title: 'Emergency Ambulance',
      description: '24/7 Medical Support',
      imageUrl:
          'https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['24/7 Service', 'Trained Staff', 'Quick Response'],
      fallbackIcon: Icons.medical_services_rounded,
    ),
    _CategoryItem(
      title: 'Medicine Delivery',
      description: 'Medicines at your doorstep',
      imageUrl:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['Generic Medicines', 'Health Care', 'Fast Delivery'],
      fallbackIcon: Icons.medication_rounded,
    ),
    _CategoryItem(
      title: 'Room Booking',
      description: 'Hotels, PG, Guest House',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Hotels', 'PG', 'Guest House'],
      fallbackIcon: Icons.hotel_rounded,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = _searchQuery.isEmpty
        ? _allCategories
        : _allCategories.where((c) {
            final q = _searchQuery.toLowerCase();
            return c.title.toLowerCase().contains(q) ||
                c.description.toLowerCase().contains(q) ||
                c.tags.any((t) => t.toLowerCase().contains(q));
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),

              // ── Header Section with Technician Hero Illustration ─────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: Title & Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Service Categories',
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Select any category below to browse services, book instantly and get it done at your doorstep.',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Right: Technician with Backdrop and Floating Badge
                  SizedBox(
                    width: 125,
                    height: 125,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Light blue curved shape
                        Positioned(
                          top: 4,
                          right: 0,
                          child: Container(
                            width: 108,
                            height: 112,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(54),
                                topRight: Radius.circular(54),
                                bottomLeft: Radius.circular(54),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        // Technician Image
                        Positioned(
                          bottom: 0,
                          right: 2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              AppAssets.technicianAvatar,
                              height: 120,
                              width: 105,
                              fit: BoxFit.cover,
                              errorBuilder: (_, e, s) => Image.asset(
                                AppAssets.technicianRohit,
                                height: 120,
                                width: 105,
                                fit: BoxFit.cover,
                                errorBuilder: (_, e2, s2) => Image.network(
                                  'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=400&q=80',
                                  height: 120,
                                  width: 105,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, e3, s3) => Container(
                                    height: 120,
                                    width: 105,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFBAE6FD),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.engineering_rounded,
                                        size: 48,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Floating "Trusted Experts" Badge
                        Positioned(
                          bottom: 16,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_rounded,
                                  color: Color(0xFF0F172A),
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Trusted',
                                      style: TextStyle(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0F172A),
                                        height: 1.1,
                                      ),
                                    ),
                                    Text(
                                      'Experts',
                                      style: TextStyle(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0F172A),
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Search Bar ────────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search all services (AC repair, plumbing, etc.)',
                    hintStyle: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textMuted,
                      size: 22,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Action Buttons Row ─────────────────────────────────────────
              Row(
                children: [
                  // Book Inspection Button (Filled Blue)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      onPressed: () {
                        widget.onNavigateTab?.call(3); // Book tab
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Book Inspection',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // View Membership Plans Button (Outlined Blue)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      onPressed: () {
                        widget.onNavigateTab?.call(2); // Membership tab
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.workspace_premium_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'View Membership Plans',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Section Title: Explore All Service Categories ──────────────
              Text(
                'Explore All Service Categories',
                style: AppTextStyles.h3.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap on any category card below to view and book services.',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // ── 1-Column Horizontal Category Cards List ───────────────────
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCategories.length,
                separatorBuilder: (_, i) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final item = filteredCategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryDetailScreen(
                            headerTitle: item.title == 'Home Service'
                                ? 'Doorstep Home Services & Repairs'
                                : item.title,
                          ),
                        ),
                      );
                    },
                    child: _HorizontalCategoryCard(item: item),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Why Choose Quickox Banner ─────────────────────────────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7FF),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Choose Quickox?',
                      style: AppTextStyles.labelMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _TrustPillar(
                            icon: Icons.verified_user_rounded,
                            iconColor: AppColors.primary,
                            title: 'Verified\nProfessionals',
                          ),
                        ),
                        Expanded(
                          child: _TrustPillar(
                            icon: Icons.star_border_rounded,
                            iconColor: Color(0xFF2563EB),
                            title: 'Quality\nAssured',
                          ),
                        ),
                        Expanded(
                          child: _TrustPillar(
                            icon: Icons.access_time_rounded,
                            iconColor: Color(0xFF2563EB),
                            title: 'On-Time\nGuarantee',
                          ),
                        ),
                        Expanded(
                          child: _TrustPillar(
                            icon: Icons.sell_outlined,
                            iconColor: Color(0xFF2563EB),
                            title: 'Transparent\nPricing',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private Helper Widgets ────────────────────────────────────────────────────

enum _BadgeType { none, liveNow, comingSoon }

class _CategoryItem {
  const _CategoryItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.badgeText,
    required this.badgeType,
    required this.tags,
    required this.fallbackIcon,
  });

  final String title;
  final String description;
  final String imageUrl;
  final String? badgeText;
  final _BadgeType badgeType;
  final List<String> tags;
  final IconData fallbackIcon;
}

class _HorizontalCategoryCard extends StatelessWidget {
  const _HorizontalCategoryCard({required this.item});

  final _CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 118),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Left: Image with Badge ────────────────────────────────────────
            SizedBox(
              width: 128,
              child: Stack(
                fit: StackFit.expand,
              children: [
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => Container(
                    color: AppColors.bgTertiary,
                    child: Center(
                      child: Icon(
                        item.fallbackIcon,
                        color: AppColors.textMuted,
                        size: 36,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.bgTertiary,
                      child: const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(AppColors.primary),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Top-right Badge
                if (item.badgeText != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: item.badgeType == _BadgeType.liveNow
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(
                          color: item.badgeType == _BadgeType.liveNow
                              ? const Color(0xFF86EFAC)
                              : const Color(0xFFFDE68A),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.badgeType == _BadgeType.liveNow)
                            Container(
                              width: 5.5,
                              height: 5.5,
                              margin: const EdgeInsets.only(right: 3.5),
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            const Padding(
                              padding: EdgeInsets.only(right: 3.5),
                              child: Icon(
                                Icons.access_time_rounded,
                                size: 9.5,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          Text(
                            item.badgeText!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: item.badgeType == _BadgeType.liveNow
                                  ? const Color(0xFF15803D)
                                  : const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Right: Content & Arrow ────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title + Subtitle and Circular Chevron
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelMd.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.5,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySm.copyWith(
                                fontSize: 10.5,
                                height: 1.25,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Pill Tags Row
                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: item.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _TrustPillar extends StatelessWidget {
  const _TrustPillar({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  final IconData icon;
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
