import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Navigation bar item model for [ModernBottomNavBar]
class ModernNavItem {
  const ModernNavItem({
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount,
    this.showBadgeDot = false,
  });

  final IconData unselectedIcon;
  final IconData selectedIcon;
  final String label;
  final int? badgeCount;
  final bool showBadgeDot;
}

/// Visual presentation styles for [ModernBottomNavBar]
enum ModernNavStyle {
  /// Floating island dock with rounded corners and ambient shadow
  floatingPill,

  /// Edge-to-edge bar with curved top corners and safe area integration
  curvedFlush,
}

/// High-polish, modern mobile navigation bar.
///
/// Features:
/// - Smooth animated active pill capsule behind the icon
/// - Spring scale micro-interaction and touch press feedback
/// - Sliding micro-indicator pill below the label
/// - Haptic feedback on tap
/// - Integrated badge counts and active indicator dots
/// - Supports both floating pill dock and curved flush bar layouts
class ModernBottomNavBar extends StatelessWidget {
  const ModernBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.style = ModernNavStyle.floatingPill,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<ModernNavItem> items;
  final ModernNavStyle style;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    if (style == ModernNavStyle.floatingPill) {
      return SafeArea(
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            bottomPadding > 0 ? AppSpacing.xs : AppSpacing.md,
          ),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.bgPrimary,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.8),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Row(
                children: List.generate(
                  items.length,
                  (index) => Expanded(
                    child: _NavBarTabItem(
                      item: items[index],
                      isSelected: currentIndex == index,
                      onTap: () => _handleTap(index),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Curved Flush Style
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: List.generate(
              items.length,
              (index) => Expanded(
                child: _NavBarTabItem(
                  item: items[index],
                  isSelected: currentIndex == index,
                  onTap: () => _handleTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap(int index) {
    if (index != currentIndex) {
      HapticFeedback.selectionClick();
      onTap(index);
    }
  }
}

class _NavBarTabItem extends StatefulWidget {
  const _NavBarTabItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final ModernNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavBarTabItem> createState() => _NavBarTabItemState();
}

class _NavBarTabItemState extends State<_NavBarTabItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final item = widget.item;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Icon with capsule backdrop & badge ──
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Animated pill highlight behind active icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  width: isSelected ? 48 : 36,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                // Icon with spring scale
                AnimatedScale(
                  scale: isSelected ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? item.selectedIcon : item.unselectedIcon,
                    size: 22,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textMuted,
                  ),
                ),

                // Badge count or badge dot
                if (item.badgeCount != null && item.badgeCount! > 0)
                  Positioned(
                    top: -3,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.5,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.logoOrange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.bgPrimary,
                          width: 1.5,
                        ),
                      ),
                      constraints: const BoxConstraints(minWidth: 16),
                      child: Text(
                        item.badgeCount! > 9 ? '9+' : '${item.badgeCount}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                    ),
                  )
                else if (item.showBadgeDot)
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.logoOrange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.bgPrimary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),

            // ── Label ──
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
                letterSpacing: 0.1,
              ),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),

            // ── Micro Indicator Dot/Line ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
              width: isSelected ? 12 : 0,
              height: 2.5,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
