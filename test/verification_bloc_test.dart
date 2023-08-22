import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:countries_app/screens/verfication/verification_bloc.dart';

void main() {
  test('startTimeout test', () {
    fakeAsync((fakeAsync) {
      final verBloc = VerificationBloc();
      verBloc.startTimeout();

      fakeAsync.elapse(verBloc.interval);

      // Verify that the expected changes have occurred
      expect(
          verBloc.currentSeconds.value, 1); // Adjust this based on your logic
      expect(verBloc.otpButtonVisible.value, false);

      // Advance the virtual time by more than timerMaxSeconds
      fakeAsync.elapse(Duration(seconds: verBloc.timerMaxSeconds));

      // Verify the final state after the timeout
      expect(verBloc.currentSeconds.value,
          verBloc.timerMaxSeconds); // Adjust this based on your logic
      expect(verBloc.otpButtonVisible.value, true);
    });
  });
}
