import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Services Catalog Screen
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Services',
    'AC & Appliances',
    'Electrical',
    'Plumbing',
    'Cleaning',
    'Painting',
  ];

  final List<_ServiceItemData> _services = const [
    _ServiceItemData(
      title: 'AC Power Saver Jet Cleaning',
      category: 'AC & Appliances',
      price: '₹599',
      duration: '45 mins',
      rating: '4.9 ★',
      icon: Icons.ac_unit_rounded,
    ),
    _ServiceItemData(
      title: 'Switchboard & Socket Installation',
      category: 'Electrical',
      price: '₹149',
      duration: '30 mins',
      rating: '4.8 ★',
      icon: Icons.bolt_rounded,
    ),
    _ServiceItemData(
      title: 'Water Tap & Pipe Leakage Repair',
      category: 'Plumbing',
      price: '₹199',
      duration: '30 mins',
      rating: '4.8 ★',
      icon: Icons.water_drop_rounded,
    ),
    _ServiceItemData(
      title: 'Washing Machine Full Diagnostic',
      category: 'AC & Appliances',
      price: '₹299',
      duration: '60 mins',
      rating: '4.7 ★',
      icon: Icons.local_laundry_service_rounded,
    ),
    _ServiceItemData(
      title: 'Kitchen Deep Cleaning & Degreasing',
      category: 'Cleaning',
      price: '₹899',
      duration: '2 hours',
      rating: '4.9 ★',
      icon: Icons.cleaning_services_rounded,
    ),
    _ServiceItemData(
      title: 'Ceiling Fan Repair & Regreasing',
      category: 'Electrical',
      price: '₹199',
      duration: '30 mins',
      rating: '4.7 ★',
      icon: Icons.mode_fan_off_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices = _selectedCategoryIndex == 0
        ? _services
        : _services
            .where((s) => s.category == _categories[_selectedCategoryIndex])
            .toList();

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        title: const Text('All Services'),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Category pill tabs
          Container(
            color: AppColors.bgPrimary,
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 10,
              ),
              itemCount: _categories.length,
              separatorBuilder: (_, i) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.bgSecondary,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: AppTextStyles.labelMd.copyWith(
                          fontSize: 13,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Services list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: filteredServices.length,
              separatorBuilder: (_, i) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final item = filteredServices[index];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.bgPrimary,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Icon(
                          item.icon,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTextStyles.labelMd.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  item.duration,
                                  style: AppTextStyles.bodySm,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.rating,
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: const Color(0xFFF59E0B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.price,
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added "${item.title}" to booking'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        child: const Text('Book', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItemData {
  const _ServiceItemData({
    required this.title,
    required this.category,
    required this.price,
    required this.duration,
    required this.rating,
    required this.icon,
  });

  final String title;
  final String category;
  final String price;
  final String duration;
  final String rating;
  final IconData icon;
}
