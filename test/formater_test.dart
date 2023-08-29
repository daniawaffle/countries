import 'package:countries_app/utils/formater.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDuration', () {
    test('Duration less than 60 minutes', () {
      final result = Formater.formatDuration(
        dateFrom: DateTime(2023, 8, 20, 10, 0), // 10:00 AM
        dateTo: DateTime(2023, 8, 20, 10, 30), // 10:30 AM
      );
      expect(result, '30 min');
    });

    test('Duration exactly 1 hour', () {
      final result = Formater.formatDuration(
        dateFrom: DateTime(2023, 8, 20, 14, 0), // 2:00 PM
        dateTo: DateTime(2023, 8, 20, 15, 0), // 3:00 PM
      );
      expect(result, '1 h');
    });

    test(' Duration more than 1 hour and minutes > 0', () {
      final result = Formater.formatDuration(
        dateFrom: DateTime(2023, 8, 20, 8, 45), // 8:45 AM
        dateTo: DateTime(2023, 8, 20, 10, 30), // 10:30 AM
      );
      expect(result, '1 h 45 min');
    });

    test('Duration more than 1 hour and minutes = 0', () {
      final result = Formater.formatDuration(
        dateFrom: DateTime(2023, 8, 20, 13, 0), // 1:00 PM
        dateTo: DateTime(2023, 8, 20, 15, 0), // 3:00 PM
      );
      expect(result, '2 h');
    });
  });
}
