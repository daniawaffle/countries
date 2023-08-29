import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_test.mocks.dart';

@GenerateMocks([Box, HiveService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockHiveService mockHiveService;
  late MockBox mockBox;

  setUp(() {
    mockMethodChannel();
    Hive.initFlutter();

    mockBox = MockBox();
    mockHiveService = MockHiveService();
    locator.registerSingleton<HiveService>(MockHiveService());

    mockHiveService.languageBox = mockBox;
  });
  test('box is open', () async {
    await mockHiveService.openBoxes();
    // when(mockHiveService.openBoxes()).thenReturn(true);
    expect(mockHiveService.languageBox.isOpen, true);
  });
  test('setValue should put value in the box', () async {
    const boxName = AppConstants.hiveBox;
    const key = AppConstants.languageHiveKey;
    const value = 'testValue';

    await mockHiveService.setValue(boxName: boxName, key: key, value: value);

    verify(mockBox.put(key, value));
  });

  test('getValue should return value from the box', () {
    const boxName = AppConstants.hiveBox;
    const key = AppConstants.languageHiveKey;
    const expectedValue = 'testValue';
    when(mockBox.get(key)).thenReturn(expectedValue);

    final result = mockHiveService.getValue<String>(boxName: boxName, key: key);

    expect(result, expectedValue);
  });

  test('getValue should return null if box name is not recognized', () {
    const boxName = 'unknownBox';
    const key = 'testKey';

    final result = mockHiveService.getValue<String>(boxName: boxName, key: key);

    expect(result, isNull);
  });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
