
import 'package:late_start/datas/DATA_HWMS.dart';
import 'package:late_start/datas/DATA_HWUS.dart';
import 'package:late_start/datas/data_base.dart';

import 'DATA_ALARM_CYCLE_HWMS.dart';
import 'DATA_ALARM_CYCLE_HWUS.dart';
import 'data_alarm_cycle_base.dart';

class DataManager {

  static List<DataBase> _getCurrentAllDate() => <DataBase>[
    DATA_HWUS(),
    DATA_HWMS(),
  ];

  static List<DataAlarmCycleBase> _getCurrentAllAlarmCycleData() => <DataAlarmCycleBase>[
    DATA_ALARM_CYCLE_HWMS(),
    DATA_ALARM_CYCLE_HWUS(),
  ];

  static DataAlarmCycleBase? getDataAlarmCycleBase(String key) {
    final matchedItems = _getCurrentAllAlarmCycleData().where((item) => item.fullName() == key || item.abbreviation() == key).toList();
    return matchedItems.isNotEmpty?matchedItems.first : null;
  }

  static DataBase? getDataBase(String key) {
    final matchedItems = _getCurrentAllDate().where((item) => item.fullName() == key || item.abbreviation() == key).toList();
    return matchedItems.isNotEmpty?matchedItems.first : null;
  }

  static List<DataBase>? getFuzzyMatchedDataBase(String key) {
    final matchedItems = _getCurrentAllDate().where((item) => item.fullName().toLowerCase().contains(key.toLowerCase()) || item.abbreviation().toLowerCase().contains(key.toLowerCase())).toList();
    return matchedItems.isNotEmpty?matchedItems : null;
  }

  static List<DataBase>? getNewFuzzyMatchedDataBase(String key) {
    final allData = _getCurrentAllDate();
    final matchedItems = allData.where((item) =>
    item.fullName().toLowerCase().contains(key.toLowerCase()) ||
        item.abbreviation().toLowerCase().contains(key.toLowerCase())
    ).toList();

    final hwus = DATA_HWUS();
    if (!matchedItems.any((item) => item.runtimeType == hwus.runtimeType)) {
      matchedItems.insert(0, hwus);
    }

    return matchedItems.isNotEmpty ? matchedItems : null;
  }

  /// 将 Map<DateTime, List<String>> 转换为 Map<String, List<DateTime>>
  /// 例如：{2025-12-22: ['Winter Break']} -> {'Winter Break': [2025-12-22]}
  static Map<String, List<DateTime>> flatten(Map<DateTime, List<String>> source, bool needCheckKey) {
    final Map<String, List<DateTime>> result = {};

    source.forEach((date, events) {
      for (final event in events) {
        // final cleanEvent = event.replaceAll('\n', ''); // 可选：去掉换行符
        String key = event;
        if (needCheckKey && (event == 'Break' || event == "FLEX" || event == 'Professional\nDevelopment' || event == "Flex" || event == 'Prof\nDev')) {
          key = '$event#${events.indexOf(event)}${date.toString()}';
        }
        result.putIfAbsent(key, () => []);
        result[key]!.add(date);
        // if(event == 'Break' || event == "FLEX" || event == 'Professional\nDevelopment' || event == "Flex") {
        //   result['$event${DateTime.timestamp()}']!.add(date);
        // } else {
        //   result[event]!.add(date);
        // }

      }
    });

    // 每个日期列表按时间排序（方便后续展示）
    result.forEach((_, list) => list.sort());
    return result;
  }

  /// 将 Map<String, List<DateTime>> 还原为 Map<DateTime, List<String>>
  static Map<DateTime, List<String>> expand(Map<String, List<DateTime>> grouped) {
    final Map<DateTime, List<String>> result = {};

    grouped.forEach((event, dates) {
      for (final date in dates) {
        result.putIfAbsent(date, () => []);
        result[date]!.add(event);
      }
    });

    // 可选：按日期排序（如果需要）
    final sorted = Map.fromEntries(
      result.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );

    return sorted;
  }

}