import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Super App Service Vertical Model matching explore_service.jsx & multiServiceData.js
class ServiceVerticalItem {
  final String id;
  final String name;
  final String tagline;
  final String badgeText;
  final bool isLive;
  final String imageUrl;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final List<String> tags;

  const ServiceVerticalItem({
    required this.id,
    required this.name,
    required this.tagline,
    required this.badgeText,
    this.isLive = true,
    required this.imageUrl,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.tags = const [],
  });
}

/// Model representing a Dynamic Service matching Firestore and explore_service.jsx
class ServiceItem {
  final String id;
  final String title;
  final String desc;
  final String category;
  final String categoryId;
  final String price;
  final String? originalPrice;
  final String rating;
  final String frequency;
  final String imageUrl;
  final String tag;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.category,
    required this.categoryId,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.frequency,
    required this.imageUrl,
    this.tag = 'Popular',
  });

  ServiceItem copyWith({
    String? id,
    String? title,
    String? desc,
    String? category,
    String? categoryId,
    String? price,
    String? originalPrice,
    String? rating,
    String? frequency,
    String? imageUrl,
    String? tag,
  }) {
    return ServiceItem(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      frequency: frequency ?? this.frequency,
      imageUrl: imageUrl ?? this.imageUrl,
      tag: tag ?? this.tag,
    );
  }
}

/// Firebase Service connecting to the 'home-service-haldia' Firestore collections:
/// - 'services'
/// - 'serviceCategories'
/// - 'medicine_categories'
/// Mirrors home_service_web/src/features/services/explore_service.jsx & multiServiceData.js.
class FirebaseServicesService {
  static const String projectId = 'home-service-haldia';
  static const String firestoreBaseUrl =
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents';

  final http.Client _client;

  FirebaseServicesService({http.Client? client})
      : _client = client ?? http.Client();

  /// Default 8 Super App Service Verticals matching explore_service.jsx & multiServiceData.js
  static const List<ServiceVerticalItem> defaultVerticals = [
    ServiceVerticalItem(
      id: 'home_care',
      name: 'Home Service',
      tagline: 'AC, Electrical, Plumbing, RO & Appliance Repairs',
      badgeText: 'Live Now',
      isLive: true,
      imageUrl: 'assets/images/ac.png',
      icon: Icons.home_repair_service_rounded,
      color: Color(0xFF2563EB),
      bgColor: Color(0xFFEFF6FF),
      tags: ['AC Jet Wash', 'Plumbing', 'Electrician'],
    ),
    ServiceVerticalItem(
      id: 'medicine_delivery',
      name: 'Medicine Delivery',
      tagline: 'Prescription Rx, Pain Relief, First Aid & Wellness',
      badgeText: 'Live Now',
      isLive: true,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&auto=format&fit=crop&q=80',
      icon: Icons.medication_rounded,
      color: Color(0xFF059669),
      bgColor: Color(0xFFECFDF5),
      tags: ['30-Min Delivery', 'Rx Upload', 'First Aid'],
    ),
    ServiceVerticalItem(
      id: 'food_delivery',
      name: 'Food Delivery',
      tagline: 'Tiffin, Home Cooked Meals & Cloud Kitchens',
      badgeText: 'Live Now',
      isLive: true,
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300&auto=format&fit=crop&q=80',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFEA580C),
      bgColor: Color(0xFFFFF7ED),
      tags: ['Home Food', 'Tiffin', 'Restaurants'],
    ),
    ServiceVerticalItem(
      id: 'bike_cab',
      name: 'Bike & Cab Service',
      tagline: 'Instant Affordable City Commute, Taxis & Autos',
      badgeText: 'From ₹25',
      isLive: true,
      imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=300&auto=format&fit=crop&q=80',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF0891B2),
      bgColor: Color(0xFFECFEFF),
      tags: ['Bike Taxi', 'Auto', 'Cab Mini'],
    ),
    ServiceVerticalItem(
      id: 'ambulance',
      name: 'Emergency Ambulance',
      tagline: '24/7 Rapid Medical Dispatch & ICU on Wheels',
      badgeText: 'SOS 24/7',
      isLive: true,
      imageUrl: 'https://images.unsplash.com/photo-1587745416684-47953f16f02f?w=300&auto=format&fit=crop&q=80',
      icon: Icons.medical_services_rounded,
      color: Color(0xFFDC2626),
      bgColor: Color(0xFFFEF2F2),
      tags: ['10-15 Min ETA', 'Oxygen & ICU', 'Paramedics'],
    ),
    ServiceVerticalItem(
      id: 'room_booking',
      name: 'Room Booking',
      tagline: 'Hotels, PG, Guest House & Student Rentals',
      badgeText: 'Coming Soon',
      isLive: false,
      imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=300&auto=format&fit=crop&q=80',
      icon: Icons.hotel_rounded,
      color: Color(0xFF7C3AED),
      bgColor: Color(0xFFF5F3FF),
      tags: ['Hotels', 'PG Stays', 'Guest House'],
    ),
    ServiceVerticalItem(
      id: 'electra_scooty',
      name: 'Electra Scooty',
      tagline: 'Smart Electric Scooters & Battery Swap Network',
      badgeText: 'Coming Soon',
      isLive: false,
      imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=300&auto=format&fit=crop&q=80',
      icon: Icons.electric_scooter_rounded,
      color: Color(0xFF0D9488),
      bgColor: Color(0xFFF0FDFA),
      tags: ['Eco Rides', 'Battery Swap', 'Smart EV'],
    ),
    ServiceVerticalItem(
      id: 'event_booking',
      name: 'Event Booking',
      tagline: 'Marriage, Birthday, Rice Ceremony & Mandap Decor',
      badgeText: 'Coming Soon',
      isLive: false,
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=300&auto=format&fit=crop&q=80',
      icon: Icons.celebration_rounded,
      color: Color(0xFF9333EA),
      bgColor: Color(0xFFFAF5FF),
      tags: ['Weddings', 'Catering', 'Floral Decor'],
    ),
  ];

