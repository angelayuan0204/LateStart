import 'package:late_start/datas/data_base.dart';
import 'package:late_start/datas/school_calendar_model.dart';

class DATA_HWMS extends DataBase {

  static final DateTime _startDate = DateTime(2024, 8, 26);
  static final DateTime _endDate = DateTime(2026, 6, 3);

  static final Set<DateTime> _breakoutDays2425 = {

    DateTime(2024, 9, 2),
    DateTime(2024, 9, 18),
    DateTime(2024, 10, 3),
    DateTime(2024, 10, 7),
    DateTime(2024, 10, 8),
    DateTime(2024, 10, 9),
    DateTime(2024, 10, 10),
    DateTime(2024, 10, 11),
    DateTime(2024, 10, 23),
    DateTime(2024, 11, 8),
    DateTime(2024, 11, 25),
    DateTime(2024, 11, 26),
    DateTime(2024, 11, 27),
    DateTime(2024, 11, 28),
    DateTime(2024, 11, 29),
    DateTime(2024, 12, 11),
    DateTime(2024, 12, 23),
    DateTime(2024, 12, 24),
    DateTime(2024, 12, 25),
    DateTime(2024, 12, 26),
    DateTime(2024, 12, 27),
    DateTime(2024, 12, 30),
    DateTime(2024, 12, 31),
    DateTime(2025, 1, 1),
    DateTime(2025, 1, 2),
    DateTime(2025, 1, 3),
    DateTime(2025, 1, 20),
    DateTime(2025, 1, 29),
    DateTime(2025, 2, 14),
    DateTime(2025, 2, 17),
    DateTime(2025, 3, 3),
    DateTime(2025, 3, 24),
    DateTime(2025, 3, 25),
    DateTime(2025, 3, 26),
    DateTime(2025, 3, 27),
    DateTime(2025, 3, 28),
    DateTime(2025, 3, 31),
    DateTime(2025, 4, 1),
    DateTime(2025, 4, 2),
    DateTime(2025, 4, 3),
    DateTime(2025, 4, 4),
    DateTime(2025, 4, 18),
    DateTime(2025, 5, 7),
    DateTime(2025, 5, 26),
    DateTime(2025, 6, 4),
  };

  static final Set<DateTime> _breakoutDays2526 = {

    DateTime(2025, 8, 25),
    DateTime(2025, 9, 1),
    DateTime(2025, 9, 23),
    DateTime(2025, 10, 2),
    DateTime(2025, 10, 13),
    DateTime(2025, 10, 14),
    DateTime(2025, 10, 15),
    DateTime(2025, 10, 16),
    DateTime(2025, 10, 17),
    DateTime(2025, 10, 29),
    DateTime(2025, 11, 7),
    DateTime(2025, 11, 24),
    DateTime(2025, 11, 25),
    DateTime(2025, 11, 26),
    DateTime(2025, 11, 27),
    DateTime(2025, 11, 28),
    DateTime(2025, 12, 10),
    DateTime(2025, 12, 22),
    DateTime(2025, 12, 23),
    DateTime(2025, 12, 24),
    DateTime(2025, 12, 25),
    DateTime(2025, 12, 26),
    DateTime(2025, 12, 29),
    DateTime(2025, 12, 30),
    DateTime(2025, 12, 31),
    DateTime(2026, 1, 1),
    DateTime(2026, 1, 2),
    DateTime(2026, 1, 19),
    // DateTime(2026, 2, 13),
    DateTime(2026, 2, 16),
    DateTime(2026, 2, 17),
    DateTime(2026, 3, 9),
    DateTime(2026, 3, 23),
    DateTime(2026, 3, 24),
    DateTime(2026, 3, 25),
    DateTime(2026, 3, 26),
    DateTime(2026, 3, 27),
    DateTime(2026, 3, 30),
    DateTime(2026, 3, 31),
    DateTime(2026, 4, 1),
    DateTime(2026, 4, 2),
    DateTime(2026, 4, 3),
    DateTime(2026, 4, 22),
    DateTime(2026, 5, 13),
    DateTime(2026, 5, 25),
    DateTime(2026, 6, 2),
    DateTime(2026, 6, 3),
  };

