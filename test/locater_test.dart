import 'package:countries_app/locater.dart';
import 'package:countries_app/services/api.dart';
import 'package:countries_app/services/hive.dart';
import 'package:test/test.dart';

void main() {
  late HiveService hiveService;
  late ApiService apiService;
  setUpAll(() {
    setupLocator();

    hiveService = locator<HiveService>();
    apiService = locator<ApiService>();
  });
  group('setupLocator tests', () {
    test('ApiService should be registered', () {
      expect(apiService, isA<ApiService>());
    });
    test('HiveService should be registered', () {
      expect(hiveService, isA<HiveService>());
    });
  });
}
