import 'package:countries_app/screens/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test phone number length validator', () {
    final loginBloc = LoginBLoc();

    var val = loginBloc.validateNumber('797123098', 8);
    expect(val, 'Please enter 8 digits number');
  });
}
