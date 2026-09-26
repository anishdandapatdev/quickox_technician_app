import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quickox_technician_app/core/services/firebase_services_service.dart';

void main() {
  group('FirebaseServicesService Tests', () {
    test('defaultServices has 13 services matching explore_service.jsx', () {
      expect(FirebaseServicesService.defaultServices.length, 13);
      final titles = FirebaseServicesService.defaultServices
          .map((s) => s.title)
          .toList();

      expect(titles.contains('AC Deep Jet Cleaning & Servicing'), isTrue);
      expect(titles.contains('AC Gas Leakage Check & Refilling'), isTrue);
      expect(titles.contains('Switchboard & Socket Restoration'), isTrue);
      expect(titles.contains('Water Purifier RO Filter & Membrane Replacement'),
          isTrue);
      expect(titles.contains('Pipe Leakage & Tap Valve Repair'), isTrue);
    });

    test('fetchServices with limit returns exact count', () async {
      final service = FirebaseServicesService();
      final services = await service.fetchServices(limit: 4);
      expect(services.length, 4);
    });

    test('fetchServices parses mock Firestore JSON accurately', () async {
      final mockClient = MockClient((request) async {
        final mockJson = '''
        {
          "documents": [
            {
              "name": "projects/home-service-haldia/databases/(default)/documents/services/test1",
              "fields": {
                "title": {"stringValue": "Custom AC Jet Service"},
                "category": {"stringValue": "❄️ AC Service"},
                "desc": {"stringValue": "High pressure jet pump wash."},
                "price": {"stringValue": "549"},
                "rating": {"stringValue": "4.9"},
                "frequency": {"stringValue": "One-Time"},
                "isActive": {"booleanValue": true}
              }
            },
            {
              "name": "projects/home-service-haldia/databases/(default)/documents/services/test2",
              "fields": {
                "title": {"stringValue": "Inactive Service"},
                "isActive": {"booleanValue": false}
              }
            }
          ]
        }
        ''';
        return http.Response(mockJson, 200, headers: {'content-type': 'application/json'});
      });

      final service = FirebaseServicesService(client: mockClient);
      final list = await service.fetchServices();

      expect(list.length, 1);
      expect(list.first.title, 'Custom AC Jet Service');
      expect(list.first.category, 'AC Service');
      expect(list.first.price, '₹ 549/-');
      expect(list.first.rating, '4.9');
    });

    test('fetchServices connects to real Firestore or falls back gracefully', () async {
      final service = FirebaseServicesService();
      final list = await service.fetchServices(limit: 4);
      expect(list.length, 4);
      for (final s in list) {
        expect(s.title.isNotEmpty, isTrue);
        expect(s.price.isNotEmpty, isTrue);
      }
    });

    test('defaultVerticals has 8 Super App verticals matching multiServiceData.js', () {
      expect(FirebaseServicesService.defaultVerticals.length, 8);
      final ids = FirebaseServicesService.defaultVerticals.map((v) => v.id).toList();
      expect(ids, containsAll([
        'home_care',
        'food_delivery',
        'bike_cab',
        'event_booking',
        'ambulance',
        'medicine_delivery',
        'room_booking',
        'electra_scooty',
      ]));
    });

    test('fetchVerticals returns 8 verticals with fallback and Firestore enhancement', () async {
      final service = FirebaseServicesService();
      final verticals = await service.fetchVerticals();
      expect(verticals.length, 8);
      expect(verticals.any((v) => v.id == 'home_care'), isTrue);
      expect(verticals.any((v) => v.id == 'medicine_delivery'), isTrue);
      expect(verticals.any((v) => v.id == 'food_delivery'), isTrue);
    });
  });
}
