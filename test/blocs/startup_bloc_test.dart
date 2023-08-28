import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import '../hive_test.mocks.dart';

//late HiveService hiveService;
late MockHiveService mockHiveService;
late MockBox mockBox;

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    mockMethodChannel();

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

  group('saveLanguageToHive', () {
    test('saveLanguageToHive', () async {
      const value = 'testValue';

      final startupBloc = StartupBloc();

      when(locator<HiveService>().setValue<String>(
              key: AppConstants.languageHiveKey,
              boxName: AppConstants.hiveBox,
              value: value))
          .thenAnswer((_) => Future.value());

      startupBloc.saveLanguageToHive(value);

      verify(locator<HiveService>().setValue<String>(
              key: AppConstants.languageHiveKey,
              boxName: AppConstants.hiveBox,
              value: value))
          .called(1);
    });
  });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