  /// Fetches service verticals dynamically from Firebase backend with fallback
  Future<List<ServiceVerticalItem>> fetchVerticals() async {
    try {
      // Connect to Firestore serviceCategories and medicine_categories to verify backend stats
      final catUri = Uri.parse('$firestoreBaseUrl/serviceCategories?pageSize=20');
      final medUri = Uri.parse('$firestoreBaseUrl/medicine_categories?pageSize=20');

      final responses = await Future.wait([
        _client.get(catUri).timeout(const Duration(seconds: 4)).catchError((_) => http.Response('{}', 500)),
        _client.get(medUri).timeout(const Duration(seconds: 4)).catchError((_) => http.Response('{}', 500)),
      ]);

      int homeServiceCatCount = 0;
      int medicineCatCount = 0;

      if (responses[0].statusCode == 200) {
        final data = json.decode(responses[0].body) as Map<String, dynamic>;
        homeServiceCatCount = (data['documents'] as List<dynamic>?)?.length ?? 0;
      }

      if (responses[1].statusCode == 200) {
        final data = json.decode(responses[1].body) as Map<String, dynamic>;
        medicineCatCount = (data['documents'] as List<dynamic>?)?.length ?? 0;
      }

      return defaultVerticals.map((vert) {
        if (vert.id == 'home_care' && homeServiceCatCount > 0) {
          return ServiceVerticalItem(
            id: vert.id,
            name: vert.name,
            tagline: '$homeServiceCatCount+ Categories • 50+ Doorstep Services',
            badgeText: 'Live Now',
            isLive: true,
            imageUrl: vert.imageUrl,
            icon: vert.icon,
            color: vert.color,
            bgColor: vert.bgColor,
            tags: ['AC Jet Wash', 'Plumbing', 'Electrician'],
          );
        }
        if (vert.id == 'medicine_delivery' && medicineCatCount > 0) {
          return ServiceVerticalItem(
            id: vert.id,
            name: vert.name,
            tagline: '$medicineCatCount+ Categories • Express 30m Doorstep',
            badgeText: 'Live Now',
            isLive: true,
            imageUrl: vert.imageUrl,
            icon: vert.icon,
            color: vert.color,
            bgColor: vert.bgColor,
            tags: ['30-Min Delivery', 'Rx Upload', 'First Aid'],
          );
        }
        return vert;
      }).toList();
    } catch (e) {
      debugPrint('FirebaseServicesService: fetchVerticals error: $e');
      return defaultVerticals;
    }
  }

