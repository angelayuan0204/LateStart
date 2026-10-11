import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../datas/data_alarm_cycle_base.dart';
import '../models/alarm_model.dart';

class Utils {

  static String timeOfDayToString(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  static AlarmModel genFakeAlarmModel() {
    return AlarmModel(
      alarmTime: timeOfDayToString(TimeOfDay.now()),
      alarmID: '', minutesSinceMidnight: timeOfDayToInt(TimeOfDay.now()),
      days: [false, false, false, false, false, false, false],
      label: '',
      assetAudioPath: 'assets/medias/marimba.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 0,
      notificationTitle: '',
      notificationBody: '',
      enableNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      type: 0,
      alarmSettingsId: DateTime.now().millisecondsSinceEpoch % 10000 + 1
    );
  }

  static int timeOfDayToInt(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  static String timeUntilAlarm(TimeOfDay alarmTime, List<bool> days) {
    final now = DateTime.now();
    final todayAlarm = DateTime(
      now.year,
      now.month,
      now.day,
      alarmTime.hour,
      alarmTime.minute,
    );

    Duration duration;

    if (days.every((day) => !day)) {
      if (now.isBefore(todayAlarm)) {
        duration = todayAlarm.difference(now);
      } else {
        final nextAlarm = todayAlarm.add(const Duration(days: 1));
        duration = nextAlarm.difference(now);
      }
    } else if (now.isBefore(todayAlarm) && days[now.weekday - 1]) {
      duration = todayAlarm.difference(now);
    } else {
      int daysUntilNextAlarm = 7;
      DateTime? nextAlarm;

      for (int i = 1; i <= 7; i++) {
        int nextDayIndex = (now.weekday + i - 1) % 7;

        if (nextDayIndex < days.length && days[nextDayIndex]) {
          if (i < daysUntilNextAlarm) {
            daysUntilNextAlarm = i;
            nextAlarm = DateTime(
              now.year,
              now.month,
              now.day + i,
              alarmTime.hour,
              alarmTime.minute,
            );
          }
        }
      }

      if (nextAlarm != null) {
        duration = nextAlarm.difference(now);
      } else {
        return 'No upcoming alarms';
      }
    }

    if (duration.inMinutes < 1) {
      return 'less than 1 minute';
    } else if (duration.inHours < 24) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      if (hours == 0) {
        return minutes == 1 ? '$minutes minute' : '$minutes minutes';
      } else if (minutes == 0) {
        return hours == 1 ? '$hours hour' : '$hours hours';
      } else if (hours == 1) {
        return minutes == 1
            ? '$hours hour $minutes minute'
            : '$hours hour $minutes minutes';
      } else {
        return '$hours hour $minutes minutes';
      }
    } else if (duration.inDays == 1) {
      return '1 day';
    } else {
      return '${duration.inDays} days';
    }
  }

  static TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static int getMillisecondsToAlarm(DateTime now, DateTime alarmTime) {
    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    int milliseconds = alarmTime.difference(now).inMilliseconds;
    return milliseconds;
  }

  static DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static String getRepeatDays(List<bool> days) {
    List dayAbbreviations = [
      'Mon'.tr,
      'Tue'.tr,
      'Wed'.tr,
      'Thu'.tr,
      'Fri'.tr,
      'Sat'.tr,
      'Sun'.tr
    ];
    int weekdayCount = 0;
    int weekendCount = 0;
    List<String> selectedDays = [];

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        if (i < 5) {
          weekdayCount++;
        } else {
          weekendCount++;
        }
        selectedDays.add(dayAbbreviations[i]);
      }
    }

