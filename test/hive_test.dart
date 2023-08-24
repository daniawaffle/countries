import 'package:countries_app/constants.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HiveService hiveService;
  late MockBox mockBox;

  setUp(() {
    mockMethodChannel();
    Hive.initFlutter();

    mockBox = MockBox();
    hiveService = HiveService();

    hiveService.languageBox = mockBox;
  });
  test('box is open', () async {
    await hiveService.openBoxes();
    expect(hiveService.languageBox.isOpen, true);
  });
  test('setValue should put value in the box', () async {
    const boxName = hiveBox;
    const key = languageHiveKey;
    const value = 'testValue';

    await hiveService.setValue(boxName: boxName, key: key, value: value);

    verify(mockBox.put(key, value));
  });

  test('getValue should return value from the box', () {
    const boxName = hiveBox;
    const key = languageHiveKey;
    const expectedValue = 'testValue';
    when(mockBox.get(key)).thenReturn(expectedValue);

    final result = hiveService.getValue<String>(boxName: boxName, key: key);

    expect(result, expectedValue);
  });

  test('getValue should return null if box name is not recognized', () {
    const boxName = 'unknownBox';
    const key = 'testKey';

    final result = hiveService.getValue<String>(boxName: boxName, key: key);

    expect(result, isNull);
  });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
