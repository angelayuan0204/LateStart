// 假设你有一个具体子类
import 'data_alarm_cycle_base.dart';
import 'data_base.dart';

class DataAlarmCycle extends DataAlarmCycleBase {
  final DataBase data;

  DataAlarmCycle(this.data);

  @override
  DateTime startDate() => data.schoolCalendarModels().isNotEmpty?data.schoolCalendarModels().last.startDate:data.startDate();

  @override
  DateTime endDate() => data.schoolCalendarModels().isNotEmpty?data.schoolCalendarModels().last.endDate:data.endDate();

  @override
  Set<DateTime> excludedDates() {
    final lastCalendar = data.schoolCalendarModels().isNotEmpty
        ? data.schoolCalendarModels().last
        : null;
    if (lastCalendar == null) return {};

    final Set<DateTime> excluded = {};

    // 如果需要排除周末
    if (lastCalendar.isExcludedWeekend) {
      DateTime current = lastCalendar.startDate;
      while (!current.isAfter(lastCalendar.endDate)) {
        if (current.weekday == DateTime.saturday || current.weekday == DateTime.sunday) {
          excluded.add(DateTime(current.year, current.month, current.day));
        }
        current = current.add(const Duration(days: 1));
      }
    }

    // 加入 BreakoutDays
    for (final day in lastCalendar.breakoutDays) {
      excluded.add(DateTime(day.year, day.month, day.day));
    }

    // 返回按时间升序排列的 Set（LinkedHashSet 保留插入顺序）
    final sorted = excluded.toList()..sort((a, b) => a.compareTo(b));
    return sorted.toSet();
  }

  @override
  int maxCycleDays() => data.schoolCalendarModels().isNotEmpty? data.schoolCalendarModels().last.maxCycleDays:0;

  @override
  String abbreviation() {
    return data.abbreviation();
  }

  @override
  String fullName() {
    return data.fullName();
  }
}

// 工厂类
class AlarmCycleFactory {
  /// 根据 DataBase 返回具体 DataAlarmCycleBase 实例
  static DataAlarmCycleBase create(DataBase data) {
    // 这里可以根据不同的 abbreviation 或类型返回不同子类
    // 例如 HWMS、USC 等不同逻辑
    return DataAlarmCycle(data);
  }
}
