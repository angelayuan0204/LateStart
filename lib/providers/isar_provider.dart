import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/alarm_model.dart';
import '../models/calendar_event_model.dart';
import '../utils/utils.dart';

class IsarDb {

  static final IsarDb _instance = IsarDb._internal();
  late Future<Isar> db;

  factory IsarDb() {
    return _instance;
  }

  IsarDb._internal() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [AlarmModelSchema, CalendarEventModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<Database?> getAlarmSQLiteDatabase() async {
    Database? db;

    final dir = await getDatabasesPath();
    final dbPath = '$dir/alarms.db';
    db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }

  static Future<void> updateAlarm(AlarmModel alarmRecord) async {
    final isarProvider = IsarDb();
    final sql = await IsarDb().getAlarmSQLiteDatabase();
    final db = await isarProvider.db;
    await db.writeTxn(() async {
      await db.alarmModels.put(alarmRecord);
    });
    await sql!.update(
      'alarms',
      alarmRecord.toSQFliteMap(),
      where: 'alarmID = ?',
      whereArgs: [alarmRecord.alarmID],
    );
  }

  static Future<AlarmModel> addAlarm(AlarmModel alarmRecord) async {
    final isarProvider = IsarDb();
    final sql = await IsarDb().getAlarmSQLiteDatabase();
    final db = await isarProvider.db;
    await db.writeTxn(() async {
      await db.alarmModels.put(alarmRecord);
    });
    final sqlmap = alarmRecord.toSQFliteMap();
    await sql!.insert('alarms', sqlmap);
    return alarmRecord;
  }

  void _onCreate(Database db, int version) async {
    // Create tables for alarms and ringtones (modify column types as needed)
    await db.execute('''
      CREATE TABLE alarms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        alarmTime TEXT NOT NULL,
        alarmID TEXT NOT NULL UNIQUE,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        minutesSinceMidnight INTEGER NOT NULL,
        days TEXT NOT NULL,
        label TEXT,
        assetAudioPath TEXT,
        loopAudio INTEGER,
        vibrate INTEGER,
        volume TEXT,
        fadeDuration INTEGER NOT NULL DEFAULT 0,
        notificationTitle TEXT,
        notificationBody TEXT,
        enableNotificationOnKill INTEGER,
        androidFullScreenIntent INTEGER,
        type INTEGER NOT NULL DEFAULT 0,
        alarmSettingsId INTEGER NOT NULL,
        alarmSettingsDateTime TEXT DEFAULT NULL,
        alarmNextDateTime TEXT DEFAULT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE calendar_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eventName TEXT NOT NULL,
        title TEXT,
        description TEXT,
        calendarDate TEXT NOT NULL,
        start TEXT NOT NULL,
        end TEXT NOT NULL,
        alarmDateTime TEXT,
        isAlarmOpen INTEGER NOT NULL DEFAULT 0,
        alarmBeforeValue TEXT
      )
    ''');
    // await db.execute('''
    //   CREATE TABLE ringtones (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     ringtoneName TEXT NOT NULL,
    //     ringtonePath TEXT NOT NULL,
    //     currentCounterOfUsage INTEGER NOT NULL DEFAULT 0
    //   )
    // ''');
  }

  static Future<List<AlarmModel>> getAlarms() async {
    try {
      final isarProvider = IsarDb();
      final db = await isarProvider.db;
      return db.alarmModels.where().findAll();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<AlarmModel> getLatestAlarm(AlarmModel alarmRecord, bool wantNextAlarm) async {
    int nowInMinutes = 0;
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    if (wantNextAlarm == true) {
      nowInMinutes = Utils.timeOfDayToInt(
        TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute + 1,
        ),
      );
    } else {
      nowInMinutes = Utils.timeOfDayToInt(
        TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute,
        ),
      );
    }

    // Get all enabled alarms
    List<AlarmModel> alarms = await db.alarmModels.where().filter().isEnabledEqualTo(true).findAll();

    if (alarms.isEmpty) {
      alarmRecord.minutesSinceMidnight = -1;
      return alarmRecord;
    } else {
      AlarmModel closestAlarm = alarms.reduce((a, b) {
        int aTimeUntilNextAlarm = a.minutesSinceMidnight - nowInMinutes;
        int bTimeUntilNextAlarm = b.minutesSinceMidnight - nowInMinutes;

        bool aRepeats = a.days.any((day) => day);
        bool bRepeats = b.days.any((day) => day);

        if (!aRepeats && aTimeUntilNextAlarm < 0) {
          aTimeUntilNextAlarm += Duration.minutesPerDay;
        }
        if (!bRepeats && bTimeUntilNextAlarm < 0) {
          bTimeUntilNextAlarm += Duration.minutesPerDay;
        }

        if (aRepeats) {
          int currentDay = DateTime.now().weekday - 1;
          for (int i = 0; i < a.days.length; i++) {
            int dayIndex = (currentDay + i) % a.days.length;
            if (a.days[dayIndex]) {
              aTimeUntilNextAlarm += i * Duration.minutesPerDay;
              break;
            }
          }
        }

        if (bRepeats) {
          int currentDay = DateTime.now().weekday - 1;
          for (int i = 0; i < b.days.length; i++) {
            int dayIndex = (currentDay + i) % b.days.length;
            if (b.days[dayIndex]) {
              bTimeUntilNextAlarm += i * Duration.minutesPerDay;
              break;
            }
          }
        }

        return aTimeUntilNextAlarm < bTimeUntilNextAlarm ? a : b;
      });
      return closestAlarm;
    }
  }

  static Future<void> deleteAlarm(int id) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    final sql = await IsarDb().getAlarmSQLiteDatabase();
    final tobedeleted = await db.alarmModels.get(id);
    await db.writeTxn(() async {
      await db.alarmModels.delete(id);
    });
    await sql!.delete(
      'alarms',
      where: 'alarmID = ?',
      whereArgs: [tobedeleted!.alarmID],
    );
  }

