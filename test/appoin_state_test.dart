import 'package:countries_app/enum/appoint_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getStatusFromNumber should return correct error message', () {
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
  test('getStatusNumber throws exception for invalid status', () {
    try {
      const invalidNumber = 12; // Assume this is not a valid status
      AppointmentStatusConverter.getStatusFromNumber(invalidNumber);
      fail('Expected an exception to be thrown');
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
