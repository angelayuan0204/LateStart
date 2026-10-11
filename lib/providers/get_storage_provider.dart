import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:late_start/datas/data_base.dart';

import '../datas/data_alarm_cycle.dart';
import '../datas/data_alarm_cycle_base.dart';

class GetStorageProvider {
  late final GetStorage _getStorage;

  Future<GetStorageProvider> init() async {
    await GetStorage.init();
    _getStorage = GetStorage();
    return this;
  }

  Future<String> readCurrentLanguage() async {
    debugPrint(_getStorage.read('currentLanguageKey'));
    String? language = _getStorage.read(('currentLanguageKey'));
    if (language == null) {
      language = Get.locale.toString();
      writeCurrentLanguage(language);
    }
    return language;
  }

  Future<void> writeCurrentLanguage(String value) async {
    await _getStorage.write('currentLanguageKey', value);
  }

  Future<Locale> readLocale() async {
    final languageCode = _getStorage.read('languageCode');

    return languageCode != null
        ? Locale(
            languageCode,
            _getStorage.read('countryCode') ?? '',
          )
        : const Locale('en', 'EN');
  }

  Future<void> writeLocale(String lanCode, String countryCode) async {
    await _getStorage.write('languageCode', lanCode);
    await _getStorage.write('countryCode', countryCode);
  }

  // Future<void> writeCurrentCalendarDataKey(String key) async {
  //   return await _getStorage.write('currentCalendarDataKey', key);
  // }

  // DataBase? readCurrentCalendarData() {
  //   return DataManager.getDataBase(_getStorage.read<String>('currentCalendarDataKey')??'');
  // }

  Future<void> writeCurrentCalendarData(DataBase data) async {
    // await writeCurrentCalendarDataKey(data.abbreviation());
    await _getStorage.write('currentCalendarData', jsonEncode(data));
  }

  Future<void> cleanCurrentCalendarData() async {
    await _getStorage.remove('currentCalendarData');
  }

  DataBase? readNewCurrentCalendarData() {
    String? mapStr = _getStorage.read<String>('currentCalendarData');
    if (mapStr == null || mapStr.isEmpty) return null;
    return DataBase.tryFromStorage(jsonDecode(mapStr));
  }

  DataAlarmCycleBase? readCurrentAlarmCycleData() {
    DataBase? currentCalendarData = readNewCurrentCalendarData();
    if (currentCalendarData != null) {
      return AlarmCycleFactory.create(currentCalendarData);
    }
    return null;
  }

}
