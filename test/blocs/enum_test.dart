import 'package:countries_app/enum/appoint_state.dart';
import 'package:countries_app/enum/appoint_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AppointmentStatus enum", () {
    test('getStatusNumber should return correct status number', () {
      expect(
          AppointmentStatusConverter.getStatusNumber(AppointmentStatus.active),
          1);
      expect(
          AppointmentStatusConverter.getStatusNumber(
              AppointmentStatus.mentorCancel),
          2);
      expect(
          AppointmentStatusConverter.getStatusNumber(
              AppointmentStatus.clientCancel),
          3);
      expect(
          AppointmentStatusConverter.getStatusNumber(
              AppointmentStatus.clientMiss),
          4);
      expect(
          AppointmentStatusConverter.getStatusNumber(
              AppointmentStatus.mentorMiss),
          5);
      expect(
          AppointmentStatusConverter.getStatusNumber(
              AppointmentStatus.completed),
          6);
    });

    test('getStatusFromNumber should return correct status', () {
      expect(AppointmentStatusConverter.getStatusFromNumber(1),
          AppointmentStatus.active);
      expect(AppointmentStatusConverter.getStatusFromNumber(2),
          AppointmentStatus.mentorCancel);
      expect(AppointmentStatusConverter.getStatusFromNumber(3),
          AppointmentStatus.clientCancel);
      expect(AppointmentStatusConverter.getStatusFromNumber(4),
          AppointmentStatus.clientMiss);
      expect(AppointmentStatusConverter.getStatusFromNumber(5),
          AppointmentStatus.mentorMiss);
      expect(AppointmentStatusConverter.getStatusFromNumber(6),
          AppointmentStatus.completed);
    });

    test('getStatusFromNumber should throw exception for invalid status number',
        () {
      expect(() => AppointmentStatusConverter.getStatusFromNumber(7),
          throwsException);
    });
  });

  group("AppointmentType enum", () {
    test('getStatusNumber should return correct type number', () {
      expect(AppointmentTypeConverter.getStatusNumber(AppointmentType.schudule),
          1);
      expect(
          AppointmentTypeConverter.getStatusNumber(AppointmentType.instant), 2);
    });

    test('getTypeFromNumber should return correct type', () {
      expect(AppointmentTypeConverter.getTypeFromNumber(1),
          AppointmentType.schudule);
      expect(AppointmentTypeConverter.getTypeFromNumber(2),
          AppointmentType.instant);
    });

    test('getTypeFromNumber should throw exception for invalid type number',
        () {
      expect(
          () => AppointmentTypeConverter.getTypeFromNumber(3), throwsException);
    });
  });
}
