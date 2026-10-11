import 'data_alarm_cycle_base.dart';

class DATA_ALARM_CYCLE_HWMS extends DataAlarmCycleBase {

  static final DateTime _startDate = DateTime(2025, 8, 25);
  static final DateTime _endDate = DateTime(2026, 6, 1);
  static const int _maxCycleDays = 8;

  //排除breakout day&weekend
  static final Set<DateTime> _excludedDates = {
    DateTime(2025, 8, 25),
    DateTime(2025, 8, 30),
    DateTime(2025, 8, 31),
    DateTime(2025, 9, 1),
    DateTime(2025, 9, 6),
    DateTime(2025, 9, 7),
    DateTime(2025, 9, 13),
    DateTime(2025, 9, 14),
    DateTime(2025, 9, 20),
    DateTime(2025, 9, 21),
    DateTime(2025, 9, 23),
    DateTime(2025, 9, 27),
    DateTime(2025, 9, 28),
    DateTime(2025, 10, 2),
    DateTime(2025, 10, 4),
    DateTime(2025, 10, 5),
    DateTime(2025, 10, 11),
    DateTime(2025, 10, 12),
    DateTime(2025, 10, 13),
    DateTime(2025, 10, 14),
    DateTime(2025, 10, 15),
    DateTime(2025, 10, 16),
    DateTime(2025, 10, 17),
    DateTime(2025, 10, 18),
    DateTime(2025, 10, 19),
    DateTime(2025, 10, 25),
    DateTime(2025, 10, 26),
    DateTime(2025, 10, 29),
    DateTime(2025, 11, 1),
    DateTime(2025, 11, 2),
    DateTime(2025, 11, 7),
    DateTime(2025, 11, 8),
    DateTime(2025, 11, 9),
    DateTime(2025, 11, 15),
    DateTime(2025, 11, 16),
    DateTime(2025, 11, 22),
    DateTime(2025, 11, 23),
    DateTime(2025, 11, 24),
    DateTime(2025, 11, 25),
    DateTime(2025, 11, 26),
    DateTime(2025, 11, 27),
    DateTime(2025, 11, 28),
    DateTime(2025, 11, 29),
    DateTime(2025, 11, 30),
    DateTime(2025, 12, 6),
    DateTime(2025, 12, 7),
    DateTime(2025, 12, 10),
    DateTime(2025, 12, 13),
    DateTime(2025, 12, 14),
    DateTime(2025, 12, 20),
    DateTime(2025, 12, 21),
    DateTime(2025, 12, 22),
    DateTime(2025, 12, 23),
    DateTime(2025, 12, 24),
    DateTime(2025, 12, 25),
    DateTime(2025, 12, 26),
    DateTime(2025, 12, 27),
    DateTime(2025, 12, 28),
    DateTime(2025, 12, 29),
    DateTime(2025, 12, 30),
    DateTime(2025, 12, 31),
    DateTime(2026, 1, 1),
    DateTime(2026, 1, 2),
    DateTime(2026, 1, 3),
    DateTime(2026, 1, 4),
    DateTime(2026, 1, 10),
    DateTime(2026, 1, 11),
    DateTime(2026, 1, 17),
    DateTime(2026, 1, 18),
    DateTime(2026, 1, 19),
    DateTime(2026, 1, 24),
    DateTime(2026, 1, 25),
    DateTime(2026, 1, 31),
    DateTime(2026, 2, 1),
    DateTime(2026, 2, 7),
    DateTime(2026, 2, 8),
    DateTime(2026, 2, 14),
    DateTime(2026, 2, 15),
    DateTime(2026, 2, 16),
    DateTime(2026, 2, 17),
    DateTime(2026, 2, 21),
    DateTime(2026, 2, 22),
    DateTime(2026, 2, 28),
    DateTime(2026, 3, 1),
    DateTime(2026, 3, 7),
    DateTime(2026, 3, 8),
    DateTime(2026, 3, 9),
    DateTime(2026, 3, 14),
    DateTime(2026, 3, 15),
    DateTime(2026, 3, 21),
    DateTime(2026, 3, 22),
    DateTime(2026, 3, 23),
    DateTime(2026, 3, 24),
    DateTime(2026, 3, 25),
    DateTime(2026, 3, 26),
    DateTime(2026, 3, 27),
    DateTime(2026, 3, 28),
    DateTime(2026, 3, 29),
    DateTime(2026, 3, 30),
    DateTime(2026, 3, 31),
    DateTime(2026, 4, 1),
    DateTime(2026, 4, 2),
    DateTime(2026, 4, 3),
    DateTime(2026, 4, 4),
    DateTime(2026, 4, 5),
    DateTime(2026, 4, 11),
    DateTime(2026, 4, 12),
    DateTime(2026, 4, 18),
    DateTime(2026, 4, 19),
    DateTime(2026, 4, 22),
    DateTime(2026, 4, 25),
    DateTime(2026, 4, 26),
    DateTime(2026, 5, 2),
    DateTime(2026, 5, 3),
    DateTime(2026, 5, 9),
    DateTime(2026, 5, 10),
    DateTime(2026, 5, 13),
    DateTime(2026, 5, 16),
    DateTime(2026, 5, 17),
    DateTime(2026, 5, 23),
    DateTime(2026, 5, 24),
    DateTime(2026, 5, 25),
    DateTime(2026, 5, 30),
    DateTime(2026, 5, 31),
  };

  @override
  DateTime startDate() {
    return _startDate;
  }

  @override
  DateTime endDate() {
    return _endDate;
  }

  @override
  Set<DateTime> excludedDates() {
    return _excludedDates;
  }

  @override
  int maxCycleDays() {
    return _maxCycleDays;
  }

  @override
  String abbreviation() {
    return "HWMS";
  }

  @override
  String fullName() {
    return "Harvard Westlake Middle School";
  }
}