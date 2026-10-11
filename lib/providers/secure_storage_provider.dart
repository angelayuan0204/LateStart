import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/constants.dart';

class SecureStorageProvider {
  final FlutterSecureStorage _secureStorage;

  SecureStorageProvider() : _secureStorage = const FlutterSecureStorage();

  Future<AppTheme> readThemeValue() async {
    String themeValue =
        await _secureStorage.read(key: 'theme_value') ?? 'AppTheme.dark';
    return themeValue == 'AppTheme.dark' ? AppTheme.dark : AppTheme.light;
  }

  Future<void> writeThemeValue({
    required AppTheme theme,
  }) async {
    await _secureStorage.write(
      key: 'theme_value',
      value: theme.toString(),
    );
  }

  Future<bool> readSortedAlarmListValue({required String key}) async {
    return await _secureStorage.read(key: key) == 'true';
  }

  Future<void> writeSortedAlarmListValue({required String key, required bool isSortedAlarmListEnabled}) async {
    await _secureStorage.write(
      key: key,
      value: isSortedAlarmListEnabled.toString(),
    );
  }

  //check 24 hrs enabled
  Future<bool> read24HoursEnabled({required String key}) async {
    return await _secureStorage.read(key: key) == 'true';
  }

  Future<void> write24HoursEnabled({
    required String key,
    required bool is24HoursEnabled,
  }) async {
    await _secureStorage.write(
      key: key,
      value: is24HoursEnabled.toString(),
    );
  }

}
