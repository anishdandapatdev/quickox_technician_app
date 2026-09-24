import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../home/screens/home_screen.dart';
import '../services/screens/services_screen.dart';
import '../membership/screens/membership_screen.dart';
import '../bookings/screens/bookings_screen.dart';
import '../profile/screens/profile_screen.dart';
import 'widgets/modern_bottom_nav_bar.dart';

/// Main Application Shell hosting the modern 5-tab BottomNavigationBar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigateTab: _onTabTapped),
      ServicesScreen(onNavigateTab: _onTabTapped),
      const MembershipScreen(),
      const BookingsScreen(),
      const ProfileScreen(),
    ];

    const navItems = [
      ModernNavItem(
        unselectedIcon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        label: AppStrings.navHome,
      ),
      ModernNavItem(
        unselectedIcon: Icons.grid_view_outlined,
        selectedIcon: Icons.grid_view_rounded,
        label: AppStrings.navServices,
      ),
      ModernNavItem(
        unselectedIcon: Icons.workspace_premium_outlined,
        selectedIcon: Icons.workspace_premium_rounded,
        label: AppStrings.navMembership,
      ),
      ModernNavItem(
        unselectedIcon: Icons.calendar_month_outlined,
        selectedIcon: Icons.calendar_month_rounded,
        label: AppStrings.navBook,
        badgeCount: 1,
      ),
      ModernNavItem(
        unselectedIcon: Icons.person_outline_rounded,
        selectedIcon: Icons.person_rounded,
        label: AppStrings.navProfile,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        color: AppColors.bgSecondary,
        child: ModernBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: navItems,
          style: ModernNavStyle.floatingPill,
        ),
      ),
    );
  }
}
