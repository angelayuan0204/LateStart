import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/utils/utils.dart';

import 'datas/DATA_ALARM_CYCLE_HWMS.dart';
import 'datas/DATA_ALARM_CYCLE_HWUS.dart';

//publicEvents
final Map<DateTime, List<String>> publicDaysMap = {
  // ===== National Holidays =====
  DateTime(2025, 9, 1): ['Labor\nDay'],
  DateTime(2025, 9, 23): ['Rosh\nHashanah'],
  DateTime(2025, 10, 2): ['Yom\nKippur'],
  DateTime(2026, 1, 19): ['Martin\nLuther\nKing\nJr.\nDay'],
  DateTime(2026, 2, 16): ['Presidents\nDay'],
  DateTime(2026, 2, 17): ['Lunar\nNew\nYear'],
  DateTime(2026, 5, 25): ['Memorial\nDay'],

  // ===== Thanksgiving Break =====
  DateTime(2025, 11, 24): ['Thanksgiving\nBreak'],
  DateTime(2025, 11, 25): ['Thanksgiving\nBreak'],
  DateTime(2025, 11, 26): ['Thanksgiving\nBreak'],
  DateTime(2025, 11, 27): ['Thanksgiving\nBreak'],
  DateTime(2025, 11, 28): ['Thanksgiving\nBreak'],

  // ===== Winter Break =====
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

  // ===== Spring Break =====
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

  // ===== School Other No Cycle Days =====
  DateTime(2025, 8, 25): ['Convo-\ncation'],
  DateTime(2025, 10, 15): ['PSAT'],
  DateTime(2025, 10, 16): ['Break'],
  DateTime(2025, 10, 17): ['Break'],
  DateTime(2025, 10, 29): ['FLEX'],
  DateTime(2025, 11, 7): ['Professional\nDevelopment'],
  DateTime(2025, 12, 10): ['FLEX'],
  DateTime(2026, 3, 9): ['Professional\nDevelopment'],
  DateTime(2026, 4, 22): ['FLEX'],
  DateTime(2026, 5, 13): ['FLEX'],
  DateTime(2026, 5, 29): ['Exams'],
  DateTime(2026, 6, 1): ['Exams'],
  DateTime(2026, 6, 2): ['Exams'],
  DateTime(2026, 6, 3): ['Exams'],
  DateTime(2026, 6, 4): ['Break'],
  DateTime(2026, 6, 5): ['Commencement'],
};

