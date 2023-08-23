import 'package:countries_app/screens/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validateNumber', () {
    test('test phone number length < min len  validator return error message',
        () {
      final loginBloc = LoginBLoc();

      var val = loginBloc.validateNumber('797123098', 10);
      expect(val, 'Please enter 10 digits number');
    });
    test(
        'test phone number length/empty < min len  validator return error message',
        () {
      final loginBloc = LoginBLoc();

      var val = loginBloc.validateNumber('', 10);
      expect(val, 'Please enter 10 digits number');
    });
    test('test phone number length = min len validator return null', () {
      final loginBloc = LoginBLoc();

      var val = loginBloc.validateNumber('797123098', 9);
      expect(val, null);
    });
// impossible scenario
    test('test phone number length > min len  validator return error message',
        () {
      final loginBloc = LoginBLoc();

      var val = loginBloc.validateNumber('797123098', 2);
      expect(val, 'Please enter 2 digits number');
    });
  });
}