  /// Default 13 fallback services matching explore_service.jsx lines 75-219
  static const List<ServiceItem> defaultServices = [
    ServiceItem(
      id: '1',
      title: 'AC Deep Jet Cleaning & Servicing',
      desc:
          'Intense high-pressure jet pump cleaning of indoor cooling coils, filters, drainage tray, and outdoor unit.',
      category: 'AC',
      categoryId: 'AC',
      price: '₹ 499/-',
      originalPrice: '₹ 699/-',
      rating: '4.9',
      frequency: 'One-Time',
      imageUrl: 'assets/images/ac.png',
      tag: 'Best Seller',
    ),
    ServiceItem(
      id: '2',
      title: 'AC Gas Leakage Check & Refilling',
      desc:
          'Complete electronic leak testing, nitrogen pressure test, and 100% genuine refrigerant gas refill.',
      category: 'AC',
      categoryId: 'AC',
      price: '₹ 1,499/-',
      originalPrice: '₹ 1,899/-',
      rating: '4.8',
      frequency: 'One-Time',
      imageUrl: 'assets/images/ac.png',
      tag: 'Instant Visit',
    ),
    ServiceItem(
      id: '3',
      title: 'Switchboard & Socket Restoration',
      desc:
          'Fix loose wiring, burned socket modules, sparking master switches, and modular board installations.',
      category: 'Electrical',
      categoryId: 'Electrical',
      price: '₹ 199/-',
      originalPrice: '₹ 299/-',
      rating: '4.9',
      frequency: 'One-Time',
      imageUrl: 'assets/images/electrician.png',
      tag: 'Fast Booking',
    ),
    ServiceItem(
      id: '4',
      title: 'Water Purifier RO Filter & Membrane Replacement',
      desc:
          'Sediment pre-filter, carbon block, RO membrane replacement, and digital TDS mineral balancing.',
      category: 'RO',
      categoryId: 'RO',
      price: '₹ 649/-',
      originalPrice: '₹ 899/-',
      rating: '4.9',
      frequency: 'One-Time',
      imageUrl: 'assets/images/ro.png',
      tag: 'Top Rated',
    ),
    ServiceItem(
      id: '5',
      title: 'Complete Home Wiring Health Check',
      desc:
          'Earthing voltage testing, MCB distribution board load balance audit, and short-circuit prevention survey.',
      category: 'Electrical',
      categoryId: 'Electrical',
      price: '₹ 499/-',
      originalPrice: '₹ 699/-',
      rating: '4.8',
      frequency: 'One-Time',
      imageUrl: 'assets/images/electrician.png',
      tag: 'Safety First',
    ),
    ServiceItem(
      id: '6',
      title: 'Pipe Leakage & Tap Valve Repair',
      desc:
          'Under-sink pipe repair, angle valve replacements, leaking faucets, mixer cartridge fixes, and sealant renewal.',
      category: 'Plumbing',
      categoryId: 'Plumbing',
      price: '₹ 199/-',
      originalPrice: '₹ 299/-',
      rating: '4.9',
      frequency: 'One-Time',
      imageUrl: 'assets/images/plumbing.png',
      tag: 'Essential',
    ),
    ServiceItem(
      id: '7',
      title: 'Ceiling Fan Repair & Speed Regulator',
      desc:
          'Motor capacitor replacement, bearing noise lubrication, blade balancing, and electronic regulator fixes.',
      category: 'Ceiling Fan',
      categoryId: 'Ceiling Fan',
      price: '₹ 249/-',
      originalPrice: '₹ 349/-',
      rating: '4.7',
      frequency: 'One-Time',
      imageUrl: 'assets/images/products/fan_capacitor.jpg',
      tag: 'Recommended',
    ),
    ServiceItem(
      id: '8',
      title: 'Bathroom & Kitchen Drainage Clearing',
      desc:
          'High-pressure mechanized drain snake unblocking for sinks, shower drains, floor traps, and pipeline blockages.',
      category: 'Plumbing',
      categoryId: 'Plumbing',
      price: '₹ 399/-',
      originalPrice: '₹ 549/-',
      rating: '4.8',
      frequency: 'One-Time',
      imageUrl: 'assets/images/plumbing.png',
      tag: 'Quick Response',
    ),
    ServiceItem(
      id: '9',
      title: 'Water Pump Motor Troubleshooting & Rewinding',
      desc:
          'Submersible & monoblock pump capacitor replacement, motor impeller cleaning, and auto-cut switch setup.',
      category: 'Water Pump',
      categoryId: 'Water Pump',
      price: '₹ 499/-',
      originalPrice: '₹ 699/-',
      rating: '4.8',
      frequency: 'One-Time',
      imageUrl: 'assets/images/products/solar_junction_box.jpg',
      tag: 'Heavy Duty',
    ),
    ServiceItem(
      id: '10',
      title: 'Geyser Heating Element & Thermostat Check',
      desc:
          'Descaling geyser heating tank, heating rod replacement, thermostat safety cut-off test, and valve servicing.',
      category: 'Geyser',
      categoryId: 'Geyser',
      price: '₹ 449/-',
      originalPrice: '₹ 599/-',
      rating: '4.8',
      frequency: 'One-Time',
      imageUrl: 'assets/images/refrigerator_technician.jpg',
      tag: 'Winter Ready',
    ),
    ServiceItem(
      id: '11',
      title: 'Door Lock, Hinge & Furniture Carpentry',
      desc:
          'Smart door lock installation, mortise lock repair, kitchen drawer sliders, and cabinet hinge adjustments.',
      category: 'Carpentry',
      categoryId: 'Carpentry',
      price: '₹ 299/-',
      originalPrice: '₹ 449/-',
      rating: '4.7',
      frequency: 'One-Time',
      imageUrl: 'assets/images/products/cctv_camera_mount.jpg',
      tag: 'Expert Care',
    ),
    ServiceItem(
      id: '12',
      title: 'AC Monthly Annual Maintenance',
      desc:
          'Periodic preventative inspection, quarterly filter washes, thermostat calibration, and emergency callouts.',
      category: 'AC',
      categoryId: 'AC',
      price: '₹ 299/mo',
      originalPrice: '₹ 399/mo',
      rating: '4.9',
      frequency: 'Monthly',
      imageUrl: 'assets/images/ac.png',
      tag: 'Care Plan',
    ),
    ServiceItem(
      id: '13',
      title: 'RO Purifier Comprehensive Monthly Care',
      desc:
          'Monthly water quality test, scheduled filter replacement, UV lamp inspection, and pump pressure testing.',
      category: 'RO',
      categoryId: 'RO',
      price: '₹ 199/mo',
      originalPrice: '₹ 299/mo',
      rating: '4.8',
      frequency: 'Monthly',
      imageUrl: 'assets/images/ro.png',
      tag: 'Care Plan',
    ),
  ];

