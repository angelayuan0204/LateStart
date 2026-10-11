import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:late_start/base/app_get.dart';

import '../models/alarm_model.dart';
import '../providers/isar_provider.dart';
import '../utils/utils.dart';

class AlarmsController extends GetxController {
  MethodChannel alarmChannel = const MethodChannel('lsclock');

  ScrollController scrollController = ScrollController();
  RxDouble scalingFactor = 1.0.obs;
  final alarmTime = 'No upcoming alarms!'.obs;
  bool refreshTimer = false;
  int lastRefreshTime = DateTime.now().millisecondsSinceEpoch;
  Timer? delayToSchedule;
  Timer _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {});
  Timer? _delayTimer;

  RxList<AlarmModel> latestIsarAlarms = RxList(<AlarmModel>[]);

  RxBool isSortedAlarmListEnabled = true.obs;

  @override
  void onInit() async {
    super.onInit();

    // isSortedAlarmListEnabled.value = await SecureStorageProvider()
    //     .readSortedAlarmListValue(key: 'sorted_alarm_list');

    scrollController.addListener(() {
      final offset = scrollController.offset;
      const maxOffset = 100.0;
      const minFactor = 0.8;
      const maxFactor = 1.0;

      final newFactor = 1.0 - (offset / maxOffset).clamp(0.0, 1.0);
      scalingFactor.value = (minFactor + (maxFactor - minFactor) * newFactor);
      update();
    });
  }

  initLatestIsarAlarms({bool needRefreshAlarm = false}) async {
    List<AlarmModel> isarStreamAlarms = await IsarDb.getAlarms();
    if (needRefreshAlarm) {
      isarStreamAlarms =
          await Get.getAppController().refreshAllAlarms(isarStreamAlarms);
    }
    if (isSortedAlarmListEnabled.value) {
      isarStreamAlarms.sort((a, b) {
        final String timeA = a.alarmTime;
        final String timeB = b.alarmTime;

        DateTime dateTimeA = DateFormat('HH:mm').parse(timeA);
        DateTime dateTimeB = DateFormat('HH:mm').parse(timeB);

        return dateTimeA.compareTo(dateTimeB);
      });
    } else {
      isarStreamAlarms.sort((a, b) {
        if (a.isEnabled != b.isEnabled) {
          return a.isEnabled ? -1 : 1;
        }

        int aUpcomingTime = a.minutesSinceMidnight;
        int bUpcomingTime = b.minutesSinceMidnight;

        bool aRepeats = a.days.any((day) => day);
        bool bRepeats = b.days.any((day) => day);

        if (aRepeats) {
          int currentDay = DateTime.now().weekday - 1;
          for (int i = 0; i < a.days.length; i++) {
            int dayIndex = (currentDay + i) % a.days.length;
            if (a.days[dayIndex]) {
              aUpcomingTime += i * Duration.minutesPerDay;
              break;
            }
          }
        } else {
          if (aUpcomingTime <=
              DateTime.now().hour * 60 + DateTime.now().minute) {
            aUpcomingTime += Duration.minutesPerDay;
          }
        }

        if (bRepeats) {
          int currentDay = DateTime.now().weekday - 1;
          for (int i = 0; i < b.days.length; i++) {
            int dayIndex = (currentDay + i) % b.days.length;
            if (b.days[dayIndex]) {
              bUpcomingTime += i * Duration.minutesPerDay;
              break;
            }
          }
        } else {
          if (bUpcomingTime <=
              DateTime.now().hour * 60 + DateTime.now().minute) {
            bUpcomingTime += Duration.minutesPerDay;
          }
        }

        return aUpcomingTime.compareTo(bUpcomingTime);
      });
    }
    List<AlarmModel> eventsToAlarmModels = await Get.getCalendarController().calendarEventModelsToAlarmModels();
    eventsToAlarmModels.sort((a, b) {
      if (a.isEnabled != b.isEnabled) {
        return b.isEnabled ? 1 : -1;
      }
      final String timeA = a.alarmTime;
      final String timeB = b.alarmTime;

      DateTime dateTimeA = DateTime.parse(timeA);
      DateTime dateTimeB = DateTime.parse(timeB);

      return dateTimeA.compareTo(dateTimeB);
    });
    isarStreamAlarms.addAll(eventsToAlarmModels);
    latestIsarAlarms.value = isarStreamAlarms;
    update();
  }

  refreshUpcomingAlarms() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastRefreshTime < 2000) {
      delayToSchedule?.cancel();
    }

    if (delayToSchedule != null && delayToSchedule!.isActive) {
      update();
      return;
    }

    delayToSchedule = Timer(const Duration(seconds: 1), () async {
      lastRefreshTime = DateTime.now().millisecondsSinceEpoch;
      // Cancel timer if we have to refresh
      if (refreshTimer == true) {
        if (_timer.isActive) _timer.cancel();
        if (_delayTimer != null) _delayTimer?.cancel();
        refreshTimer = false;
      }

      // Fake object to get latest alarm
      AlarmModel alarmRecord = Utils.genFakeAlarmModel();
      AlarmModel isarLatestAlarm =
          await IsarDb.getLatestAlarm(alarmRecord, true);

      AlarmModel latestAlarm = isarLatestAlarm;

      debugPrint('ISAR: ${isarLatestAlarm.alarmTime}');

      String timeToAlarm = Utils.timeUntilAlarm(
        Utils.stringToTimeOfDay(latestAlarm.alarmTime),
        latestAlarm.days,
      );
      alarmTime.value = 'Rings in $timeToAlarm';
      // This function is necessary when alarms are deleted/enabled
      await scheduleNextAlarm(alarmRecord, isarLatestAlarm);

      if (latestAlarm.minutesSinceMidnight > -1) {
        // To account for difference between seconds upto the next minute
        DateTime now = DateTime.now();
        DateTime nextMinute =
            DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
        Duration delay = nextMinute.difference(now).inMilliseconds > 0
            ? nextMinute.difference(now)
            : Duration.zero;
        _delayTimer = Timer(delay, () {
          timeToAlarm = Utils.timeUntilAlarm(
            Utils.stringToTimeOfDay(latestAlarm.alarmTime),
            latestAlarm.days,
          );
          alarmTime.value = 'Rings in $timeToAlarm';

          _timer = Timer.periodic(
              Duration(
                milliseconds: Utils.getMillisecondsToAlarm(
                  DateTime.now(),
                  DateTime.now().add(const Duration(minutes: 1)),
                ),
              ), (timer) {
            timeToAlarm = Utils.timeUntilAlarm(
              Utils.stringToTimeOfDay(latestAlarm.alarmTime),
              latestAlarm.days,
            );
            alarmTime.value = 'Rings in $timeToAlarm';
          });
        });
      } else {
        alarmTime.value = 'No upcoming alarms!';
      }
      update();
    });
  }

  scheduleNextAlarm(
    AlarmModel alarmRecord,
    AlarmModel latestAlarm,
  ) async {
    TimeOfDay latestAlarmTimeOfDay =
        Utils.stringToTimeOfDay(latestAlarm.alarmTime);
    if (latestAlarm.isEnabled == false) {
      debugPrint(
        'STOPPED IF CONDITION with latest = ${latestAlarmTimeOfDay.toString()}',
      );
      await alarmChannel.invokeMethod('cancelAllScheduledAlarms');
    } else {
      // int intervalToAlarm = Utils.getMillisecondsToAlarm(DateTime.now(), Utils.timeOfDayToDateTime(latestAlarmTimeOfDay),);
      try {
        // await alarmChannel.invokeMethod('scheduleAlarm', {'milliSeconds': intervalToAlarm, 'activityMonitor': 1/*latestAlarm.activityMonitor*/,});
        debugPrint("Scheduled...");
      } on PlatformException catch (e) {
        debugPrint("Failed to schedule alarm: ${e.message}");
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (delayToSchedule != null) {
      delayToSchedule!.cancel();
      update();
    }
  }
}
