import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/firebase_services_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'service_detail_overview_screen.dart';

/// Screen 2: Filtered Category Services Grid
/// Exactly matches home_service_web/src/features/services/service_category_screen.jsx
/// with search box, frequency pills (All / One-Time / Monthly), counter,
/// and dynamic service cards loaded from Firebase Firestore backend.
class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    super.key,
    this.categoryName = 'Doorstep Home Services & Repairs',
    this.headerTitle,
    this.headerSubtitle,
  });

  final String categoryName;
  final String? headerTitle;
  final String? headerSubtitle;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseServicesService _servicesService = FirebaseServicesService();

  String _searchQuery = '';
  String _activeFrequency = 'All'; // 'All', 'One-Time', 'Monthly'
  late List<ServiceItem> _services;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final initialList = FirebaseServicesService.defaultServices.where((s) {
      final c = widget.categoryName.toLowerCase();
      return s.category.toLowerCase().contains(c) ||
          c.contains(s.category.toLowerCase()) ||
          s.categoryId.toLowerCase().contains(c);
    }).toList();
    _services = initialList.isNotEmpty
        ? initialList
        : FirebaseServicesService.defaultServices;
    _loadServices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadServices() async {
    try {
      final list = await _servicesService.fetchServicesForCategory(
        categoryName: widget.categoryName,
        frequency: _activeFrequency,
        query: _searchQuery,
      );
      if (mounted && list.isNotEmpty) {
        setState(() {
          _services = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onFrequencyChanged(String freq) {
    if (_activeFrequency == freq) return;
    setState(() {
      _activeFrequency = freq;
    });
    _loadServices();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _loadServices();
  }

  void _handleReset() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _activeFrequency = 'All';
    });
    _loadServices();
  }

  String _formatCategoryTitle() {
    final cat = widget.headerTitle ?? widget.categoryName;
    if (cat.toLowerCase().contains('service') ||
        cat.toLowerCase().contains('repair')) {
      return cat;
    }
    return '$cat Services';
  }

  @override
  Widget build(BuildContext context) {
    final title = _formatCategoryTitle();
    final subtitle = widget.headerSubtitle ??
        'Select a service below to view coverage, price specs, and book verified professionals.';

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadServices,
          color: AppColors.primary,
          child: Column(
            children: [
              // ── Top Navigation Bar ──────────────────────────────────────────
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
                              title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.h3.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySm.copyWith(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),

              // ── Scrollable Body ─────────────────────────────────────────────
              Expanded(
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    // ── Search & Filter Panel (matching service_category_screen.jsx)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.bgPrimary,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: AppColors.border),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Box Row with Reset Button
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.md),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: _onSearchChanged,
                                    style: AppTextStyles.bodyMd.copyWith(
                                      color: AppColors.textPrimary,
                                      fontSize: 13,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search services by name...',
                                      hintStyle: AppTextStyles.bodySm.copyWith(
                                        color: AppColors.textMuted,
                                        fontSize: 12,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search_rounded,
                                        color: AppColors.textMuted,
                                        size: 20,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              OutlinedButton.icon(
                                onPressed: _handleReset,
                                icon: const Icon(Icons.refresh_rounded, size: 14),
                                label: const Text('Reset',
                                    style: TextStyle(fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.textSecondary,
                                  side: const BorderSide(
                                      color: AppColors.border),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.md),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Frequency Filter Segment
                          Text(
                            'SERVICE TYPE / PLAN',
                            style: AppTextStyles.labelSm.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textMuted,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildFrequencyTab(
                                  id: 'All',
                                  label: 'All Services',
                                  icon: Icons.auto_awesome_rounded,
                                ),
                                _buildFrequencyTab(
                                  id: 'One-Time',
                                  label: 'One-Time',
                                  icon: Icons.access_time_rounded,
                                ),
                                _buildFrequencyTab(
                                  id: 'Monthly',
                                  label: 'Monthly Sub',
                                  icon: Icons.sell_outlined,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),

                          // Counter & Category Info Row
                          const Divider(color: Color(0xFFF1F5F9), height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Showing: ${widget.categoryName} • $_activeFrequency',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodySm.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '${_services.length} services found',
                                style: AppTextStyles.bodySm.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Services Cards List ───────────────────────────────────
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    else if (_services.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.bgPrimary,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 48,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No Services Found for ${widget.categoryName}',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.labelMd.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try changing your search query or switching to All Services tab.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextButton(
                              onPressed: _handleReset,
                              child: const Text('View All Services'),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _services.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final svc = _services[index];
                          return _ServiceGridCard(
                            service: svc,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ServiceDetailOverviewScreen(
                                    service: svc,
                                    serviceTitle: svc.title,
                                    serviceSubtitle: svc.desc,
                                    parentCategory: widget.categoryName,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrequencyTab({
    required String id,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _activeFrequency == id;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onFrequencyChanged(id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 13,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private Service Grid Card (matching service_category_screen.jsx) ─────────

class _ServiceGridCard extends StatelessWidget {
  const _ServiceGridCard({
    required this.service,
    required this.onTap,
  });

  final ServiceItem service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Image with Rating Badge ─────────────────────────────────────
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (service.imageUrl.startsWith('http'))
                  Image.network(
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
                  )
                else
                  Image.asset(
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
                  ),

                // Top-right Rating Pill
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 2.5),
                        Text(
                          service.rating,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Card Details Body ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  service.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14.5,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),

                // Badges row: Verified + Frequency
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    // Verified Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_rounded,
                              size: 11, color: Color(0xFF059669)),
                          SizedBox(width: 3),
                          Text(
                            'Verified',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Frequency Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: service.frequency.toLowerCase().contains('month')
                            ? const Color(0xFFEFF6FF)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            service.frequency.toLowerCase().contains('month')
                                ? Icons.sell_outlined
                                : Icons.access_time_rounded,
                            size: 10,
                            color: service.frequency
                                    .toLowerCase()
                                    .contains('month')
                                ? const Color(0xFF2563EB)
                                : const Color(0xFF475569),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            service.frequency.toLowerCase().contains('month')
                                ? 'Monthly Sub'
                                : 'One-Time',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: service.frequency
                                      .toLowerCase()
                                      .contains('month')
                                  ? const Color(0xFF2563EB)
                                  : const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  service.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySm.copyWith(
                    fontSize: 11.5,
                    height: 1.35,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),

                // Price and View Service CTA Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Starting at',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySm.copyWith(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            service.price,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Service',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(Icons.arrow_forward_rounded, size: 13),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          service.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
