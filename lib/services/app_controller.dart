import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/models/alarm_model.dart';

import '../datas/data_alarm_cycle_base.dart';
import '../providers/get_storage_provider.dart';
import '../providers/isar_provider.dart';
import '../utils/utils.dart';

class AppController extends GetxController {

  Future<void> setAlarm(AlarmModel alarmModel, {bool isCycleDayForNext = false}) async {
    DateTime dateTime;
    if (alarmModel.type != 4) {
      dateTime = Utils.timeOfDayToDateTime(Utils.stringToTimeOfDay(alarmModel.alarmTime));
      alarmModel.alarmSettingsId = DateTime.now().millisecondsSinceEpoch % 10000 + 1;
    } else {
      dateTime = DateTime.parse(alarmModel.alarmTime);
    }
    debugPrint('An AlarmModel：${alarmModel.toString()}, and dateTime:$dateTime');
    switch (alarmModel.type) {
      case 0:
        if (dateTime.isBefore(DateTime.now())) {
          dateTime = dateTime.add(const Duration(days: 1));
        }
        AlarmSettings cs = createAlarmSettings(alarmModel, dateTime);
        Alarm.set(alarmSettings: cs);
        alarmModel.alarmSettingsDateTime = dateTime.toString();
        alarmModel.alarmNextDateTime = dateTime.toString();
        await IsarDb.updateAlarm(alarmModel);
        await Get.getAlarmsController().initLatestIsarAlarms();
        debugPrint('An alarm has been set：${cs.toString()}');
        break;
      case 1:
        List<bool> days = alarmModel.days;
        DateTime? nextAlarm = Utils.calculateNextAlarmTime(days, TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
        if (nextAlarm != null) {
          AlarmSettings cs = createAlarmSettings(alarmModel, nextAlarm);
          Alarm.set(alarmSettings: cs);
          alarmModel.alarmSettingsDateTime = dateTime.toString();
          alarmModel.alarmNextDateTime = nextAlarm.toString();
          await IsarDb.updateAlarm(alarmModel);
          await Get.getAlarmsController().initLatestIsarAlarms();
          debugPrint('An alarm has been set：${cs.toString()}');
        }
        // for (int i = DateTime.now().weekday - 1; i < days.length; i++) {
        //   if (days[i]) {
        //     dateTime = Utils.getNextAlarmTimeForWeekly(i+1, TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
        //     break;
        //   }
        // }
        break;
      case 2:
        List<bool> days = alarmModel.days;
        // if (dateTime.isBefore(DateTime.now())) {
        //   currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
        // }
        // DateTime? nextAlarmTime = Utils.getNextAlarmTimeForCycleDays(currentDate, DaysHwUs.startDate, DaysHwUs.endDate, days, DaysHwUs.excludedDates, TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
        DataAlarmCycleBase? dataAlarmCycleBase = Get.find<GetStorageProvider>().readCurrentAlarmCycleData();
        if (dataAlarmCycleBase == null) {
          return;
        }
        DateTime? nextAlarmTime = Utils.findNextAlarmDate(dataAlarmCycleBase: dataAlarmCycleBase, alarmDays: days, targetTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
        // DateTime? nextAlarmTime = Utils.findNextAlarmDate(startDate: DATA_ALARM_CYCLE_HWUS.startDate, endDate: DATA_ALARM_CYCLE_HWUS.endDate, alarmDays: days, excludedDates: DATA_ALARM_CYCLE_HWUS.excludedDates, targetTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute), currentDate: currentDate);
        if (nextAlarmTime != null) {
          AlarmSettings cs = createAlarmSettings(alarmModel, nextAlarmTime);
          await Alarm.set(alarmSettings: cs);
          alarmModel.alarmSettingsDateTime = dateTime.toString();
          alarmModel.alarmNextDateTime = nextAlarmTime.toString();
          await IsarDb.updateAlarm(alarmModel);
          await Get.getAlarmsController().initLatestIsarAlarms();
          debugPrint('An alarm has been set：${cs.toString()}');
        }
        break;
      case 3:
        if (dateTime.isBefore(DateTime.now())) {
          dateTime = dateTime.add(const Duration(days: 1));
        }
        AlarmSettings cs = createAlarmSettings(alarmModel, dateTime);
        Alarm.set(alarmSettings: cs);
        alarmModel.alarmSettingsDateTime = dateTime.toString();
        alarmModel.alarmNextDateTime = dateTime.toString();
        await IsarDb.updateAlarm(alarmModel);
        await Get.getAlarmsController().initLatestIsarAlarms();
        debugPrint('An alarm has been set：${cs.toString()}');
        break;
      case 4://events alarm
        if (dateTime.isBefore(DateTime.now()) || !alarmModel.isEnabled) {
          // dateTime = dateTime.add(const Duration(days: 1));
          return;
        }
        AlarmSettings cs = createAlarmSettings(alarmModel, dateTime);
        Alarm.set(alarmSettings: cs);
        // alarmModel.alarmSettingsDateTime = dateTime.toString();
        // alarmModel.alarmNextDateTime = dateTime.toString();
        // await IsarDb.updateAlarm(alarmModel);
        await Get.getAlarmsController().initLatestIsarAlarms();
        debugPrint('An alarm has been set：${cs.toString()}');
        break;

    }

  }

  Future<void> stopAlarm(AlarmModel alarmModel) async {
    AlarmSettings? alarmSettings = Alarm.getAlarm(alarmModel.alarmSettingsId);
    if (alarmSettings != null) {
      await Alarm.stop(alarmSettings.id);
    }
  }

  AlarmSettings createAlarmSettings(AlarmModel alarmModel, DateTime dateTime) {
    return AlarmSettings(
      id: alarmModel.alarmSettingsId,
      dateTime: dateTime,
      assetAudioPath: alarmModel.assetAudioPath,
      loopAudio: true,
      vibrate: true,
      volume: alarmModel.volume,
      fadeDuration: double.tryParse('${alarmModel.fadeDuration}')??0,
      notificationTitle: 'LateStart',
      notificationBody: 'Alarm is ringing',
      // notificationTitle: 'This is the title',
      // notificationBody: 'This is the body',
      enableNotificationOnKill: alarmModel.enableNotificationOnKill,
    );

  }

  Future<List<AlarmModel>> refreshAllAlarms(List<AlarmModel> isarStreamAlarms) async {
    for (int i = 0; i < isarStreamAlarms.length; i++) {
      AlarmModel alarmModel = isarStreamAlarms[i];
      if (alarmModel.isEnabled) {
        if (alarmModel.type == 0 && (alarmModel.alarmNextDateTime??'').isNotEmpty) {
          DateTime? alarmNextDateTime = DateTime.tryParse(alarmModel.alarmNextDateTime!);
          if (alarmNextDateTime != null) {
            if (alarmNextDateTime.isAfter(DateTime.now())) {
              await setAlarm(alarmModel);
              continue;
            }
          }
          Alarm.stop(alarmModel.alarmSettingsId);
          alarmModel.isEnabled = false;
          await IsarDb.updateAlarm(alarmModel);
        } else {
          await setAlarm(alarmModel);
        }
      }
    }
    return isarStreamAlarms;
  }
}