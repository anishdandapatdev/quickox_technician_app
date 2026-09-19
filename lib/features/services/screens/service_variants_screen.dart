import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Screen displaying granular service variants and packages for a selected sub-service
/// in the exact same horizontal card format with top back navigation.
class ServiceVariantsScreen extends StatefulWidget {
  const ServiceVariantsScreen({
    super.key,
    required this.serviceTitle,
    this.serviceSubtitle,
    this.parentCategory = 'Home Service',
  });

  final String serviceTitle;
  final String? serviceSubtitle;
  final String parentCategory;

  @override
  State<ServiceVariantsScreen> createState() => _ServiceVariantsScreenState();
}

class _ServiceVariantsScreenState extends State<ServiceVariantsScreen> {
  List<_VariantItem> _getVariantsForService() {
    final title = widget.serviceTitle.toLowerCase();

    // ── 1. AC Service & Repair ───────────────────────────────────────────────
    if (title.contains('ac') || title.contains('air conditioner')) {
      return const [
        _VariantItem(
          title: '1x Split AC Jet Wash & Sanitization',
          description:
              'Indoor high-pressure jet wash, outdoor condenser cleaning, filter wash, cooling coil sanitization',
          imageUrl:
              'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Best Seller',
          badgeType: _BadgeType.liveNow,
          tags: ['₹599', '45 Mins', '30-Day Warranty'],
          fallbackIcon: Icons.ac_unit_rounded,
          priceAmount: 599,
          priceDisplay: '₹599',
        ),
        _VariantItem(
          title: '2x Split AC Jet Wash Saver Combo',
          description:
              'Complete jet foam cleaning for 2 indoor & outdoor split units with gas pressure inspection',
          imageUrl:
              'https://images.unsplash.com/photo-1585338107529-13afc5f02586?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Save ₹100',
          badgeType: _BadgeType.liveNow,
          tags: ['₹1,099', '75 Mins', 'Combo Deal'],
          fallbackIcon: Icons.ac_unit_rounded,
          priceAmount: 1099,
          priceDisplay: '₹1,099',
        ),
        _VariantItem(
          title: 'Window AC Deep Clean Wash',
          description:
              'Complete front panel removal, cooling fins jet wash, drain tray unclogging, blower lubrication',
          imageUrl:
              'https://images.unsplash.com/photo-1545259741-2ea3ebf61fa3?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹499', '40 Mins', '30-Day Warranty'],
          fallbackIcon: Icons.window_rounded,
          priceAmount: 499,
          priceDisplay: '₹499',
        ),
        _VariantItem(
          title: 'AC Gas Leak Repair & Complete Refill',
          description:
              'Nitrogen pressure testing, brazing leak repair, complete vacuuming & pure R32/R410A gas charge',
          imageUrl:
              'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹1,499', '60 Mins', '60-Day Warranty'],
          fallbackIcon: Icons.propane_tank_rounded,
          priceAmount: 1499,
          priceDisplay: '₹1,499',
        ),
        _VariantItem(
          title: 'AC Installation / Uninstallation',
          description:
              'Professional bracket mounting, copper piping connection, vibration-free setup, safe dismantling',
          imageUrl:
              'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹699', '60 Mins', 'Expert Fitting'],
          fallbackIcon: Icons.build_rounded,
          priceAmount: 699,
          priceDisplay: '₹699',
        ),
        _VariantItem(
          title: '21-Point AC Diagnostic & Inspection',
          description:
              'Comprehensive electrical, compressor current, cooling efficiency, thermostat & gas check',
          imageUrl:
              'https://images.unsplash.com/photo-1581092335397-9583fe92d232?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹199', 'Adjusted in Bill', '30 Mins'],
          fallbackIcon: Icons.checklist_rounded,
          priceAmount: 199,
          priceDisplay: '₹199',
        ),
      ];
    }

    // ── 2. Electrical & Wiring ───────────────────────────────────────────────
    if (title.contains('electric') ||
        title.contains('switch') ||
        title.contains('wiring')) {
      return const [
        _VariantItem(
          title: 'Switch & Socket Replacement (Up to 3)',
          description:
              'Replacement of broken or spark switches, 6A/16A power socket installation with earthing test',
          imageUrl:
              'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹149', '25 Mins', 'Certified Electrician'],
          fallbackIcon: Icons.power_rounded,
          priceAmount: 149,
          priceDisplay: '₹149',
        ),
        _VariantItem(
          title: 'Ceiling Fan Installation & Repair',
          description:
              'New fan unboxing and installation, capacitor replacement, bearing noise fix, regulator tuning',
          imageUrl:
              'https://images.unsplash.com/photo-1541123437800-1bb1317badc2?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹199', '30 Mins', 'No Noise Guarantee'],
          fallbackIcon: Icons.mode_fan_off_rounded,
          priceAmount: 199,
          priceDisplay: '₹199',
        ),
        _VariantItem(
          title: 'MCB / Fuse Box Short Circuit Fix',
          description:
              'Trip investigation, main distribution board short circuit diagnosis, faulty MCB switch replacement',
          imageUrl:
              'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹299', '40 Mins', 'Safety Tested'],
          fallbackIcon: Icons.bolt_rounded,
          priceAmount: 299,
          priceDisplay: '₹299',
        ),
        _VariantItem(
          title: 'Inverter & Battery Wiring Setup',
          description:
              'Complete home inverter line setup, battery terminal connection, heavy copper wire fitting',
          imageUrl:
              'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹499', '60 Mins', 'Heavy Duty'],
          fallbackIcon: Icons.battery_charging_full_rounded,
          priceAmount: 499,
          priceDisplay: '₹499',
        ),
        _VariantItem(
          title: 'Concealed Room Rewiring (Per Room)',
          description:
              'Wall casing pipe installation, copper fire-resistant wire routing, new switchboard connection',
          imageUrl:
              'https://images.unsplash.com/photo-1517581177682-a085bb7ffb15?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹899', '2 Hours', 'Wire Included'],
          fallbackIcon: Icons.cable_rounded,
          priceAmount: 899,
          priceDisplay: '₹899',
        ),
      ];
    }

    // ── 3. Plumbing & Water ──────────────────────────────────────────────────
    if (title.contains('plumb') ||
        title.contains('leak') ||
        title.contains('pipe')) {
      return const [
        _VariantItem(
          title: 'Tap & Mixer Repair / Cartridge Change',
          description:
              'Dripping tap fix, ceramic disc spindle replacement, brass spindle tightening, leak-free test',
          imageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹149', '25 Mins', 'Leak-Free Guarantee'],
          fallbackIcon: Icons.water_drop_rounded,
          priceAmount: 149,
          priceDisplay: '₹149',
        ),
        _VariantItem(
          title: 'Wash Basin & Sink Clog Removal',
          description:
              'Mechanical snake drain cleaning, P-trap disassembly, food & hair blockage clearance, sanitization',
          imageUrl:
              'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹199', '30 Mins', 'Chemical Free'],
          fallbackIcon: Icons.wash_rounded,
          priceAmount: 199,
          priceDisplay: '₹199',
        ),
        _VariantItem(
          title: 'Toilet Jet Spray & Flush Tank Repair',
          description:
              'Health faucet replacement, siphon ball valve fix, water overflow control, tank gasket sealing',
          imageUrl:
              'https://images.unsplash.com/photo-1585338107529-13afc5f02586?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹249', '35 Mins', 'Verified Plumber'],
          fallbackIcon: Icons.plumbing_rounded,
          priceAmount: 249,
          priceDisplay: '₹249',
        ),
        _VariantItem(
          title: 'Concealed Pipe Leakage Detection',
          description:
              'Non-invasive acoustic leak detection for internal walls and underfloor concealed plumbing lines',
          imageUrl:
              'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹399', '45 Mins', 'Acoustic Sensor'],
          fallbackIcon: Icons.search_rounded,
          priceAmount: 399,
          priceDisplay: '₹399',
        ),
        _VariantItem(
          title: 'Overhead Water Tank Deep Cleaning',
          description:
              'High-pressure mud slurry removal, anti-bacterial UV treatment, sludge pumping up to 1000L tank',
          imageUrl:
              'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹799', '60 Mins', 'UV Sanitized'],
          fallbackIcon: Icons.cleaning_services_rounded,
          priceAmount: 799,
          priceDisplay: '₹799',
        ),
      ];
    }

    // ── 4. RO Water Purifier ─────────────────────────────────────────────────
    if (title.contains('ro') || title.contains('purifier')) {
      return const [
        _VariantItem(
          title: 'RO Complete Filter Replacement',
          description:
              'Replacement of sediment filter, pre-carbon block, post-carbon filter, and connector tubes',
          imageUrl:
              'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Best Seller',
          badgeType: _BadgeType.liveNow,
          tags: ['₹499', '40 Mins', '100% Genuine'],
          fallbackIcon: Icons.water_damage_rounded,
          priceAmount: 499,
          priceDisplay: '₹499',
        ),
        _VariantItem(
          title: 'RO Membrane Replacement & TDS Tuning',
          description:
              'High-TDS thin film composite membrane installation, mineral cartridge add-on, TDS level adjustment',
          imageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹899', '50 Mins', 'TDS < 100 Assured'],
          fallbackIcon: Icons.science_rounded,
          priceAmount: 899,
          priceDisplay: '₹899',
        ),
        _VariantItem(
          title: 'RO Booster Pump & Adapter Fix',
          description:
              'Pump low-pressure diagnosis, power SMPS adapter replacement, water flow restoration',
          imageUrl:
              'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹349', '35 Mins', '30-Day Warranty'],
          fallbackIcon: Icons.electric_bolt_rounded,
          priceAmount: 349,
          priceDisplay: '₹349',
        ),
      ];
    }

    // ── 5. Washing Machine & Appliance ───────────────────────────────────────
    if (title.contains('wash') || title.contains('machine')) {
      return const [
        _VariantItem(
          title: 'Washing Machine Inspection & Diagnostic',
          description:
              'Complete mechanical, belt, motor, water inlet, spin drum & PCB electronic diagnostic check',
          imageUrl:
              'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹199', '30 Mins', 'Adjusted in Repair'],
          fallbackIcon: Icons.local_laundry_service_rounded,
          priceAmount: 199,
          priceDisplay: '₹199',
        ),
        _VariantItem(
          title: 'Drum Vibration & Suspension Spring Fix',
          description:
              'Replacement of worn damper rods, balance ring calibration, spin noise reduction, leveling',
          imageUrl:
              'https://images.unsplash.com/photo-1585338107529-13afc5f02586?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹399', '45 Mins', 'Genuine Spares'],
          fallbackIcon: Icons.build_rounded,
          priceAmount: 399,
          priceDisplay: '₹399',
        ),
        _VariantItem(
          title: 'Water Drain & Inlet Motor Replacement',
          description:
              'Solenoid valve replacement, drain pump unclogging, error code E1/OE clearance',
          imageUrl:
              'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹449', '45 Mins', '30-Day Warranty'],
          fallbackIcon: Icons.water_drop_rounded,
          priceAmount: 449,
          priceDisplay: '₹449',
        ),
        _VariantItem(
          title: 'Motherboard (PCB) Circuit Board Repair',
          description:
              'Microcontroller testing, relay switch replacement, power surge fix with 90-day guarantee',
          imageUrl:
              'https://images.unsplash.com/photo-1517581177682-a085bb7ffb15?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹799', '60 Mins', '90-Day Warranty'],
          fallbackIcon: Icons.memory_rounded,
          priceAmount: 799,
          priceDisplay: '₹799',
        ),
      ];
    }

    // ── 6. Geyser & Water Heater ─────────────────────────────────────────────
    if (title.contains('geyser') || title.contains('heater')) {
      return const [
        _VariantItem(
          title: 'Geyser Heating Coil & Thermostat Change',
          description:
              'Copper heating element replacement, dual thermostat safety calibration, earthing test',
          imageUrl:
              'https://images.unsplash.com/photo-1585338107529-13afc5f02586?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹349', '40 Mins', 'Shock-Proof'],
          fallbackIcon: Icons.electric_bolt_rounded,
          priceAmount: 349,
          priceDisplay: '₹349',
        ),
        _VariantItem(
          title: 'Geyser Tank Descaling & Leakage Repair',
          description:
              'Complete tank sediment flush, magnesium anode replacement, gasket seal tightening',
          imageUrl:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹399', '45 Mins', 'Anti-Corrosion'],
          fallbackIcon: Icons.cleaning_services_rounded,
          priceAmount: 399,
          priceDisplay: '₹399',
        ),
      ];
    }

    // ── 7. Food Delivery & Tiffin ────────────────────────────────────────────
    if (title.contains('food') ||
        title.contains('tiffin') ||
        title.contains('meal')) {
      return const [
        _VariantItem(
          title: 'Standard Veg Daily Lunch Tiffin',
          description:
              '4 Wheat Rotis, 1 Seasonal Sabzi, Yellow Dal Tadka, Jeera Basmati Rice, Fresh Salad & Pickle',
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹120 / meal', 'Pure Veg', 'Hot Delivery'],
          fallbackIcon: Icons.restaurant_rounded,
          priceAmount: 120,
          priceDisplay: '₹120',
        ),
        _VariantItem(
          title: 'Deluxe Non-Veg Tiffin (Chicken / Fish)',
          description:
              'Homestyle Chicken Curry or Fish Kalia, 4 Rotis, Steamed Rice, Dal, Crunchy Salad',
          imageUrl:
              'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Popular',
          badgeType: _BadgeType.liveNow,
          tags: ['₹160 / meal', 'Fresh Meat', 'Chef Curated'],
          fallbackIcon: Icons.lunch_dining_rounded,
          priceAmount: 160,
          priceDisplay: '₹160',
        ),
        _VariantItem(
          title: 'Monthly 30-Day Tiffin Subscription',
          description:
              '60 hot home-cooked meals (Lunch + Dinner) with free delivery and weekend dessert surprise',
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Save ₹600',
          badgeType: _BadgeType.liveNow,
          tags: ['₹3,200 / mo', '60 Meals', 'Free Delivery'],
          fallbackIcon: Icons.calendar_today_rounded,
          priceAmount: 3200,
          priceDisplay: '₹3,200',
        ),
        _VariantItem(
          title: 'Student Budget Mini Tiffin',
          description:
              '3 Tawa Rotis, Daily Sabzi, Thick Dal, Onion & Green Chilly. Pocket-friendly & nutritious',
          imageUrl:
              'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Budget Friendly',
          badgeType: _BadgeType.liveNow,
          tags: ['₹89 / meal', 'Homely Taste', 'Fast Dispatch'],
          fallbackIcon: Icons.fastfood_rounded,
          priceAmount: 89,
          priceDisplay: '₹89',
        ),
      ];
    }

    // ── 8. Bike & Cab Service ────────────────────────────────────────────────
    if (title.contains('bike') ||
        title.contains('cab') ||
        title.contains('auto')) {
      return const [
        _VariantItem(
          title: 'Standard 100cc-150cc Doorstep Bike Service',
          description:
              'Engine oil change, carburetor cleaning, spark plug check, brake pad tuning, chain lube & wash',
          imageUrl:
              'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹399', '45 Mins', '15-Point Check'],
          fallbackIcon: Icons.two_wheeler_rounded,
          priceAmount: 399,
          priceDisplay: '₹399',
        ),
        _VariantItem(
          title: 'Royal Enfield & 200cc+ Cruiser Service',
          description:
              'Castrol semi-synthetic oil, clutch play adjustment, disc brake fluid bleed, air filter clean',
          imageUrl:
              'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹599', '60 Mins', 'Synthetic Oil'],
          fallbackIcon: Icons.motorcycle_rounded,
          priceAmount: 599,
          priceDisplay: '₹599',
        ),
        _VariantItem(
          title: 'Quickox Mini Cab (AC Hatchback)',
          description:
              'Instant doorstep cab dispatch, 4-seater AC hatchback with live GPS tracking and verified driver',
          imageUrl:
              'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹149 Base', 'Zero Surge', 'Fast Arrival'],
          fallbackIcon: Icons.local_taxi_rounded,
          priceAmount: 149,
          priceDisplay: '₹149',
        ),
        _VariantItem(
          title: 'Outstation Inter-District Round Trip',
          description:
              'Dedicated AC sedan with commercial tourist permit, polite chauffeur, flexible stops',
          imageUrl:
              'https://images.unsplash.com/photo-1502877338535-766e1452684a?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['₹12 / km', 'Chauffeur', '24/7 Available'],
          fallbackIcon: Icons.directions_car_filled_rounded,
          priceAmount: 12,
          priceDisplay: '₹12/km',
        ),
      ];
    }

    // ── 9. Emergency Ambulance ───────────────────────────────────────────────
    if (title.contains('ambulance') ||
        title.contains('icu') ||
        title.contains('emergency')) {
      return const [
        _VariantItem(
          title: 'City Emergency BLS Ambulance',
          description:
              'Immediate 15-minute dispatch, 24/7 oxygen cylinder, foldaway stretcher, trained paramedic onboard',
          imageUrl:
              'https://images.unsplash.com/photo-1587745416684-47953f16f02f?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['15 Mins ETA', 'Oxygen Ready', 'Trained Paramedic'],
          fallbackIcon: Icons.emergency_rounded,
          priceAmount: 499,
          priceDisplay: 'Priority SOS',
        ),
        _VariantItem(
          title: 'Critical ICU on Wheels (ALS)',
          description:
              'Ventilator, multi-para monitor, defibrillator, emergency suction unit, emergency doctor onboard',
          imageUrl:
              'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['ICU Setup', 'Doctor Onboard', 'Priority Corridor'],
          fallbackIcon: Icons.local_hospital_rounded,
          priceAmount: 1499,
          priceDisplay: 'Priority Call',
        ),
      ];
    }

    // ── 10. Medicine Delivery ────────────────────────────────────────────────
    if (title.contains('medicine') ||
        title.contains('pharma') ||
        title.contains('health')) {
      return const [
        _VariantItem(
          title: 'Prescription Medicine Order (Flat 20% Off)',
          description:
              'Upload doctor prescription, verified pharmacist review, 2-hour doorstep delivery with bill',
          imageUrl:
              'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['Flat 20% Off', '2 Hours Delivery', 'Verified Pharmacy'],
          fallbackIcon: Icons.medication_rounded,
          priceAmount: 0,
          priceDisplay: 'Flat 20% Off',
        ),
        _VariantItem(
          title: 'Monthly Chronic Medicine Refill Box',
          description:
              'BP, Diabetes, Thyroid monthly packs delivered automatically on your chosen date with flat 22% off',
          imageUrl:
              'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Live Now',
          badgeType: _BadgeType.liveNow,
          tags: ['Flat 22% Off', 'Auto-Refill', 'Free Delivery'],
          fallbackIcon: Icons.health_and_safety_rounded,
          priceAmount: 0,
          priceDisplay: 'Flat 22% Off',
        ),
      ];
    }

    // ── 11. Room Booking ─────────────────────────────────────────────────────
    if (title.contains('room') ||
        title.contains('hotel') ||
        title.contains('pg')) {
      return const [
        _VariantItem(
          title: 'Single Furnished AC Room in Executive PG',
          description:
              'Attached bath, high-speed WiFi, 3 meals included, daily housekeeping, 24/7 power backup',
          imageUrl:
              'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['₹6,500 / mo', 'Zero Brokerage', 'WiFi + Food'],
          fallbackIcon: Icons.hotel_rounded,
          priceAmount: 6500,
          priceDisplay: '₹6,500/mo',
        ),
        _VariantItem(
          title: 'Budget & Premium Hotel Day Stay',
          description:
              'AC room, LED TV, fresh linen, sanitized bathroom, instant check-in, couple friendly',
          imageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['₹999 / night', 'Couple Friendly', 'Clean Rooms'],
          fallbackIcon: Icons.king_bed_rounded,
          priceAmount: 999,
          priceDisplay: '₹999/night',
        ),
      ];
    }

    // ── 12. Event & Decoration ───────────────────────────────────────────────
    if (title.contains('event') ||
        title.contains('birthday') ||
        title.contains('catering')) {
      return const [
        _VariantItem(
          title: 'Birthday Theme Balloon Arch & Fairy Lights',
          description:
              '200+ metallic balloons arch, happy birthday neon LED sign, fairy lights backdrop, cake table decor',
          imageUrl:
              'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['₹1,999', 'Complete Setup', '2 Hours'],
          fallbackIcon: Icons.celebration_rounded,
          priceAmount: 1999,
          priceDisplay: '₹1,999',
        ),
        _VariantItem(
          title: 'Wedding & Rice Ceremony Buffet Catering',
          description:
              'Authentic Bengali & North Indian feast with 12 items, trained uniform staff, hot live counters',
          imageUrl:
              'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['₹450 / plate', 'Hygiene Assured', 'Trained Staff'],
          fallbackIcon: Icons.dinner_dining_rounded,
          priceAmount: 450,
          priceDisplay: '₹450/plate',
        ),
      ];
    }

    // ── 13. QUICKOX ELECTRA Scooty ───────────────────────────────────────────
    if (title.contains('electra') ||
        title.contains('scooty') ||
        title.contains('ev')) {
      return const [
        _VariantItem(
          title: 'QUICKOX ELECTRA Pro Test Ride (120 KM Range)',
          description:
              'Free doorstep test ride with product specialist explanation, test drive on your local roads',
          imageUrl:
              'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['Free Test Ride', 'Doorstep', '120 KM Range'],
          fallbackIcon: Icons.electric_moped_rounded,
          priceAmount: 0,
          priceDisplay: 'Free',
        ),
        _VariantItem(
          title: 'EV Battery Diagnostic & Controller Tuning',
          description:
              'Cell balance health checkup, regenerative braking calibration, wiring harness inspection',
          imageUrl:
              'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=600&q=80',
          badgeText: 'Coming Soon',
          badgeType: _BadgeType.comingSoon,
          tags: ['₹299', 'Certified EV Tech', 'Quick Fix'],
          fallbackIcon: Icons.battery_charging_full_rounded,
          priceAmount: 299,
          priceDisplay: '₹299',
        ),
      ];
    }

    // ── Fallback General Items ───────────────────────────────────────────────
    return [
      _VariantItem(
        title: '${widget.serviceTitle} Standard Service',
        description:
            'Complete certified inspection, repair and doorstep assistance by verified professionals.',
        imageUrl:
            'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=600&q=80',
        badgeText: 'Live Now',
        badgeType: _BadgeType.liveNow,
        tags: ['₹299', '45 Mins', '30-Day Warranty'],
        fallbackIcon: Icons.home_repair_service_rounded,
        priceAmount: 299,
        priceDisplay: '₹299',
      ),
      _VariantItem(
        title: '${widget.serviceTitle} Premium Package',
        description:
            'Comprehensive deep servicing with genuine spare parts coverage and 60-day warranty.',
        imageUrl:
            'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=600&q=80',
        badgeText: 'Live Now',
        badgeType: _BadgeType.liveNow,
        tags: ['₹599', '60 Mins', '60-Day Warranty'],
        fallbackIcon: Icons.verified_user_rounded,
        priceAmount: 599,
        priceDisplay: '₹599',
      ),
    ];
  }

  void _showBookingSheet(BuildContext context, _VariantItem item) {
    if (item.badgeType == _BadgeType.comingSoon) {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.bgPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF3C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time_rounded,
                  color: Color(0xFFD97706),
                  size: 36,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Coming Soon!',
                style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${item.title} will be live in your zone soon. Quickox Care members receive priority notification!',
                style: AppTextStyles.bodyMd,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("You'll be notified as soon as this goes live!"),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  child: const Text(
                    'Notify Me When Available',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    // Live Now: Show Interactive Booking Bottom Sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => _ServiceBookingBottomSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final variants = _getVariantsForService();

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
                            widget.serviceTitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h3.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.serviceSubtitle ??
                                'Choose a service package below with transparent pricing and warranty.',
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

            // ── Horizontal Cards List (Exact Same Format) ───────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: variants.length,
                separatorBuilder: (_, i) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final item = variants[index];
                  return GestureDetector(
                    onTap: () => _showBookingSheet(context, item),
                    child: _VariantHorizontalCard(item: item),
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

enum _BadgeType { liveNow, comingSoon }

class _VariantItem {
  const _VariantItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.badgeText,
    required this.badgeType,
    required this.tags,
    required this.fallbackIcon,
    required this.priceAmount,
    required this.priceDisplay,
  });

  final String title;
  final String description;
  final String imageUrl;
  final String? badgeText;
  final _BadgeType badgeType;
  final List<String> tags;
  final IconData fallbackIcon;
  final int priceAmount;
  final String priceDisplay;
}

class _VariantHorizontalCard extends StatelessWidget {
  const _VariantHorizontalCard({required this.item});

  final _VariantItem item;

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

                // Pill Badge overlay (top-left)
                if (item.badgeText != null)
                  Positioned(
                    top: 7,
                    left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: item.badgeType == _BadgeType.liveNow
                            ? const Color(0xFF16A34A)
                            : const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.badgeText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Right: Content ────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row: Title + Circular Arrow Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelLg.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      height: 1.25,
                    ),
                  ),

                  // Bottom Tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: item.tags.take(3).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border.all(
                            color: const Color(0xFFDBEAFE),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
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

// ── Interactive Booking Bottom Sheet ──────────────────────────────────────────

class _ServiceBookingBottomSheet extends StatefulWidget {
  const _ServiceBookingBottomSheet({required this.item});

  final _VariantItem item;

  @override
  State<_ServiceBookingBottomSheet> createState() =>
      _ServiceBookingBottomSheetState();
}

class _ServiceBookingBottomSheetState
    extends State<_ServiceBookingBottomSheet> {
  int _selectedDateIndex = 0;
  int _selectedSlotIndex = 1;
  bool _includeProtectionPlan = true;
  bool _includeSanitization = false;

  final List<Map<String, String>> _dates = [
    {'day': 'Today', 'date': '19 Sep'},
    {'day': 'Tomorrow', 'date': '20 Sep'},
    {'day': 'Monday', 'date': '21 Sep'},
    {'day': 'Tuesday', 'date': '22 Sep'},
  ];

  final List<String> _timeSlots = [
    '09:00 AM - 12:00 PM',
    '12:00 PM - 03:00 PM',
    '03:00 PM - 06:00 PM',
    '06:00 PM - 09:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final basePrice = widget.item.priceAmount;
    final protectionPrice = _includeProtectionPlan ? 49 : 0;
    final sanitizationPrice = _includeSanitization ? 99 : 0;
    final discount = (basePrice > 0) ? 50 : 0;
    final totalPrice = (basePrice + protectionPrice + sanitizationPrice - discount)
        .clamp(0, 999999);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
          ),

          // Header: Title & Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: AppTextStyles.h3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.item.priceDisplay,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.sm),

                  // ── Select Date ───────────────────────────────────────────
                  Text(
                    'Select Service Date',
                    style: AppTextStyles.labelMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: List.generate(_dates.length, (index) {
                      final isSelected = _selectedDateIndex == index;
                      final d = _dates[index];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedDateIndex = index),
                          child: Container(
                            margin: EdgeInsets.only(
                              right: index < _dates.length - 1 ? 8 : 0,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.bgSecondary,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  d['day']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  d['date']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Select Time Slot ──────────────────────────────────────
                  Text(
                    'Select Time Slot',
                    style: AppTextStyles.labelMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(_timeSlots.length, (index) {
                      final isSelected = _selectedSlotIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSlotIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.bgSecondary,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _timeSlots[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Add-on Options ────────────────────────────────────────
                  Text(
                    'Optional Add-ons',
                    style: AppTextStyles.labelMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgSecondary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          value: _includeProtectionPlan,
                          onChanged: (v) =>
                              setState(() => _includeProtectionPlan = v ?? false),
                          title: const Text(
                            'Quickox 30-Day Damage Protection',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: const Text(
                            'Covers up to ₹10,000 for any accidental damages during service',
                            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          secondary: const Text(
                            '+₹49',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          activeColor: AppColors.primary,
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        CheckboxListTile(
                          value: _includeSanitization,
                          onChanged: (v) =>
                              setState(() => _includeSanitization = v ?? false),
                          title: const Text(
                            'Complete Post-Service Sanitization',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: const Text(
                            'Disinfectant spray on all touched surfaces & appliances',
                            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          secondary: const Text(
                            '+₹99',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Price Summary ─────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Item Total',
                          basePrice > 0 ? '₹$basePrice' : widget.item.priceDisplay,
                        ),
                        if (_includeProtectionPlan) ...[
                          const SizedBox(height: 6),
                          _buildSummaryRow('Damage Protection', '₹49'),
                        ],
                        if (_includeSanitization) ...[
                          const SizedBox(height: 6),
                          _buildSummaryRow('Post-Service Sanitization', '₹99'),
                        ],
                        if (discount > 0) ...[
                          const SizedBox(height: 6),
                          _buildSummaryRow(
                            'Quickox First Booking Offer',
                            '-₹50',
                            isDiscount: true,
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(color: Color(0xFFE2E8F0), height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Payable',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              basePrice > 0
                                  ? '₹$totalPrice'
                                  : widget.item.priceDisplay,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),

          // Confirm Booking Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showBookingSuccessDialog(context, widget.item);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      basePrice > 0
                          ? 'Schedule Service • ₹$totalPrice'
                          : 'Confirm Booking Request',
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDiscount ? const Color(0xFF16A34A) : AppColors.textSecondary,
            fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: isDiscount ? const Color(0xFF16A34A) : AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  void _showBookingSuccessDialog(BuildContext context, _VariantItem item) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        contentPadding: const EdgeInsets.all(AppSpacing.xl),
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
                size: 48,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Booking Confirmed!',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Your request for "${item.title}" has been successfully scheduled. A verified technician will arrive at your selected time.',
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                onPressed: () => Navigator.pop(dialogCtx),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