    if (weekdayCount + weekendCount == 7) {
      return 'Everyday'.tr;
    } else if (weekdayCount == 5 && weekendCount == 0) {
      return 'Weekday'.tr;
    } else if (weekendCount == 2 && weekdayCount == 0) {
      return 'Weekend'.tr;
    } else if (selectedDays.isEmpty) {
      return 'Never'.tr;
    } else {
      return selectedDays.join(', ');
    }
  }

  static String getRepeatCycleDays(List<bool> days) {
    // List dayAbbreviations = [
    //   'HW US DAY1'.tr,
    //   'HW US DAY2'.tr,
    //   'HW US DAY3'.tr,
    //   'HW US DAY4'.tr,
    //   'HW US DAY5'.tr,
    //   'HW US DAY6'.tr
    // ];
    List<String> dayAbbreviations = List.generate(
      days.length,
          (index) => 'HW US DAY${index + 1}'.tr,
    );
    List<String> selectedDays = [];

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        selectedDays.add(dayAbbreviations[i].split(' ')[2]);
      }
    }
    return selectedDays.join(', ');
  }

  static List<String> split24HourFormat(String time) {
    String hour = time.substring(0, 2);
    String minute = time.substring(3);
    return ['$hour:$minute', ''];
  }

  static List<String> convertTo12HourFormat(String time) {
    int hour = int.parse(time.substring(0, 2));
    String minute = time.substring(3);
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }

    return ['$hour:$minute', period];
  }

  static DateTime getNextAlarmTimeForWeekly(int targetWeekday, TimeOfDay targetTime) {
    DateTime now = DateTime.now();

    DateTime targetDateTime = DateTime(now.year, now.month, now.day, targetTime.hour, targetTime.minute);

    int currentWeekday = now.weekday;

    int dayDiff = (targetWeekday - currentWeekday) % 7;

    if (dayDiff == 0 && now.isAfter(targetDateTime)) {
      dayDiff = 7;
    }

    DateTime nextAlarmDate = now.add(Duration(days: dayDiff));
    DateTime nextAlarmDateTime = DateTime(nextAlarmDate.year, nextAlarmDate.month, nextAlarmDate.day, targetTime.hour, targetTime.minute);

    return nextAlarmDateTime;
  }

  static DateTime? calculateNextAlarmTime(List<bool> days, TimeOfDay alarmTime) {
    // 获取当前的时间
    DateTime now = DateTime.now();

    // 获取当前的星期几，注意DateTime.weekday从1(周一)到7(周日)
    int currentWeekday = now.weekday;

    // 创建今天的闹钟时间
    DateTime todayAlarm = DateTime(
        now.year, now.month, now.day, alarmTime.hour, alarmTime.minute);

    // 如果今天有闹钟并且当前时间还没有到闹钟时间，则今天响铃
    if (days[currentWeekday - 1] && now.isBefore(todayAlarm)) {
      return todayAlarm;
    }

    // 遍历接下来的7天，寻找下一次响铃的时间
    for (int i = 1; i <= 7; i++) {
      // 计算下一个日期的星期几（0 = 今天，1 = 明天，依次类推）
      int nextDayIndex = (currentWeekday - 1 + i) % 7;

      // 如果该天需要响铃
      if (days[nextDayIndex]) {
        // 计算下一个日期
        DateTime nextAlarmDay = now.add(Duration(days: i));

        // 设置该日期的响铃时间
        return DateTime(
            nextAlarmDay.year, nextAlarmDay.month, nextAlarmDay.day,
            alarmTime.hour, alarmTime.minute);
      }
    }

    // 如果没有找到任何下次响铃时间（理论上不会到这里）
    return null;
  }

  static DateTime? findNextAlarmDate({required DataAlarmCycleBase dataAlarmCycleBase, required List<bool> alarmDays, required TimeOfDay targetTime}) {
    // 生成有效日期列表
    List<DateTime> validDates = [];
    DateTime date = dataAlarmCycleBase.startDate();
    Set<String> excludedDatesToStringSet = dataAlarmCycleBase.excludedDatesToStringSet();
    // Set<String> excludedDatesToStringSet = DaysHwMs.excludedDatesToStringSet();


    while (date.isBefore(dataAlarmCycleBase.endDate().add(const Duration(days: 1)))) {
      if (!excludedDatesToStringSet.contains(dataAlarmCycleBase.formattedDate(date))) {
        validDates.add(DateTime(date.year, date.month, date.day, targetTime.hour, targetTime.minute));
      }
      date = date.add(const Duration(days: 1));
    }

    DateTime now = DateTime.now();
    // 将currentDate的时间部分更新为targetTime
    // DateTime targetDateTime = DateTime(
    //   now.year,
    //   now.month,
    //   now.day,
    //   targetTime.hour,
    //   targetTime.minute,
    // );
    // DateTime targetDateTime = DateTime(
    //   dataAlarmCycleBase.startDate().year,
    //   dataAlarmCycleBase.startDate().month,
    //   dataAlarmCycleBase.startDate().day,
    //   targetTime.hour,
    //   targetTime.minute,
    // );

    // 找到第一个大于或等于targetDateTime的日期索引
    // int startIndex = validDates.indexWhere((d) => d.isAfter(targetDateTime) || d.isAtSameMomentAs(targetDateTime));
    // DateTime now = DateTime.now();
    // if (targetDateTime.isAfter(now)) {
    //   // 什么都不做，因为 indexWhere 会包含今天
    // } else {
    //   startIndex += 1; // 跳过今天，目标时间已过
    // }

    // if (DateTime(now.year, now.month, now.day, targetTime.hour, targetTime.minute,).isAfter(now)) {
    //   debugPrint('findNextAlarmDate 执行 -> 3：now1：${DateTime(now.year, now.month, now.day, targetTime.hour, targetTime.minute,).toString()}');
    //   startIndex = startIndex - 1;
    // }
    // int startIndex = validDates.indexWhere((d) => d.isAfter(targetDateTime) || d.isAtSameMomentAs(targetDateTime));
    int startIndex = validDates.indexWhere((d) => d.isAfter(now));
    if (startIndex < 0) {
      // 如果没有找到符合条件的日期，返回null
      return null;
    }
    // DateTime startIndexDateTime = DateTime(
    //   validDates[startIndex].year,
    //   validDates[startIndex].month,
    //   validDates[startIndex].day,
    //   targetTime.hour,
    //   targetTime.minute,
    // );
    // if (startIndexDateTime.year == now.year && startIndexDateTime.month == now.month && startIndexDateTime.day == now.day && now.isAfter(startIndexDateTime)) {
    //   startIndex = startIndex + 1;
    // }



    // 从找到的索引开始遍历寻找下一个闹钟日期
    for (int i = startIndex; i < validDates.length; i++) {
      DateTime nextAlarmDate = validDates[i];
      // 将日期时间部分更新为targetTime
      // nextAlarmDate = DateTime(nextAlarmDate.year, nextAlarmDate.month, nextAlarmDate.day, targetTime.hour, targetTime.minute,);

      // 找到对应的alarmDays索引
      int alarmDayIndex = i % alarmDays.length;
      if (alarmDays[alarmDayIndex]) {
        debugPrint('dateTime: ${nextAlarmDate.toString().split(' ')[0]}, Day${alarmDayIndex + 1}');
        return nextAlarmDate;
      }
    }
    // 如果没有找到符合条件的日期，则返回null
    return null;
  }


  // static DateTime? findNextAlarmDate({
  //   required DataAlarmCycleBase dataAlarmCycleBase,
  //   required List<bool> alarmDays,
  //   required TimeOfDay targetTime,
  //   required DateTime currentDate,
  // }) {
  //   final DateTime startDate = dataAlarmCycleBase.startDate();
  //   final DateTime endDate = dataAlarmCycleBase.endDate();
  //   final Set<String> excludedDates = dataAlarmCycleBase.excludedDatesToStringSet();
  //
  //   // 计算目标时间点（基于当前日期）
  //   final DateTime now = DateTime.now();
  //   // final DateTime todayTargetTime = DateTime(
  //   //   currentDate.year,
  //   //   currentDate.month,
  //   //   currentDate.day,
  //   //   targetTime.hour,
  //   //   targetTime.minute,
  //   // );
  //
  //   // 遍历开始的日期
  //   DateTime iterDate = startDate;
  //
  //   int cycleIndex = 0; // 用于与 alarmDays 对齐
  //   while (!iterDate.isAfter(endDate)) {
  //     final String dateStr = dataAlarmCycleBase.formattedDate(iterDate);
  //     if (!excludedDates.contains(dateStr)) {
  //       // 只处理有效的日期
  //       DateTime dateWithTime = DateTime(
  //         iterDate.year,
  //         iterDate.month,
  //         iterDate.day,
  //         targetTime.hour,
  //         targetTime.minute,
  //       );
  //
  //       bool isToday = iterDate.year == currentDate.year &&
  //           iterDate.month == currentDate.month &&
  //           iterDate.day == currentDate.day;
  //
  //       if (!isToday || dateWithTime.isAfter(now)) {
  //         // 只考虑今天未来时间，或未来日期
  //         int alarmDayIndex = cycleIndex % alarmDays.length;
  //         if (alarmDays[alarmDayIndex]) {
  //           debugPrint('dateTime: ${dateWithTime.toIso8601String()}, Day${alarmDayIndex + 1}');
  //           // return dateWithTime;
  //         }
  //       }
  //
  //       cycleIndex++;
  //     }
  //
  //     iterDate = iterDate.add(const Duration(days: 1));
  //   }
  //
  //   // 没找到
  //   return null;
  // }

  // static DateTime? findNextAlarmDate({required DateTime startDate, required DateTime endDate, required List<bool> alarmDays, required Set<DateTime> excludedDates, required TimeOfDay targetTime, required DateTime currentDate}) {
  //   // 生成有效日期列表
  //   List<DateTime> validDates = [];
  //   DateTime date = startDate;
  //   Set<String> excludedDatesToStringSet = DATA_ALARM_CYCLE_HWUS().excludedDatesToStringSet();
  //   // Set<String> excludedDatesToStringSet = DaysHwMs.excludedDatesToStringSet();
  //
  //
  //   while (date.isBefore(endDate.add(const Duration(days: 1)))) {
  //     if (!excludedDatesToStringSet.contains(DATA_ALARM_CYCLE_HWUS.formattedDate(date))) {
  //       validDates.add(DateTime(date.year, date.month, date.day));
  //     }
  //     date = date.add(const Duration(days: 1));
  //   }
  //
  //   // 将currentDate的时间部分更新为targetTime
  //   DateTime targetDateTime = DateTime(
  //     currentDate.year,
  //     currentDate.month,
  //     currentDate.day,
  //     targetTime.hour,
  //     targetTime.minute,
  //   );
  //
  //   // 找到第一个大于或等于targetDateTime的日期索引
  //   int startIndex = validDates.indexWhere((d) => d.isAfter(targetDateTime) || d.isAtSameMomentAs(targetDateTime));
  //
  //   DateTime now = DateTime.now();
  //   if (DateTime(now.year, now.month, now.day, targetTime.hour, targetTime.minute,).isAfter(now)) {
  //     startIndex = startIndex - 1;
  //   }
  //
  //   if (startIndex == -1) {
  //     // 如果没有找到符合条件的日期，返回null
  //     return null;
  //   }
  //
  //   // 从找到的索引开始遍历寻找下一个闹钟日期
  //   for (int i = startIndex; i < validDates.length; i++) {
  //     DateTime nextAlarmDate = validDates[i];
  //     // 将日期时间部分更新为targetTime
  //     nextAlarmDate = DateTime(nextAlarmDate.year, nextAlarmDate.month, nextAlarmDate.day, targetTime.hour, targetTime.minute,);
  //
  //     // 找到对应的alarmDays索引
  //     int alarmDayIndex = i % alarmDays.length;
  //     if (alarmDays[alarmDayIndex]) {
  //       debugPrint('dateTime: ${nextAlarmDate.toString().split(' ')[0]}, Day${alarmDayIndex + 1}');
  //       return nextAlarmDate;
  //     }
  //   }
  //
  //   // 如果没有找到符合条件的日期，则返回null
  //   return null;
  // }

  static bool isWithinOneMinute(DateTime targetTime) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(targetTime).abs();

    // 判断差值是否小于或等于 1 分钟
    return difference.inMinutes <= 1;
  }

  static String getEventLabelName(String label) {
    final match = RegExp(r'name:([^&]+)$').firstMatch(label);
    if (match != null) {
      return match.group(1)!;
    }
    return 'Event';
  }

  static String formatAlarmDateTime(String? rawDateTimeStr) {
    try {
      if (rawDateTimeStr == null || rawDateTimeStr.trim().isEmpty) {
        return '-'; // 或者返回你希望的默认值
      }

      // 移除末尾的 ':00.000'，如果存在
      final cleaned = rawDateTimeStr.replaceAll(':00.000', '');

      // 解析字符串为 DateTime 对象
      final dateTime = DateTime.parse(cleaned);

      // 格式化为 "MM-dd-yyyy HH:mm"
      final formatter = DateFormat("MM-dd-yyyy HH:mm");
      return formatter.format(dateTime);
    } catch (e) {
      // 如果解析失败，返回默认值或错误提示
      return '-';
    }
  }


}