  @override
  DateTime endDate() {
    return _endDate;
  }

  @override
  DateTime startDate() {
    return _startDate;
  }

  Map<DateTime, List<String>> _schoolEvents2425() {
    return {
      DateTime(2024, 9, 2): ['Labor\nDay'],
      DateTime(2024, 9, 18): ['Flex'],
      DateTime(2024, 10, 3): ['Rosh\nHashanah'],
      DateTime(2024, 10, 7): ['M.S.\nRetreat'],
      DateTime(2024, 10, 8): ['M.S.\nRetreat'],
      DateTime(2024, 10, 9): ['M.S.\nRetreat'],
      DateTime(2024, 10, 10): ['Break'],
      DateTime(2024, 10, 11): ['Break'],
      DateTime(2024, 10, 23): ['Flex'],
      DateTime(2024, 11, 8): ['Prof\nDev'],
      DateTime(2024, 11, 25): ['TG\nBreak'],
      DateTime(2024, 11, 26): ['TG\nBreak'],
      DateTime(2024, 11, 27): ['TG\nBreak'],
      DateTime(2024, 11, 28): ['TG\nBreak'],
      DateTime(2024, 11, 29): ['TG\nBreak'],
      DateTime(2024, 12, 11): ['Flex'],
      DateTime(2024, 12, 23): ['Winter\nBreak'],
      DateTime(2024, 12, 24): ['Winter\nBreak'],
      DateTime(2024, 12, 25): ['Winter\nBreak'],
      DateTime(2024, 12, 26): ['Winter\nBreak'],
      DateTime(2024, 12, 27): ['Winter\nBreak'],
      DateTime(2024, 12, 30): ['Winter\nBreak'],
      DateTime(2024, 12, 31): ['Winter\nBreak'],
      DateTime(2025, 1, 1): ['Winter\nBreak'],
      DateTime(2025, 1, 2): ['Winter\nBreak'],
      DateTime(2025, 1, 3): ['Winter\nBreak'],
      DateTime(2025, 1, 20): ['MLK'],
      DateTime(2025, 1, 29): ['Lunar\nNewYear'],
      DateTime(2025, 2, 14): ['Break'],
      DateTime(2025, 2, 17): ['Pres\nDay'],
      DateTime(2025, 3, 3): ['Prof\nDev'],
      DateTime(2025, 3, 24): ['Spring\nBreak'],
      DateTime(2025, 3, 25): ['Spring\nBreak'],
      DateTime(2025, 3, 26): ['Spring\nBreak'],
      DateTime(2025, 3, 27): ['Spring\nBreak'],
      DateTime(2025, 3, 28): ['Spring\nBreak'],
      DateTime(2025, 3, 31): ['Spring\nBreak'],
      DateTime(2025, 4, 1): ['Spring\nBreak'],
      DateTime(2025, 4, 2): ['Spring\nBreak'],
      DateTime(2025, 4, 3): ['Spring\nBreak'],
      DateTime(2025, 4, 4): ['Spring\nBreak'],
      DateTime(2025, 4, 18): ['Good\nFriday'],
      DateTime(2025, 5, 7): ['Flex'],
      DateTime(2025, 5, 26): ['Memorial\nDay'],
      DateTime(2025, 6, 4): ['Last\nDay'],
    };
  }