  /// Fetches services dynamically from Firestore collection 'services' with fallback.
  Future<List<ServiceItem>> fetchServices({int? limit}) async {
    try {
      final uri = Uri.parse('$firestoreBaseUrl/services?pageSize=50');
      final response = await _client.get(uri).timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? documents = data['documents'];

        if (documents != null && documents.isNotEmpty) {
          final List<ServiceItem> fetched = [];

          for (final doc in documents) {
            final fields = doc['fields'] as Map<String, dynamic>?;
            if (fields == null) continue;

            // Check isActive
            final bool isActive = _extractBool(fields['isActive'], true);
            if (!isActive) continue;

            final String docPath = doc['name'] as String? ?? '';
            final String id = docPath.split('/').last;

            final String title = _extractString(
              fields['title'] ?? fields['name'] ?? fields['serviceName'],
              fallback: 'Service',
            );

            final String desc = _extractString(
              fields['desc'] ?? fields['description'] ?? fields['shortDesc'],
              fallback: 'Professional doorstep service by verified technician.',
            );

            final String rawCategory = _extractString(
              fields['category'] ??
                  fields['categoryName'] ??
                  fields['categoryId'],
              fallback: 'General',
            );
            // Clean emoji prefix from category for cleaner tag display
            final String cleanCategory = _cleanCategoryName(rawCategory);

            final String rawPrice = _extractPrice(fields['price']);
            final String price = _normalizePrice(rawPrice, cleanCategory);

            final String rating = _extractString(
              fields['rating'],
              fallback: '4.8',
            );

            final String frequency = _extractString(
              fields['frequency'],
              fallback: 'One-Time',
            );

            final String rawImage = _extractString(
              fields['imageUrl'] ??
                  fields['image'] ??
                  fields['photo'] ??
                  fields['photoUrl'],
              fallback: '',
            );
            final String imageUrl = _resolveImageUrl(rawImage, cleanCategory);

            final String tag = _extractTag(fields['tags']);

            fetched.add(
              ServiceItem(
                id: id,
                title: title,
                desc: desc,
                category: cleanCategory,
                categoryId: cleanCategory.toLowerCase(),
                price: price,
                originalPrice: _computeOriginalPrice(price),
                rating: rating,
                frequency: frequency,
                imageUrl: imageUrl,
                tag: tag,
              ),
            );
          }

          if (fetched.isNotEmpty) {
            if (limit != null && limit > 0) {
              return fetched.take(limit).toList();
            }
            return fetched;
          }
        }
      }
    } catch (e) {
      debugPrint('FirebaseServicesService: fetchServices error: $e');
    }

