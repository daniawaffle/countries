import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import 'hive_test.mocks.dart';

late HiveService hiveService;
late MockBox mockBox;

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    mockMethodChannel();
    Hive.initFlutter();

    mockBox = MockBox();
    hiveService = HiveService();
    if (!locator.isRegistered<HiveService>()) {
      locator.registerSingleton<HiveService>(hiveService);
    }

    hiveService.languageBox = mockBox;
  });

  test('getLan should return value from HiveService', () {
    const key = languageHiveKey;
    const expectedValue = 'ar';
    final startupBloc = StartupBloc();

    when(hiveService.getValue<String>(key: key, boxName: hiveBox))
        .thenReturn(expectedValue);
    var x = mockBox.get(key);
    print(x);

    final result = startupBloc.getLan();

    expect(result, expectedValue);
  });
  // test('getLan should return default value "en" from HiveService', () {
  //   const key = languageHiveKey;
  //   final startupBloc = StartupBloc();

  //   when(hiveService.getValue<String>(key: key, boxName: hiveBox))
  //       .thenReturn(null);

  //   final result = startupBloc.getLan();

  //   expect(result, 'en');
  // });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