Future<void> main() async {

  // DateTime? nextAlarmTime = Utils.findNextAlarmDate(startDate: DaysHwUs.startDate, endDate: DaysHwUs.endDate, alarmDays: [true, false, false, false, false, false], excludedDates: DaysHwUs.excludedDates, targetTime: TimeOfDay(hour: 07, minute: 08), currentDate: DateTime(2024, 11, 4, 07, 09),);
  // print("test nextAlarmTime -> $nextAlarmTime");
  // DateTime? nextAlarmTime = Utils.findNextAlarmDate(startDate: DATA_ALARM_CYCLE_HWUS.startDate, endDate: DATA_ALARM_CYCLE_HWUS.endDate, alarmDays: [true, true, true, true, true, true], excludedDates: DATA_ALARM_CYCLE_HWUS.excludedDates, targetTime: TimeOfDay(hour: 07, minute: 08), currentDate: DateTime(2025, 7, 9, 07, 09),);
  // print("test nextAlarmTime -> $nextAlarmTime");
  // DateTime? nextAlarmTime = Utils.findNextAlarmDate(startDate: DaysHwMs.startDate, endDate: DaysHwMs.endDate, alarmDays: [true, true, true, true, true, true, true, true], excludedDates: DaysHwMs.excludedDates, targetTime: TimeOfDay(hour: 07, minute: 08), currentDate: DateTime(2025, 7, 9, 07, 09),);
  // print("test nextAlarmTime -> $nextAlarmTime");
  // DateTime? nextAlarmTime = Utils.findNextAlarmDate(alarmDays: [true, true, true, true, true, true, ],  targetTime: const TimeOfDay(hour: 07, minute: 08), currentDate: DateTime.now(), dataAlarmCycleBase: DATA_ALARM_CYCLE_HWUS(),);
  // print("test nextAlarmTime -> $nextAlarmTime");
  // DateTime? nextAlarmTime = Utils.findNextAlarmDate(alarmDays: [true, true, true, true, true, true, true, true],  targetTime: const TimeOfDay(hour: 07, minute: 08), currentDate: DateTime.now(), dataAlarmCycleBase: DATA_ALARM_CYCLE_HWMS(),);
  // print("test nextAlarmTime -> $nextAlarmTime");

  // Future<void> savePublicBreakoutDays() async {
    await Get.getFirebaseProvider().init();
    final userEmail = Get.getFirebaseProvider().currentUserEmail ?? '';
    /// Breakout Days Default Data (Harvard Westlake Upper School 2025-2026)
    // final publicDays = [
    //   // ===== National Holidays =====
    //   {'name': 'Labor Day', 'date': '2025-09-01'},
    //   {'name': 'Rosh Hashanah', 'date': '2025-09-23'},
    //   {'name': 'Yom Kippur', 'date': '2025-10-02'},
    //   {'name': 'Martin Luther King Jr. Day', 'date': '2026-01-19'},
    //   {'name': 'Presidents Day', 'date': '2026-02-16'},
    //   {'name': 'Lunar New Year', 'date': '2026-02-17'},
    //   {'name': 'Memorial Day', 'date': '2026-05-25'},
    //
    //   // ===== School Holidays (Thanksgiving + Winter + Spring Break) =====
    //   {'name': 'Thanksgiving Break', 'date': '2025-11-24'},
    //   {'name': 'Thanksgiving Break', 'date': '2025-11-25'},
    //   {'name': 'Thanksgiving Break', 'date': '2025-11-26'},
    //   {'name': 'Thanksgiving Break', 'date': '2025-11-27'},
    //   {'name': 'Thanksgiving Break', 'date': '2025-11-28'},
    //
    //   {'name': 'Winter Break', 'date': '2025-12-22'},
    //   {'name': 'Winter Break', 'date': '2025-12-23'},
    //   {'name': 'Winter Break', 'date': '2025-12-24'},
    //   {'name': 'Winter Break', 'date': '2025-12-25'},
    //   {'name': 'Winter Break', 'date': '2025-12-26'},
    //   {'name': 'Winter Break', 'date': '2025-12-29'},
    //   {'name': 'Winter Break', 'date': '2025-12-30'},
    //   {'name': 'Winter Break', 'date': '2025-12-31'},
    //   {'name': 'Winter Break', 'date': '2026-01-01'},
    //   {'name': 'Winter Break', 'date': '2026-01-02'},
    //
    //   {'name': 'Spring Break', 'date': '2026-03-23'},
    //   {'name': 'Spring Break', 'date': '2026-03-24'},
    //   {'name': 'Spring Break', 'date': '2026-03-25'},
    //   {'name': 'Spring Break', 'date': '2026-03-26'},
    //   {'name': 'Spring Break', 'date': '2026-03-27'},
    //   {'name': 'Spring Break', 'date': '2026-03-30'},
    //   {'name': 'Spring Break', 'date': '2026-03-31'},
    //   {'name': 'Spring Break', 'date': '2026-04-01'},
    //   {'name': 'Spring Break', 'date': '2026-04-02'},
    //   {'name': 'Spring Break', 'date': '2026-04-03'},
    //
    //   // ===== School Other No Cycle Days =====
    //   {'name': 'Convocation', 'date': '2025-08-25'},
    //   {'name': 'PSAT', 'date': '2025-10-15'},
    //   {'name': 'Break', 'date': '2025-10-16'},
    //   {'name': 'Break', 'date': '2025-10-17'},
    //   {'name': 'FLEX', 'date': '2025-10-29'},
    //   {'name': 'Professional Development', 'date': '2025-11-07'},
    //   {'name': 'FLEX', 'date': '2025-12-10'},
    //   {'name': 'Professional Development', 'date': '2026-03-09'},
    //   {'name': 'FLEX', 'date': '2026-04-22'},
    //   {'name': 'FLEX', 'date': '2026-05-13'},
    //   {'name': 'Exams', 'date': '2026-05-29'},
    //   {'name': 'Exams', 'date': '2026-06-01'},
    //   {'name': 'Exams', 'date': '2026-06-02'},
    //   {'name': 'Exams', 'date': '2026-06-03'},
    //   {'name': 'Break', 'date': '2026-06-04'},
    //   {'name': 'Commencement', 'date': '2026-06-05'},
    // ];

    await Get.getFirebaseProvider().uploadPublicBreakoutDays(
      days: publicDaysMap,
      updatedBy: userEmail,
    );
  // }

}