  // static Future<RingtoneModel?> getCustomRingtone({required int customRingtoneId}) async {
  //   try {
  //     final isarProvider = IsarDb();
  //     final db = await isarProvider.db;
  //     final query = db.ringtoneModels
  //         .where()
  //         .filter()
  //         .isarIdEqualTo(customRingtoneId)
  //         .findFirst();
  //
  //     return query;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return null;
  //   }
  // }

  // static Future<void> addCustomRingtone(RingtoneModel customRingtone) async {
  //   try {
  //     final isarProvider = IsarDb();
  //     final db = await isarProvider.db;
  //     await db.writeTxn(() async {
  //       await db.ringtoneModels.put(customRingtone);
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static Future<bool> doesAlarmExist(String alarmID) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    final alarms = await db.alarmModels.where().filter().alarmIDEqualTo(alarmID).findAll();
    return alarms.isNotEmpty;
  }

  static Future<AlarmModel?> findByAlarmSettingsId(int alarmSettingsId) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    final alarms = await db.alarmModels.where().filter().alarmSettingsIdEqualTo(alarmSettingsId).findAll();
    if (alarms.isNotEmpty) {
      return alarms.first;
    }
    return null;
  }

  static Future<List<AlarmModel>?> findSameAlarms(String alarmSettingsDateTime, int alarmSettingsId) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    List<AlarmModel> alarms = await db.alarmModels.where().filter().alarmSettingsDateTimeEqualTo(alarmSettingsDateTime).isEnabledEqualTo(true).findAll();
    alarms = alarms.where((e) => e.alarmSettingsId != alarmSettingsId).toList();
    if (alarms.isNotEmpty) {
      return Future.value(alarms);
    }
    return null;
  }

  static Future<CalendarEventModel?> addOrUpdateCalendarEvent(CalendarEventModel event) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    return await db.writeTxn(() async {
      int id = await db.calendarEventModels.put(event);
      event.id = id;
      return event;
    });
  }

  static Future<List<CalendarEventModel>> getCalendarEvents() async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    return await db.calendarEventModels.where().findAll();
  }

  // static Future<List<CalendarEventModel>> getAlarmOpenCalendarEvents() async {
  //   final isarProvider = IsarDb();
  //   final db = await isarProvider.db;
  //   return await db.calendarEventModels.where().filter().isAlarmOpenEqualTo(true).findAll();
  // }

  static Future<CalendarEventModel?> getCalendarEventById(int id) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    return await db.calendarEventModels.get(id);
  }

  static Future<void> deleteCalendarEvent(int id) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    await db.writeTxn(() async {
      await db.calendarEventModels.delete(id);
    });
  }

  static Future<bool> doesCalendarEventExist(String eventName) async {
    final isarProvider = IsarDb();
    final db = await isarProvider.db;
    final events = await db.calendarEventModels.where().filter().eventNameEqualTo(eventName).findAll();
    return events.isNotEmpty;
  }

  static Future<List<CalendarEventModel>> getEventsByCalendarDate(DateTime calendarDate) async {
    final db = await IsarDb().db;
    List<CalendarEventModel> eventsByCalendarDate = await db.calendarEventModels
        .where()
        .filter()
        //calendarDate为utc 日期结尾有z，数据库保存的data日期结尾不带z，所以需要匹配一下
        .calendarDateEqualTo(DateTime(calendarDate.year, calendarDate.month, calendarDate.day, 0, 0, 0))
        .findAll();
    List<CalendarEventModel> repeatEventsByDate = await queryRepeatEventsByDate(calendarDate);
    return [...eventsByCalendarDate, ...repeatEventsByDate];
  }

  static Future<List<CalendarEventModel>> getEventsByCalendarMonth(DateTime calendarDate) async {
    final db = await IsarDb().db;
    DateTime firstDayOfMonth = DateTime(calendarDate.year, calendarDate.month, calendarDate.day, 0, 0, 0);
    DateTime lastDayOfMonth = DateTime(calendarDate.year, calendarDate.month + 1, 0, 23, 59, 59);
    List<CalendarEventModel> eventsByCalendarDate = await db.calendarEventModels
        .where()
        .filter()
        .calendarDateBetween(firstDayOfMonth, lastDayOfMonth)
        .findAll();
    List<CalendarEventModel> repeatEventsByDate = await queryRepeatEventsByMonth(DateTime(calendarDate.year, calendarDate.month, calendarDate.day, 0, 0, 0), lastDayOfMonth);
    for (var item in eventsByCalendarDate) {
      item.description = DateFormat('yyyy-MM-dd').format(item.calendarDate);
    }
    return [...eventsByCalendarDate, ...repeatEventsByDate];
  }

  static Future<List<CalendarEventModel>> queryRepeatEventsByDate(DateTime date) async {
    final isar = await IsarDb().db;
    // 匹配repeat周
    final weeklyCandidates = await isar.calendarEventModels
        .filter()
        .repeatOptionEqualTo('Weekly')
        .calendarDateLessThan(date, include: false)
        .findAll();
    final eventsWeekly = weeklyCandidates.where((event) {
      return event.calendarDate.weekday == date.weekday;
    }).toList();

    // 匹配repeat月
    final monthlyCandidates = await isar.calendarEventModels
        .filter()
        .repeatOptionEqualTo('Month')
        .calendarDateLessThan(date, include: false)
        .findAll();
    final eventsMonthly = monthlyCandidates.where((event) {
      if (event.calendarDate.day == date.day) return true;
      // 如果原始日为29、30或31，且当前月份没有该天，则当传入日期为该月最后一天时也算匹配
      if (event.calendarDate.day >= 29) {
        DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
        if (date.day == lastDayOfMonth.day && lastDayOfMonth.day < event.calendarDate.day) {
          return true;
        }
      }
      return false;
    }).toList();

    return [...eventsWeekly, ...eventsMonthly];
  }

  static Future<List<CalendarEventModel>> queryRepeatEventsByMonth(DateTime startOfMonth, DateTime endOfMonth) async {
    final isar = await IsarDb().db;

    // 获取所有在当前月份之前创建的重复事件
    final weeklyCandidates = await isar.calendarEventModels
        .filter()
        .repeatOptionEqualTo('Weekly')
        .calendarDateLessThan(endOfMonth, include: false)
        .findAll();

    final monthlyCandidates = await isar.calendarEventModels
        .filter()
        .repeatOptionEqualTo('Month')
        .calendarDateLessThan(endOfMonth, include: false)
        .findAll();

    // 按照当前月份匹配周重复事件
    List<CalendarEventModel> eventsWeekly = [];
    for (var event in weeklyCandidates) {
      DateTime eventDate = event.calendarDate;
      // 计算当前月所有符合该事件的星期几的日期
      for (int i = 0; i < 31; i++) {
        DateTime potentialDate = DateTime(startOfMonth.year, startOfMonth.month, startOfMonth.day + i, startOfMonth.hour, startOfMonth.minute, startOfMonth.second);//startOfMonth.add(Duration(days: i));
        if (potentialDate.isAfter(endOfMonth)) break;
        if (potentialDate.weekday == eventDate.weekday && potentialDate.isAfter(eventDate)) {
          eventsWeekly.add(event.copyWith(description: DateFormat('yyyy-MM-dd').format(potentialDate)));
        }
      }
    }

    // 按照当前月份匹配月重复事件
    List<CalendarEventModel> eventsMonthly = [];
    for (var event in monthlyCandidates) {
      DateTime eventDate = event.calendarDate;
      if (eventDate.day <= endOfMonth.day) {
        if (DateTime(startOfMonth.year, startOfMonth.month, eventDate.day).isAfter(eventDate)) {
          eventsMonthly.add(event.copyWith(description: DateFormat('yyyy-MM-dd').format(DateTime(startOfMonth.year, startOfMonth.month, eventDate.day))));
        }
      } else {
        // 处理 29、30、31 号的特殊情况
        DateTime lastDayOfMonth = DateTime(endOfMonth.year, endOfMonth.month + 1, 0);
        if (eventDate.day >= 29 && lastDayOfMonth.day < eventDate.day) {
          eventsMonthly.add(event.copyWith(description: DateFormat('yyyy-MM-dd').format(DateTime(startOfMonth.year, startOfMonth.month, endOfMonth.day))));
        }
      }
    }
    return [...eventsWeekly, ...eventsMonthly];
  }

  //计算下一次闹钟
  static Future<DateTime> getComputedAlarmTime(CalendarEventModel e) async {
    final DateTime now = DateTime.now();
    DateTime computedAlarmTime;

    if (e.repeatOption == 'Weekly' || e.repeatOption == 'Month') {
      List<CalendarEventModel> todayEvents = await queryRepeatEventsByDate(now);
      bool occursToday = todayEvents.any((event) => event.id == e.id);
      if (!occursToday && (e.repeatOption == 'Weekly' && now.weekday == e.calendarDate.weekday)||(e.repeatOption == 'Month' && now.day == e.calendarDate.day)) {
        occursToday = true;
      }
      if (occursToday) {
        computedAlarmTime = DateTime(
          now.year,
          now.month,
          now.day,
          e.alarmDateTime?.hour??e.start.hour,
          e.alarmDateTime?.minute??e.start.minute,
          e.alarmDateTime?.second??e.start.minute,
        );
        if (computedAlarmTime.isBefore(now)) {
          computedAlarmTime = _computeNextOccurrence(e, now);
        }
      } else {
        computedAlarmTime = _computeNextOccurrence(e, now);
      }
    } else {
      computedAlarmTime = e.alarmDateTime??e.start;
    }
    return computedAlarmTime;
  }

  /// 计算重复事件的下一次发生日期（基于当前时间 from）
  static DateTime _computeNextOccurrence(CalendarEventModel e, DateTime from) {
    if (e.repeatOption == 'Weekly') {
      int daysToAdd = (e.calendarDate.weekday - from.weekday) % 7;
      if (daysToAdd == 0) {
        daysToAdd = 7;
      }
      DateTime candidate = DateTime(
        from.year,
        from.month,
        from.day + daysToAdd,
        e.alarmDateTime?.hour??e.start.hour,
        e.alarmDateTime?.minute??e.start.minute,
        e.alarmDateTime?.second??e.start.second,
      );
      return candidate;
    } else if (e.repeatOption == 'Month') {
      int day = e.calendarDate.day;
      // 计算当前月的最后一天
      int lastDayCurrentMonth = DateTime(from.year, from.month + 1, 0).day;
      // 如果当前月不存在该日期，则取最后一天
      int candidateDay = day <= lastDayCurrentMonth ? day : lastDayCurrentMonth;
      DateTime candidate = DateTime(
        from.year,
        from.month,
        candidateDay,
        e.alarmDateTime?.hour??e.start.hour,
        e.alarmDateTime?.minute??e.start.minute,
        e.alarmDateTime?.second??e.start.second,
      );
      // 如果候选时间已过，则计算下个月的候选日期
      if (candidate.isBefore(from)) {
        int nextMonth = from.month == 12 ? 1 : from.month + 1;
        int nextYear = from.month == 12 ? from.year + 1 : from.year;
        int lastDayNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
        candidateDay = day <= lastDayNextMonth ? day : lastDayNextMonth;
        candidate = DateTime(
          nextYear,
          nextMonth,
          candidateDay,
          e.alarmDateTime?.hour??e.start.hour,
          e.alarmDateTime?.minute??e.start.minute,
          e.alarmDateTime?.second??e.start.second,
        );
      }
      return candidate;
    } else {
      return e.alarmDateTime!;
    }
  }


}