import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import 'book_technician_screen.dart';
import 'shop_parts_screen.dart';

/// Screen displaying the complete Service Overview & Landing details
/// matching the user mockup with hero illustration, stats, "Choose What You Need",
/// trust badges, "What's Included", "How It Works", FAQs, Related Services, and
/// sticky immediate emergency help bottom bar.
class ServiceDetailOverviewScreen extends StatefulWidget {
  const ServiceDetailOverviewScreen({
    super.key,
    this.serviceTitle = 'Refrigerator Repair, Installation Solutions',
    this.serviceSubtitle =
        'Diagnose and fix common refrigerator problems, repair refrigerator along with installation service.',
    this.parentCategory = 'Home Service',
  });

  final String serviceTitle;
  final String serviceSubtitle;
  final String parentCategory;

  @override
  State<ServiceDetailOverviewScreen> createState() =>
      _ServiceDetailOverviewScreenState();
}

class _ServiceDetailOverviewScreenState
    extends State<ServiceDetailOverviewScreen> {
  // Accordion open/close state for FAQs
  final Set<int> _expandedFaqIndices = {};

  final List<Map<String, String>> _faqs = [
    {
      'question': 'Is inspection really free?',
      'answer':
          'Yes! Initial home inspection is completely free when you proceed with the repair service.',
    },
    {
      'question': 'What if extra material is required?',
      'answer':
          'Our technician will provide an upfront rate card before replacing any parts. You only pay for genuine parts used.',
    },
    {
      'question': 'Do you provide a warranty?',
      'answer':
          'Yes! Every service comes with a 30-day service warranty. Any recurring issues are fixed completely free.',
    },
    {
      'question': 'How soon can an electrician arrive?',
      'answer':
          'Our verified technicians typically arrive at your doorstep within 30 to 60 minutes of booking confirmation.',
    },
    {
      'question': 'Are your electricians verified?',
      'answer':
          'All Quickox service professionals are 100% background verified, police checked, and certified experts.',
    },
  ];

  final List<Map<String, dynamic>> _relatedServices = [
    {
      'title': 'AC Service',
      'icon': Icons.ac_unit_rounded,
      'color': Color(0xFF2563EB),
    },
    {
      'title': 'Washing Machine\nRepair',
      'icon': Icons.local_laundry_service_rounded,
      'color': Color(0xFF0284C7),
    },
    {
      'title': 'Geyser Repair',
      'icon': Icons.water_drop_rounded,
      'color': Color(0xFFD97706),
    },
    {
      'title': 'Microwave Repair',
      'icon': Icons.microwave_rounded,
      'color': Color(0xFF7C3AED),
    },
  ];

  void _openBookingFlow(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookTechnicianScreen(
          serviceTitle: widget.serviceTitle,
          parentCategory: widget.parentCategory,
        ),
      ),
    );
  }

  void _openSparePartsSheet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ShopPartsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable Body ─────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Top Navigation & Hero Section ─────────────────────────
                    _buildHeroSection(context),

                    const SizedBox(height: 12),

                    // ── Stats Bar ─────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildStatsBar(),
                    ),

                    const SizedBox(height: 20),

                    // ── Choose What You Need Section ──────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildChooseWhatYouNeedSection(context),
                    ),

                    const SizedBox(height: 16),

                    // ── 4 Trust Badges Row ────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildTrustBadgesRow(),
                    ),

                    const SizedBox(height: 24),

                    // ── What's Included Section ───────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildWhatsIncludedSection(),
                    ),

                    const SizedBox(height: 24),

                    // ── How It Works Section ──────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildHowItWorksSection(),
                    ),

                    const SizedBox(height: 24),

                    // ── FAQs & Related Services ───────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildFaqsAndRelatedServices(context),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Sticky Bottom Help Bar ──────────────────────────────────────
            _buildStickyHelpBar(context),
          ],
        ),
      ),
    );
  }

  // ── 1. Hero Section ─────────────────────────────────────────────────────────

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF0F172A),
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row with Text & Tags on Left, Technician + Refrigerator on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Info
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.serviceTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        height: 1.2,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.serviceSubtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Value Prop Pill Badges
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: const [
                        _ValueBadge(
                          icon: Icons.verified_user_rounded,
                          label: 'Verified Professionals',
                          bgColor: Color(0xFFDCFCE7),
                          borderColor: Color(0xFF86EFAC),
                          textColor: Color(0xFF15803D),
                        ),
                        _ValueBadge(
                          icon: Icons.access_time_rounded,
                          label: 'On-time Service',
                          bgColor: Color(0xFFEFF6FF),
                          borderColor: Color(0xFFBFDBFE),
                          textColor: Color(0xFF1D4ED8),
                        ),
                        _ValueBadge(
                          icon: Icons.sell_rounded,
                          label: 'Transparent Pricing',
                          bgColor: Color(0xFFFEF3C7),
                          borderColor: Color(0xFFFDE68A),
                          textColor: Color(0xFFB45309),
                        ),
                        _ValueBadge(
                          icon: Icons.shield_rounded,
                          label: 'Service Warranty',
                          bgColor: Color(0xFFF3E8FF),
                          borderColor: Color(0xFFDDD6FE),
                          textColor: Color(0xFF7E22CE),
                        ),
                        _ValueBadge(
                          icon: Icons.headset_mic_rounded,
                          label: '24/7 Support',
                          bgColor: Color(0xFFFCE7F3),
                          borderColor: Color(0xFFFBCFE8),
                          textColor: Color(0xFFBE185D),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Right Illustration: Light Blue Blob + Technician Image
              Expanded(
                flex: 4,
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Refrigerator & Technician Image
                      Image.asset(
                        AppAssets.refrigeratorTechnician,
                        fit: BoxFit.cover,
                        height: 175,
                        width: double.infinity,
                        errorBuilder: (_, e, s) => Image.asset(
                          AppAssets.technicianAvatar,
                          fit: BoxFit.cover,
                          height: 175,
                          width: double.infinity,
                          errorBuilder: (_, e2, s2) => Image.network(
                            'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=600&q=80',
                            fit: BoxFit.cover,
                            height: 175,
                            width: double.infinity,
                            errorBuilder: (_, e3, s3) => const Center(
                              child: Icon(
                                Icons.kitchen_rounded,
                                size: 64,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── 2. Stats Bar ────────────────────────────────────────────────────────────

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
          Expanded(
            child: _StatColumn(
              icon: Icons.access_time_rounded,
              iconColor: Color(0xFF2563EB),
              label: 'Service Time',
              value: '30 - 60 mins',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _StatColumn(
              icon: Icons.star_rounded,
              iconColor: Color(0xFFF59E0B),
              label: 'Rating',
              value: '4.8 (12k+)',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _StatColumn(
              icon: Icons.calendar_today_rounded,
              iconColor: Color(0xFF2563EB),
              label: 'Availability',
              value: 'All Days',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _StatColumn(
              icon: Icons.shield_outlined,
              iconColor: Color(0xFF2563EB),
              label: 'Warranty',
              value: 'Upto 30 Days',
            ),
          ),
        ],
      ),
    );
  }

  // ── 3. Choose What You Need Section ─────────────────────────────────────────

  Widget _buildChooseWhatYouNeedSection(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Choose What You Need',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "We've got you covered. Book a visit or shop for genuine parts.",
          style: TextStyle(
            fontSize: 11.5,
            color: Color(0xFF64748B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),

        // Two Cards: Book a Technician & Buy Spare Parts
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card 1: Book a Technician
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF93C5FD), width: 1.2),
                ),
                child: Stack(
                  children: [
                    // Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 24, 12, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEFF6FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: Color(0xFF2563EB),
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Book a Technician',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Schedule a home visit with our expert technicians.',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xFF64748B),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Bullet points
                          _buildCheckRow(
                            'Home inspection & diagnosis',
                            const Color(0xFF2563EB),
                          ),
                          _buildCheckRow(
                            'Expert repair & installation',
                            const Color(0xFF2563EB),
                          ),
                          _buildCheckRow(
                            'Service warranty up to 30 days',
                            const Color(0xFF2563EB),
                          ),
                          _buildCheckRow(
                            'Available at all days',
                            const Color(0xFF2563EB),
                          ),
                          const SizedBox(height: 14),

                          // Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () => _openBookingFlow(context),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Book Now',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, size: 14),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // MOST POPULAR Top Badge
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF7C3AED),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'MOST POPULAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Card 2: Buy Spare Parts
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF86EFAC), width: 1.2),
                ),
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.storefront_outlined,
                        color: Color(0xFF16A34A),
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Buy Spare Parts',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Get genuine spare parts & accessories delivered to your doorstep.',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bullet points
                    _buildCheckRow(
                      '100% Genuine Products',
                      const Color(0xFF16A34A),
                    ),
                    _buildCheckRow(
                      'Trusted Brands',
                      const Color(0xFF16A34A),
                    ),
                    _buildCheckRow(
                      'Fast Delivery',
                      const Color(0xFF16A34A),
                    ),
                    _buildCheckRow(
                      'Easy Returns',
                      const Color(0xFF16A34A),
                    ),
                    const SizedBox(height: 14),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF059669),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _openSparePartsSheet(context),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shop Parts',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_rounded, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckRow(String text, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_rounded, size: 14, color: iconColor),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10.5,
                color: Color(0xFF334155),
                height: 1.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 4. Trust Badges Row ─────────────────────────────────────────────────────

  Widget _buildTrustBadgesRow() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: const [
          Expanded(
            child: _MiniTrustBadge(
              icon: Icons.person_search_rounded,
              iconColor: Color(0xFF2563EB),
              title: 'Trained Experts',
              subtitle: 'Background verified',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _MiniTrustBadge(
              icon: Icons.sell_outlined,
              iconColor: Color(0xFF16A34A),
              title: 'Upfront Pricing',
              subtitle: 'Clear & transparent',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _MiniTrustBadge(
              icon: Icons.flash_on_rounded,
              iconColor: Color(0xFF7C3AED),
              title: 'Quick Response',
              subtitle: 'At your convenience',
            ),
          ),
          _VerticalDivider(),
          Expanded(
            child: _MiniTrustBadge(
              icon: Icons.verified_rounded,
              iconColor: Color(0xFFD97706),
              title: 'Satisfaction',
              subtitle: 'Quality service',
            ),
          ),
        ],
      ),
    );
  }

  // ── 5. What's Included Section ──────────────────────────────────────────────

  Widget _buildWhatsIncludedSection() {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Wiring & Electrical',
        'desc': 'Check and repair wiring faults',
        'icon': Icons.bolt_rounded,
      },
      {
        'title': 'Switch & Socket Installation',
        'desc': 'Install and replace switches',
        'icon': Icons.power_rounded,
      },
      {
        'title': 'MCB & Fuse Installation',
        'desc': 'MCB, RCCB and fuse setup',
        'icon': Icons.settings_rounded,
      },
      {
        'title': 'Lighting Solutions',
        'desc': 'LED lights, chandeliers, etc.',
        'icon': Icons.lightbulb_outline_rounded,
      },
      {
        'title': 'Fault Repair',
        'desc': 'Fix power failure & short circuits',
        'icon': Icons.build_rounded,
      },
      {
        'title': 'Safety Check',
        'desc': 'Complete electrical safety check',
        'icon': Icons.shield_outlined,
      },
    ];

    return Column(
      children: [
        const Text(
          "What's Included",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),

        // 2-Column Grid of 6 items
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 64,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final it = items[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      it['icon'] as IconData,
                      color: const Color(0xFF2563EB),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          it['title'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          it['desc'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ── 6. How It Works Section ─────────────────────────────────────────────────

  Widget _buildHowItWorksSection() {
    final steps = [
      {
        'num': '1. Book a Service',
        'desc': 'Choose date & time',
        'icon': Icons.calendar_today_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'num': '2. Expert Arrives',
        'desc': 'Verified professional at doorstep',
        'icon': Icons.person_outline_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'num': '3. Inspection',
        'desc': 'We inspect & suggest solution',
        'icon': Icons.search_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'num': '4. Service Done',
        'desc': 'We repair with genuine parts',
        'icon': Icons.build_rounded,
        'color': const Color(0xFF2563EB),
      },
      {
        'num': '5. Relax & Enjoy',
        'desc': 'Your home is in safer hands',
        'icon': Icons.check_circle_outline_rounded,
        'color': const Color(0xFF16A34A),
      },
    ];

    return Column(
      children: [
        const Text(
          'How It Works',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 14),

        // Horizontal Stepper
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(steps.length, (index) {
              final s = steps[index];
              final isLast = index == steps.length - 1;
              return Row(
                children: [
                  SizedBox(
                    width: 86,
                    child: Column(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: (s['color'] as Color).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            s['icon'] as IconData,
                            color: s['color'] as Color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s['num'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s['desc'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 8.5,
                            color: Color(0xFF64748B),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // ── 7. FAQs & Related Services Section ──────────────────────────────────────

  Widget _buildFaqsAndRelatedServices(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width > 600, show side-by-side, else stacked
        if (constraints.maxWidth > 580) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildFaqsColumn()),
              const SizedBox(width: 16),
              Expanded(child: _buildRelatedServicesColumn(context)),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFaqsColumn(),
              const SizedBox(height: 20),
              _buildRelatedServicesColumn(context),
            ],
          );
        }
      },
    );
  }

  Widget _buildFaqsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'FAQs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Accordion List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: List.generate(_faqs.length, (i) {
              final faq = _faqs[i];
              final isExpanded = _expandedFaqIndices.contains(i);
              final isLast = i == _faqs.length - 1;

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedFaqIndices.remove(i);
                        } else {
                          _expandedFaqIndices.add(i);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq['question']!,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.remove_rounded
                                : Icons.add_rounded,
                            size: 16,
                            color: const Color(0xFF2563EB),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Text(
                        faq['answer']!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          height: 1.35,
                        ),
                      ),
                    ),
                  if (!isLast)
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedServicesColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Related Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // 2x2 Grid of Related Services
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _relatedServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 80,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final item = _relatedServices[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailOverviewScreen(
                      serviceTitle: item['title'] as String,
                      serviceSubtitle:
                          'Certified repair, inspection and doorstep maintenance service.',
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      size: 26,
                      color: item['color'] as Color,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['title'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ── 8. Sticky Bottom Immediate Help Bar ─────────────────────────────────────

  Widget _buildStickyHelpBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        border: const Border(
          top: BorderSide(color: Color(0xFFFECDD3)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Red Headset Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFFEE2E2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.headset_mic_rounded,
              color: Color(0xFFDC2626),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),

          // Text
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Need Immediate Help?',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFDC2626),
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "Facing an emergency? We're just a call or chat away.",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Call Now Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              minimumSize: const Size(0, 34),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connecting to 24/7 Quickox Emergency Helpline...'),
                  backgroundColor: Color(0xFFDC2626),
                ),
              );
            },
            icon: const Icon(Icons.call_rounded, size: 14),
            label: const Text(
              'Call Now',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 6),

          // WhatsApp Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              minimumSize: const Size(0, 34),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening Quickox WhatsApp Support Desk...'),
                  backgroundColor: Color(0xFF16A34A),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_rounded, size: 13),
            label: const Text(
              'WhatsApp',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private Helper Widgets ────────────────────────────────────────────────────

class _ValueBadge extends StatelessWidget {
  const _ValueBadge({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE2E8F0),
    );
  }
}

class _MiniTrustBadge extends StatelessWidget {
  const _MiniTrustBadge({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(height: 3),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 8,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