  Map<DateTime, List<String>> _schoolEvents2526() {
    return {
      DateTime(2025, 8, 25): ['Convo-\ncation'],
      DateTime(2025, 9, 1): ['Labor\nDay'],
      DateTime(2025, 9, 13): ['Back-to-\nSchool'],
      DateTime(2025, 9, 23): ['Rosh\nHashanah'],
      DateTime(2025, 9, 27): ['Home-\ncoming'],
      DateTime(2025, 10, 2): ['Yom\nKippur'],
      DateTime(2025, 10, 13): ['M.S.\nRetreat'],
      DateTime(2025, 10, 14): ['M.S.\nRetreat'],
      DateTime(2025, 10, 15): ['M.S.\nRetreat'],
      DateTime(2025, 10, 16): ['M.S.\nRetreat'],
      DateTime(2025, 10, 17): ['Break'],
      DateTime(2025, 10, 29): ['Flex'],
      DateTime(2025, 11, 7): ['Prof\nDev'],
      DateTime(2025, 11, 24): ['TG\nBreak'],
      DateTime(2025, 11, 25): ['TG\nBreak'],
      DateTime(2025, 11, 26): ['TG\nBreak'],
      DateTime(2025, 11, 27): ['TG\nBreak'],
      DateTime(2025, 11, 28): ['TG\nBreak'],
      DateTime(2025, 12, 10): ['Flex'],
      DateTime(2025, 12, 22): ['Winter\nBreak'],
      DateTime(2025, 12, 23): ['Winter\nBreak'],
      DateTime(2025, 12, 24): ['Winter\nBreak'],
      DateTime(2025, 12, 25): ['Winter\nBreak'],
      DateTime(2025, 12, 26): ['Winter\nBreak'],
      DateTime(2025, 12, 29): ['Winter\nBreak'],
      DateTime(2025, 12, 30): ['Winter\nBreak'],
      DateTime(2025, 12, 31): ['Winter\nBreak'],
      DateTime(2026, 1, 1): ['Winter\nBreak'],
      DateTime(2026, 1, 2): ['Winter\nBreak'],
      DateTime(2026, 1, 19): ['MLK'],
      // DateTime(2026, 2, 13): ['Break'],
      DateTime(2026, 2, 16): ['Pres\nDay'],
      DateTime(2026, 2, 17): ['Lunar\nNewYear'],
      DateTime(2026, 3, 9): ['Prof\nDev'],
      DateTime(2026, 3, 23): ['Spring\nBreak'],
      DateTime(2026, 3, 24): ['Spring\nBreak'],
      DateTime(2026, 3, 25): ['Spring\nBreak'],
      DateTime(2026, 3, 26): ['Spring\nBreak'],
      DateTime(2026, 3, 27): ['Spring\nBreak'],
      DateTime(2026, 3, 30): ['Spring\nBreak'],
      DateTime(2026, 3, 31): ['Spring\nBreak'],
      DateTime(2026, 4, 1): ['Spring\nBreak'],
      DateTime(2026, 4, 2): ['Spring\nBreak'],
      DateTime(2026, 4, 3): ['Spring\nBreak'],
      DateTime(2026, 4, 22): ['Flex'],
      DateTime(2026, 5, 13): ['Flex'],
      DateTime(2026, 5, 25): ['Memorial\nDay'],
      DateTime(2026, 6, 3): ['Last\nDay'],
    };
  }

  @override
  Map<DateTime, List<String>> schoolEvents() {
    return {
      ..._schoolEvents2425(),
      ..._schoolEvents2526()
    };
  }

  @override
  List<SchoolCalendarModel> schoolCalendarModels() {
    return [
      SchoolCalendarModel(
        startDate: DateTime(2024, 8, 26),
        endDate: DateTime(2025, 6, 4),
        breakoutDays: _breakoutDays2425,
        hasLateStart: false,
        maxCycleDays: 6,
      ),
      SchoolCalendarModel(
          startDate: DateTime(2025, 8, 25),
          endDate: DateTime(2026, 6, 3),
          breakoutDays: _breakoutDays2526,
          hasLateStart: false, maxCycleDays: 8,
      ),
    ];
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