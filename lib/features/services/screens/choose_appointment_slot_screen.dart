import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

/// Screen allowing the user to select an appointment date & time slot,
/// optionally request a top-rated technician, view booking summary,
/// and proceed to confirm & pay.
class ChooseAppointmentSlotScreen extends StatefulWidget {
  const ChooseAppointmentSlotScreen({
    super.key,
    this.serviceTitle = 'Water Pump Installation, Uninstallation, Repair',
    this.parentCategory = 'Electronics Services',
    this.serviceAddress = 'Chas Road, Purulia, West Bengal 723101',
    this.selectedIssue = 'Power Failure',
    this.basePrice = 249,
  });

  final String serviceTitle;
  final String parentCategory;
  final String serviceAddress;
  final String selectedIssue;
  final int basePrice;

  @override
  State<ChooseAppointmentSlotScreen> createState() =>
      _ChooseAppointmentSlotScreenState();
}

class _ChooseAppointmentSlotScreenState
    extends State<ChooseAppointmentSlotScreen> {
  int _selectedDateIndex = 2; // Default to Sunday 21 Sep matching mockup
  String _selectedSlot = '01:00 PM - 03:00 PM';
  bool _requestTopRatedTechnician = true;

  final List<Map<String, String>> _dates = [
    {'day': 'Fri', 'date': '19', 'month': 'Sep', 'full': 'Friday, 19 September 2026'},
    {'day': 'Sat', 'date': '20', 'month': 'Sep', 'full': 'Saturday, 20 September 2026'},
    {'day': 'Sun', 'date': '21', 'month': 'Sep', 'full': 'Sunday, 21 September 2026'},
    {'day': 'Mon', 'date': '22', 'month': 'Sep', 'full': 'Monday, 22 September 2026'},
    {'day': 'Tue', 'date': '23', 'month': 'Sep', 'full': 'Tuesday, 23 September 2026'},
    {'day': 'Wed', 'date': '24', 'month': 'Sep', 'full': 'Wednesday, 24 September 2026'},
    {'day': 'Thu', 'date': '25', 'month': 'Sep', 'full': 'Thursday, 25 September 2026'},
  ];

  final List<String> _morningSlots = [
    '09:00 AM - 11:00 AM',
    '11:00 AM - 01:00 PM',
  ];

  final List<String> _afternoonSlots = [
    '01:00 PM - 03:00 PM',
    '03:00 PM - 05:00 PM',
    '05:00 PM - 07:00 PM',
  ];

  final List<String> _eveningSlots = [
    '07:00 PM - 09:00 PM',
    '09:00 PM - 11:00 PM',
  ];

  void _showBookingConfirmedDialog() {
    final selectedDateStr = _dates[_selectedDateIndex]['full']!;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A34A),
                size: 52,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Appointment Confirmed!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your service for "${widget.serviceTitle}" is scheduled on $selectedDateStr at $_selectedSlot.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),

            if (_requestTopRatedTechnician) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(AppAssets.technicianRohit),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rohit Kumar Assigned',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                          Text(
                            'Top Rated • 4.9 ★ (450+ verified jobs)',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF3B82F6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payable (Post Service)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        '₹${widget.basePrice}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.serviceAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(dialogCtx);
                  // Pop back to home/services root
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // ── Header: Back button + Title & Subtitle ──────────────
                    _buildHeader(context),

                    const SizedBox(height: 14),

                    // ── Trust Badges Row ────────────────────────────────────
                    _buildTrustBadgesRow(),

                    const SizedBox(height: 20),

                    // ── 1. Select Date ──────────────────────────────────────
                    _buildSelectDateSection(),

                    const SizedBox(height: 22),

                    // ── 2. Select Time Slot ─────────────────────────────────
                    _buildSelectTimeSlotSection(),

                    const SizedBox(height: 22),

                    // ── 3. Prefer a Top-Rated Technician? ───────────────────
                    _buildTopRatedTechnicianSection(),

                    const SizedBox(height: 22),

                    // ── Booking Summary Card ────────────────────────────────
                    _buildBookingSummaryCard(),

                    const SizedBox(height: 16),

                    // ── What's Included Box ─────────────────────────────────
                    _buildWhatsIncludedBox(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Sticky Bottom Action Bar ────────────────────────────────────
            _buildStickyBottomBar(),
          ],
        ),
      ),
    );
  }

  // ── Header Widget ─────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF0F172A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Choose Appointment Slot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Select a convenient date and time for your home visit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24), // Balance back button
      ],
    );
  }

  // ── Trust Badges Row ──────────────────────────────────────────────────────

  Widget _buildTrustBadgesRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _MiniBadge(
            icon: Icons.verified_user_rounded,
            title: 'Verified\nProfessionals',
          ),
          _MiniBadge(
            icon: Icons.access_time_rounded,
            title: 'On-Time\nService',
          ),
          _MiniBadge(
            icon: Icons.shield_outlined,
            title: 'Up to 30 Days\nWarranty',
          ),
          _MiniBadge(
            icon: Icons.lock_outline_rounded,
            title: 'Secure & Safe',
          ),
        ],
      ),
    );
  }

  // ── 1. Select Date Section ────────────────────────────────────────────────

  Widget _buildSelectDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '1. Select Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),

        // Horizontal Date Cards List
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_dates.length, (index) {
              final d = _dates[index];
              final isSelected = _selectedDateIndex == index;

              return Padding(
                padding: EdgeInsets.only(right: index < _dates.length - 1 ? 8 : 0),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDateIndex = index),
                  child: Container(
                    width: 52,
                    height: 68,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                d['day']!,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? const Color(0xFF2563EB)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                d['date']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected
                                      ? const Color(0xFF1E3A8A)
                                      : const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                d['month']!,
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: isSelected
                                      ? const Color(0xFF2563EB)
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 13,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),

        // Selected Date Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFDCFCE7)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: Color(0xFF16A34A),
              ),
              const SizedBox(width: 8),
              Text(
                'Selected Date: ${_dates[_selectedDateIndex]['full']}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF15803D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── 2. Select Time Slot Section ───────────────────────────────────────────

  Widget _buildSelectTimeSlotSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '2. Select Time Slot',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),

        // Morning Slots
        _buildSlotGroup(
          emoji: '☀️',
          label: 'MORNING SLOTS (9 AM - 1 PM)',
          slots: _morningSlots,
        ),
        const SizedBox(height: 12),

        // Afternoon Slots
        _buildSlotGroup(
          emoji: '⛅',
          label: 'AFTERNOON SLOTS (1 PM - 7 PM)',
          slots: _afternoonSlots,
        ),
        const SizedBox(height: 12),

        // Evening Slots
        _buildSlotGroup(
          emoji: '🌙',
          label: 'EVENING SLOTS (7 PM - 11 PM)',
          slots: _eveningSlots,
        ),
        const SizedBox(height: 12),

        // Flexibility Info Box
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDBEAFE)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: Color(0xFF2563EB),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Flexibility: You can reschedule or cancel your appointment free of charge up to 2 hours before the scheduled time slot.',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF1E3A8A),
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlotGroup({
    required String emoji,
    required String label,
    required List<String> slots,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: slots.map((slot) {
            final isSelected = _selectedSlot == slot;
            return GestureDetector(
              onTap: () => setState(() => _selectedSlot = slot),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF2563EB)
                        : const Color(0xFF1E293B),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── 3. Prefer a Top-Rated Technician? ─────────────────────────────────────

  Widget _buildTopRatedTechnicianSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '3. Prefer a Top-Rated Technician? (Optional)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF93C5FD), width: 1.2),
          ),
          child: Row(
            children: [
              // Technician Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.full),
                child: Image.asset(
                  AppAssets.technicianRohit,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => Image.asset(
                    AppAssets.technicianAvatar,
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (_, e2, s2) => Container(
                      width: 46,
                      height: 46,
                      color: const Color(0xFFEFF6FF),
                      child: const Icon(Icons.person, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Rohit Kumar',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Top Rated',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF15803D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Icon(Icons.star_rounded, size: 13, color: Color(0xFFF59E0B)),
                        SizedBox(width: 2),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD97706),
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          '(450+ verified jobs)',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      '8 Years Certified Experience',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              // Request Button / Checkbox
              InkWell(
                onTap: () {
                  setState(() {
                    _requestTopRatedTechnician = !_requestTopRatedTechnician;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: _requestTopRatedTechnician
                        ? const Color(0xFFEFF6FF)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _requestTopRatedTechnician
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _requestTopRatedTechnician
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 16,
                        color: _requestTopRatedTechnician
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Request This\nTechnician',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: _requestTopRatedTechnician
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFF475569),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Booking Summary Card ──────────────────────────────────────────────────

  Widget _buildBookingSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 18,
                color: Color(0xFF2563EB),
              ),
              SizedBox(width: 8),
              Text(
                'Booking Summary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Service Item Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.settings_rounded,
                  size: 18,
                  color: Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.serviceTitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${widget.parentCategory} • Doorstep Visit',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Details Table
          _buildSummaryLine(
            'Selected Date',
            _dates[_selectedDateIndex]['full']!,
          ),
          const SizedBox(height: 6),
          _buildSummaryLine('Time Slot', _selectedSlot),
          const SizedBox(height: 6),
          _buildSummaryLine(
            'Inspection / Visit Charge',
            'FREE',
            isGreen: true,
          ),
          const SizedBox(height: 6),
          _buildSummaryLine('Estimated Service Base', '₹${widget.basePrice}'),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Color(0xFFE2E8F0)),
          ),

          // Estimated Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estimated Total',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '₹${widget.basePrice}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Free inspection banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 13,
                  color: Color(0xFF16A34A),
                ),
                SizedBox(width: 5),
                Text(
                  'Free inspection included with visit',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF15803D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryLine(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isGreen ? const Color(0xFF16A34A) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ── What's Included Box ───────────────────────────────────────────────────

  Widget _buildWhatsIncludedBox() {
    const included = [
      'Home inspection & diagnosis',
      'Expert repair & installation',
      'Up to 30 days service warranty',
      'On-time service',
      'No hidden charges',
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: Color(0xFF2563EB),
              ),
              SizedBox(width: 6),
              Text(
                "What's Included",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...included.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: Color(0xFF2563EB),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF334155),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Sticky Bottom Action Bar ──────────────────────────────────────────────

  Widget _buildStickyBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: _showBookingConfirmedDialog,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to Confirm & Pay',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 12,
                color: Color(0xFFD97706),
              ),
              SizedBox(width: 4),
              Text(
                'No upfront advance needed. Pay upon completion.',
                style: TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Private Helper Widgets ────────────────────────────────────────────────────

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF2563EB)),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
            height: 1.15,
          ),
        ),
      ],
    );
  }
}
