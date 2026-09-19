import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'sub_services_screen.dart';

/// Screen displaying service categories in the exact horizontal card style
/// with top back navigation and category subtitle.
class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({
    super.key,
    this.headerTitle = 'Doorstep Home Services & Repairs',
    this.headerSubtitle =
        'Select a category below to view services, inspect coverage, and book verified professionals instantly.',
  });

  final String headerTitle;
  final String headerSubtitle;

  static const List<_SubCategoryItem> _items = [
    _SubCategoryItem(
      title: 'Home Service',
      description: 'AC, Electrical, Plumbing, RO & Appliance Repair',
      imageUrl:
          'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['AC Repair', 'Plumbing', 'RO Service'],
      fallbackIcon: Icons.home_repair_service_rounded,
    ),
    _SubCategoryItem(
      title: 'Food Delivery',
      description: 'Tiffin, Home Cooked Meals, Restaurant Food',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['Home Food', 'Restaurants', 'Tiffin'],
      fallbackIcon: Icons.restaurant_rounded,
    ),
    _SubCategoryItem(
      title: 'Bike & Cab Service',
      description: 'Bike repair, Car service, Cab booking',
      imageUrl:
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['Bike Service', 'Car Service', 'Cab Booking'],
      fallbackIcon: Icons.directions_car_rounded,
    ),
    _SubCategoryItem(
      title: 'Event Booking (Birthday, Marriage, Rice ceremony)',
      description:
          'Function, Decorations, Catering, Rental Materials, Event & Photography',
      imageUrl:
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Event Booking', 'Catering', 'Decoration'],
      fallbackIcon: Icons.celebration_rounded,
    ),
    _SubCategoryItem(
      title: 'Emergency Ambulance',
      description: '24/7 Medical Support & ICU on Wheels',
      imageUrl:
          'https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=600&q=80',
      badgeText: null,
      badgeType: _BadgeType.none,
      tags: ['24/7 Service', 'Trained Staff', 'Paramedic Care'],
      fallbackIcon: Icons.medical_services_rounded,
    ),
    _SubCategoryItem(
      title: 'Medicine Delivery',
      description:
          'Prescribed & Non-Prescribed Medicines, Health & Wellness Products',
      imageUrl:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Live Now',
      badgeType: _BadgeType.liveNow,
      tags: ['Generic Medicines', 'Health Care', 'Fast Delivery'],
      fallbackIcon: Icons.medication_rounded,
    ),
    _SubCategoryItem(
      title: 'Room Booking',
      description: 'Hotels, PG, Guest House, Homestays',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Hotels', 'PG', 'Guest House'],
      fallbackIcon: Icons.hotel_rounded,
    ),
    _SubCategoryItem(
      title: 'QUICKOX ELECTRA Scooty',
      description: 'Electric Scooty Sales & Service',
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=600&q=80',
      badgeText: 'Coming Soon',
      badgeType: _BadgeType.comingSoon,
      tags: ['Sales', 'Service', 'Spare Parts'],
      fallbackIcon: Icons.electric_moped_rounded,
    ),
  ];

  void _handleCardTap(BuildContext context, _SubCategoryItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubServicesScreen(
          categoryTitle: item.title,
          categorySubtitle: item.description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar with Back Button & Centered Title ───────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.xs,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
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
                  const SizedBox(width: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, right: 28),
                      child: Column(
                        children: [
                          Text(
                            headerTitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            headerSubtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySm.copyWith(
                              fontSize: 11.5,
                              color: AppColors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(color: AppColors.border, height: 1),

            // ── List of Same-Style Horizontal Cards ─────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: _items.length,
                separatorBuilder: (_, i) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return GestureDetector(
                    onTap: () => _handleCardTap(context, item),
                    child: _DetailHorizontalCard(item: item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private Helper Widgets ────────────────────────────────────────────────────

enum _BadgeType { none, liveNow, comingSoon }

class _SubCategoryItem {
  const _SubCategoryItem({
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

class _DetailHorizontalCard extends StatelessWidget {
  const _DetailHorizontalCard({required this.item});

  final _SubCategoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
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
      child: Row(
        children: [
          // ── Left: Image with Badge Overlay ────────────────────────────────
          SizedBox(
            width: 128,
            height: double.infinity,
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

                // Badge (Live Now / Coming Soon)
                if (item.badgeText != null)
                  Positioned(
                    top: 6,
                    left: 6,
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
    );
  }
}