    // Return fallback catalog if network fails or collection is empty
    if (limit != null && limit > 0) {
      return defaultServices.take(limit).toList();
    }
    return defaultServices;
  }

  // ──────────────────────────── Helpers ────────────────────────────

  static String _extractString(Map<String, dynamic>? field,
      {String fallback = ''}) {
    if (field == null) return fallback;
    if (field.containsKey('stringValue')) {
      final val = field['stringValue'] as String;
      return val.trim().isNotEmpty ? val.trim() : fallback;
    }
    if (field.containsKey('integerValue')) {
      return field['integerValue'].toString();
    }
    if (field.containsKey('doubleValue')) {
      return field['doubleValue'].toString();
    }
    return fallback;
  }

  static bool _extractBool(Map<String, dynamic>? field, bool fallback) {
    if (field == null) return fallback;
    if (field.containsKey('booleanValue')) {
      return field['booleanValue'] as bool;
    }
    return fallback;
  }

  static String _extractPrice(Map<String, dynamic>? field) {
    if (field == null) return '';
    if (field.containsKey('stringValue')) {
      return (field['stringValue'] as String).trim();
    }
    if (field.containsKey('integerValue')) {
      return field['integerValue'].toString();
    }
    if (field.containsKey('doubleValue')) {
      return field['doubleValue'].toString();
    }
    return '';
  }

  static String _cleanCategoryName(String raw) {
    // Strips emojis, variation selectors, and symbols
    final clean = raw.replaceAll(
      RegExp(
        r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}]',
        unicode: true,
      ),
      '',
    ).trim();
    return clean.isNotEmpty ? clean : 'General';
  }

  static String _normalizePrice(String rawPrice, String category) {
    if (rawPrice.isEmpty || rawPrice == '--') {
      final cat = category.toLowerCase();
      if (cat.contains('ac')) return '₹ 499/-';
      if (cat.contains('electr')) return '₹ 199/-';
      if (cat.contains('plumb')) return '₹ 199/-';
      if (cat.contains('ro')) return '₹ 649/-';
      if (cat.contains('pest')) return '₹ 799/-';
      if (cat.contains('geyser')) return '₹ 449/-';
      return '₹ 299/-';
    }

    if (rawPrice.startsWith('₹')) return rawPrice;
    if (RegExp(r'^\d+').hasMatch(rawPrice)) {
      return '₹ $rawPrice/-';
    }
    return rawPrice;
  }

  static String? _computeOriginalPrice(String price) {
    // If standard "₹ 499/-", compute ~30% higher for strikethrough savings
    final match = RegExp(r'₹\s*([0-9,]+)').firstMatch(price);
    if (match != null) {
      final numStr = match.group(1)!.replaceAll(',', '');
      final num = int.tryParse(numStr);
      if (num != null && num > 0) {
        final orig = (num * 1.35).round();
        return '₹ $orig/-';
      }
    }
    return null;
  }

  static String _extractTag(Map<String, dynamic>? field) {
    if (field != null && field.containsKey('arrayValue')) {
      final values = field['arrayValue']['values'] as List<dynamic>?;
      if (values != null && values.isNotEmpty) {
        final first = values[0] as Map<String, dynamic>?;
        if (first != null && first.containsKey('stringValue')) {
          final t = first['stringValue'] as String;
          if (t.trim().isNotEmpty) return t.trim();
        }
      }
    }
    return 'Popular';
  }

  static String _resolveImageUrl(String raw, String category) {
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }
    final cat = category.toLowerCase();
    if (cat.contains('ac')) return 'assets/images/ac.png';
    if (cat.contains('electr')) return 'assets/images/electrician.png';
    if (cat.contains('plumb')) return 'assets/images/plumbing.png';
    if (cat.contains('ro')) return 'assets/images/ro.png';
    if (cat.contains('fan')) return 'assets/images/products/fan_capacitor.jpg';
    if (cat.contains('pump')) return 'assets/images/products/solar_junction_box.jpg';
    return 'assets/images/refrigerator_technician.jpg';
  }
}
