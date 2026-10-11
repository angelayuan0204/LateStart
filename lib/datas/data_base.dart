

import 'data_school_base.dart';
import 'dynamic_data_base.dart';
import 'school_calendar_model.dart';

abstract class DataBase extends DataSchoolBase {

  DateTime startDate();
  DateTime endDate();
  List<SchoolCalendarModel> schoolCalendarModels();
  Map<DateTime, List<String>> schoolEvents();

  List<String> eventLoader(DateTime calendarUtcDateTime) {
    DateTime dateTime = DateTime(calendarUtcDateTime.year, calendarUtcDateTime.month, calendarUtcDateTime.day);
    List<String> events = [];
    for (SchoolCalendarModel schoolCalendarModel in schoolCalendarModels()) {
      if (_isWithinRange(dateTime, schoolCalendarModel.startDate, schoolCalendarModel.endDate)) {
        int index = schoolCalendarModel.getDayOfCycle(dateTime);
        if (index != -1) {
          events.add((schoolCalendarModel.hasLateStart && index == 3)?'Day $index\nLS':'Day $index\n');
        }
      }
    }
    if (schoolEvents().containsKey(dateTime)) {
      events.addAll(schoolEvents()[dateTime]!);
    }
    return events;
  }

  bool _isWithinRange(DateTime dateTime, DateTime startDate, DateTime endDate) {
    return (dateTime.isAfter(startDate) || dateTime.isAtSameMomentAs(startDate)) &&
    (dateTime.isBefore(endDate) || dateTime.isAtSameMomentAs(endDate));
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'abbreviation': abbreviation,
      'startDate': startDate().toIso8601String(),
      'endDate': endDate().toIso8601String(),
      'events': _encodeEvents(schoolEvents()),
      'calendars': schoolCalendarModels().map((model) {
        return {
          'startDate': model.startDate.toIso8601String(),
          'endDate': model.endDate.toIso8601String(),
          'breakoutDays':
          model.breakoutDays.map((d) => d.toIso8601String()).toList(),
          'isExcludedWeekend': model.isExcludedWeekend,
          'hasLateStart': model.hasLateStart,
          'maxCycleDays': model.maxCycleDays,
        };
      }).toList(),
    };
  }

  /// 反序列化 GetStorage 保存的数据（可能是 null）
  static DataBase? tryFromStorage(dynamic raw) {
    if (raw == null) return null;
    if (raw is DataBase) return raw;
    if (raw is Map<String, dynamic>) return fromJson(raw);
    return null;
  }

  static DataBase fromJson(Map<String, dynamic> data) {
    final List<dynamic> calendarsJson = data['calendars'] ?? [];
    final Map<String, dynamic> eventsJson =
    Map<String, dynamic>.from(data['events'] ?? {});

    final calendars = calendarsJson.map((c) {
      return SchoolCalendarModel(
        startDate: DateTime.parse(c['startDate']),
        endDate: DateTime.parse(c['endDate']),
        breakoutDays: (c['breakoutDays'] as List<dynamic>)
            .map((e) => DateTime.parse(e))
            .toSet(),
        isExcludedWeekend: c['isExcludedWeekend'] ?? true,
        hasLateStart: c['hasLateStart'] ?? false,
        maxCycleDays: c['maxCycleDays'],
      );
    }).toList();

    final Map<DateTime, List<String>> events = {};
    eventsJson.forEach((key, value) {
      events[DateTime.parse(key)] = List<String>.from(value);
    });

    return DynamicDataBase(
      fullName: data['fullName'] ?? 'Unknown School',
      abbreviation: data['abbreviation'] ?? 'Unknown',
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      schoolCalendarModels: calendars,
      schoolEvents: events,
    );
  }

  /// 日期键序列化
  Map<String, List<String>> _encodeEvents(Map<DateTime, List<String>> events) {
    final Map<String, List<String>> result = {};
    events.forEach((key, value) {
      result[key.toIso8601String()] = value;
    });
    return result;
  }


}