import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:task_flow/domain/mapper/convert_text_to_date_time.dart';
import 'package:task_flow/validator/data_validation.dart';

void main() {
  group('convertTextToDateTime', () {
    test('parses date with time', () {
      final result = convertTextToDateTime(dateText: 'Sep 15, 2026 3:30 PM');

      expect(result.year, 2026);
      expect(result.month, 9);
      expect(result.day, 15);
      expect(result.hour, 15);
      expect(result.minute, 30);
    });

    test('parses date-only text', () {
      final result = convertTextToDateTime(dateText: 'Sep 15, 2026');

      expect(result.year, 2026);
      expect(result.month, 9);
      expect(result.day, 15);
      expect(result.hour, 0);
      expect(result.minute, 0);
    });
  });

  group('reminderNotificationValidation', () {
    test('allows future reminder', () {
      final future = DateTime.now().add(const Duration(minutes: 15));
      final text = DateFormat('MMM d, yyyy h:mm a').format(future);

      expect(
        DataValidation.reminderNotificationValidation(reminderDateText: text),
        isNull,
      );
    });

    test('rejects past reminder', () {
      final past = DateTime.now().subtract(const Duration(minutes: 15));
      final text = DateFormat('MMM d, yyyy h:mm a').format(past);

      expect(
        DataValidation.reminderNotificationValidation(reminderDateText: text),
        'Reminder date must be in the future.',
      );
    });
  });

  group('title and description validation', () {
    test('rejects empty title', () {
      expect(DataValidation.titleValidation(''), isNotNull);
    });

    test('accepts non-empty title', () {
      expect(DataValidation.titleValidation('My task'), isNull);
    });
  });
}
