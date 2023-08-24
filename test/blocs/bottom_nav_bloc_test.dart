import 'package:countries_app/screens/bottomNavBar/bottom_nav_bloc.dart';
import 'package:test/test.dart';

void main() {
  test('onItemTapped should update selectedIndex', () {
    final bloc = BottomNav();
    expect(bloc.selectedIndex.value, 0);

    bloc.onItemTapped(1);
    expect(bloc.selectedIndex.value, 1);
  });
}
