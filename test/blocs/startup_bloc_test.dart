import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../hive_test.mocks.dart';

late MockHiveService mockHiveService;
late MockBox mockBox;
@GenerateMocks([HiveService])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    mockBox = MockBox();
    mockHiveService = MockHiveService();
    locator.registerSingleton<HiveService>(MockHiveService());
  });

  group('getLan', () {
    test('getLan should return value from HiveService', () {
      const expectedValue = 'ar';
      final startupBloc = StartupBloc();

      when(locator<HiveService>().getValue<String>(
              key: AppConstants.languageHiveKey, boxName: AppConstants.hiveBox))
          .thenReturn(expectedValue);

      final result = startupBloc.getLan();

      expect(result, expectedValue);
    });
    test('getLan should return default value "en" from HiveService', () {
      final startupBloc = StartupBloc();

      when(locator<HiveService>().getValue<String>(
              key: AppConstants.languageHiveKey, boxName: AppConstants.hiveBox))
          .thenReturn(null);

      final result = startupBloc.getLan();

      expect(result, 'en');
    });
  });
}
