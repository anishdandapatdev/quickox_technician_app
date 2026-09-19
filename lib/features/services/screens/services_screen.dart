import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Service Categories Catalog Screen matching the Quickox UI design
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
      tags: ['AC Repair', 'Plumbing'],
      fallbackIcon: Icons.home_repair_service_rounded,
    ),
    _CategoryItem(
      title: 'Food Delivery',
      description: 'Tiffin, Home Cooked Meals, Restaurant Food',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['Home Food', 'Restaurants'],
      fallbackIcon: Icons.restaurant_rounded,
    ),
    _CategoryItem(
      title: 'Bike & Cab Service',
      description: 'Bike repair, Car service, Cab booking',
      imageUrl:
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['Bike Service', 'Cab Booking'],
      fallbackIcon: Icons.directions_car_rounded,
    ),
    _CategoryItem(
      title: 'Event Booking',
      description: 'Birthday, Marriage, Catering & more',
      imageUrl:
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Birthday', 'Catering'],
      fallbackIcon: Icons.celebration_rounded,
    ),
    _CategoryItem(
      title: 'Emergency Ambulance',
      description: '24/7 Medical Support',
      imageUrl:
          'https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['24/7 Service', 'Trained Staff'],
      fallbackIcon: Icons.medical_services_rounded,
    ),
    _CategoryItem(
      title: 'Medicine Delivery',
      description: 'Medicines at your doorstep',
      imageUrl:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['Generic Medicines', 'Health Care'],
      fallbackIcon: Icons.medication_rounded,
    ),
    _CategoryItem(
      title: 'Room Booking',
      description: 'Hotels, PG, Guest House',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Hotels', 'PG'],
      fallbackIcon: Icons.hotel_rounded,
    ),
    _CategoryItem(
      title: 'Quickox Electra',
      description: 'Electric Scooty Sales & Service',
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['Sales', 'Service'],
      fallbackIcon: Icons.electric_moped_rounded,
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

              // ── Heading: All Service Categories ───────────────────────────
              Text(
                'All Service Categories',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select any category below to browse services, book instantly and get it done at your doorstep.',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          const Flexible(
                            child: Text(
                              'Book Inspection',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
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

              // ── 2-Column Category Cards Grid ──────────────────────────────
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisExtent: 228,
                ),
                itemBuilder: (context, index) {
                  final item = filteredCategories[index];
                  return _CategoryCard(item: item);
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.item});

  final _CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with Badge Overlay ──────────────────────────────────────
          SizedBox(
            height: 104,
            width: double.infinity,
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
                        size: 38,
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
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
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
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.access_time_rounded,
                                size: 10,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          Text(
                            item.badgeText!,
                            style: TextStyle(
                              fontSize: 9.5,
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

          // ── Content Info ──────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and Arrow
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
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySm.copyWith(
                                fontSize: 10,
                                height: 1.25,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Tag Chips Row
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
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
