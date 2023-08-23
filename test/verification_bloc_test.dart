import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:countries_app/screens/verfication/verification_bloc.dart';

void main() {
  test('startTimeout test', () {
    fakeAsync((fakeAsync) {
      final verBloc = VerificationBloc();
      verBloc.startTimeout();

      fakeAsync.elapse(verBloc.interval);

      expect(verBloc.currentSeconds.value, 1);

      fakeAsync.elapse(Duration(seconds: verBloc.timerMaxSeconds));

      expect(verBloc.currentSeconds.value, verBloc.timerMaxSeconds);
    });
  });
}
