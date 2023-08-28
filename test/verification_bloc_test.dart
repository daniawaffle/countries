import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:countries_app/screens/verfication/verification_bloc.dart';

void main() {
  final verBloc = VerificationBloc();
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

  group('timerText', () {
    test('timerText current seconds  less than minute', () {
      final verBloc = VerificationBloc();
      verBloc.currentSeconds.value = 30;
      String result = verBloc.timerText;
      expect(result, '01: 30');
    });

    test('timerText current seconds equals minute', () {
      final verBloc = VerificationBloc();
      verBloc.currentSeconds.value = 60;
      String result = verBloc.timerText;
      expect(result, '01: 00');
    });
    test('timerText timer max greater than minute', () {
      final verBloc = VerificationBloc();
      verBloc.currentSeconds.value = 120;
      String result = verBloc.timerText;
      expect(result, '00: 00');
    });
    test('timerText timer max greater than minute', () {
      final verBloc = VerificationBloc();
      verBloc.currentSeconds.value = 200;
      String result = verBloc.timerText;
      expect(result, '-1: 40');
    });
  });

  tearDown(() {
    verBloc.startTimeout();
    verBloc.timerMaxSeconds;
    verBloc.currentSeconds;
  });
}
