import 'package:flutter_test/flutter_test.dart';
import 'package:quickox_technician_app/core/services/firebase_membership_service.dart';

void main() {
  group('FirebaseMembershipService Tests', () {
    test('defaultPlans contains exactly 11 BHK-tailored plans matching Handwriting Matrix', () {
      final plans = FirebaseMembershipService.defaultPlans;
      expect(plans.length, 11);

      final planIds = plans.map((p) => p.id).toList();
      expect(planIds, containsAll([
        'p299',
        'p399',
        'p499',
        'p599',
        'p699',
        'p799',
        'p899',
        'p999',
        'p1199',
        'p1599',
        'p2199',
      ]));

      // Verify essential pricing properties
      final p299 = plans.firstWhere((p) => p.id == 'p299');
      expect(p299.bhk, '1 RK');
      expect(p299.monthlyPrice, 299);
      expect(p299.yearlyPrice, 239);
      expect(p299.acCovered, false);
      expect(p299.roCovered, false);

      final p899 = plans.firstWhere((p) => p.id == 'p899');
      expect(p899.bhk, '2 BHK');
      expect(p899.monthlyPrice, 899);
      expect(p899.yearlyPrice, 719);
      expect(p899.isPopular, true);
      expect(p899.acCovered, true);
      expect(p899.roCovered, true);
    });

    test('defaultCoupons contains QUICKOX20, WELCOME50, SUPERCARE', () {
      final coupons = FirebaseMembershipService.defaultCoupons;
      expect(coupons.length, 3);
      final codes = coupons.map((c) => c.code).toList();
      expect(codes, containsAll(['QUICKOX20', 'WELCOME50', 'SUPERCARE']));
    });

    test('fetchPlans returns plans with Firestore fallback', () async {
      final service = FirebaseMembershipService();
      final plans = await service.fetchPlans();
      expect(plans.length, greaterThanOrEqualTo(11));
    });
  });
}
