import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/services/theme_controller.dart';
import 'package:late_start/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../models/alarm_model.dart';
import '../providers/get_storage_provider.dart';
import '../providers/isar_provider.dart';
import '../utils/constants.dart';

class EditAlarmsController extends GetxController {
  final labelController = TextEditingController();

  ThemeController themeController = Get.getThemeController();

  var alarmID = const Uuid().v4();

  final selectedTime = DateTime.now().add(const Duration(minutes: 1)).obs;

  final RxInt hours =
          (Get.getSettingsController().is24HrsEnabled.value ? 0 : 1).obs,
      minutes = 0.obs,
      meridiemIndex = 0.obs;

  final List<RxString> meridiem = ['AM'.obs, 'PM'.obs];

  var alarmRecord = Rxn<AlarmModel>(null);

  final timeToAlarm = ''.obs;

  final repeatDays =
      <bool>[false, false, false, false, false, false, false].obs;

  // final cycleDays = <bool>[false, false, false, false, false, false].obs;
  final RxList<bool> cycleDays = <bool>[].obs;


  final daysRepeating = 'Never'.tr.obs;

  RxBool isDailySelected = false.obs;
  RxBool isWeekdaysSelected = false.obs;
  RxBool isCustomSelected = false.obs;

  final RxString label = ''.obs;
  final RxInt fadeDuration = 0.obs;

  final volume = Rxn<double?>(null);

  Map<String, dynamic> initialValues = {};
  Map<String, dynamic> changedFields = {};

  @override
  void onInit() {
    super.onInit();
    resetCycleDays();
    alarmRecord.value = Get.arguments;
    if (Get.arguments != null) {
      fadeDuration.value = alarmRecord.value!.fadeDuration;
      label.value = alarmRecord.value!.label;
      volume.value = alarmRecord.value!.getVolume();
      selectedTime.value = Utils.timeOfDayToDateTime(
        Utils.stringToTimeOfDay(alarmRecord.value!.alarmTime),
      );
      hours.value = selectedTime.value.hour;
      minutes.value = selectedTime.value.minute;

      if (Get.getSettingsController().is24HrsEnabled.value == false) {
        if (selectedTime.value.hour == 0) {
          hours.value = 12;
          meridiemIndex.value = 0;
        } else if (selectedTime.value.hour == 12) {
          meridiemIndex.value = 1;
        } else if (selectedTime.value.hour > 12) {
          hours.value = selectedTime.value.hour - 12;
          meridiemIndex.value = 1;
        } else {
          meridiemIndex.value = 0;
        }
      }
      if (alarmRecord.value!.type == 2) {
        // timeToAlarm.value = Utils.timeUntilAlarm(
        //   TimeOfDay.fromDateTime(selectedTime.value),
        //   cycleDays,
        // );

        cycleDays.value = alarmRecord.value!.days;
        daysRepeating.value = Utils.getRepeatCycleDays(alarmRecord.value!.days);
        setIsCustomSelected(true);
      } else {
        timeToAlarm.value = Utils.timeUntilAlarm(
          TimeOfDay.fromDateTime(selectedTime.value),
          repeatDays,
        );

        repeatDays.value = alarmRecord.value!.days;
        daysRepeating.value = Utils.getRepeatDays(repeatDays);
        setIsWeekdaysSelected(alarmRecord.value!.type == 1);
      }

      alarmID = alarmRecord.value!.alarmID;
    } else {
      _initAll();
      hours.value = selectedTime.value.hour;
      minutes.value = selectedTime.value.minute;
      volume.value = null;
      if (!Get.getSettingsController().is24HrsEnabled.value) {
        if (selectedTime.value.hour == 0) {
          hours.value = 12;
          meridiemIndex.value = 0;
        } else if (selectedTime.value.hour == 12) {
          meridiemIndex.value = 1;
        } else if (selectedTime.value.hour > 12) {
          hours.value = selectedTime.value.hour - 12;
          meridiemIndex.value = 1;
        } else {
          meridiemIndex.value = 0;
        }
      }
      timeToAlarm.value = Utils.timeUntilAlarm(
          TimeOfDay.fromDateTime(selectedTime.value), repeatDays);
      alarmID = const Uuid().v4();
    }

    initialValues.addAll({
      'selectedTime': selectedTime.value,
      'daysRepeating': daysRepeating.value,
      'fadeDuration': fadeDuration.value,
      'label': label.value,
      'volume': volume.value,
    });

    addListeners();
    update();
  }

  void _initAll() {
    DateTime nowDt = DateTime.now().add(const Duration(minutes: 1));
    selectedTime.value = nowDt;
    timeToAlarm.value = "";
    repeatDays.value = <bool>[false, false, false, false, false, false, false];
    // cycleDays.value = <bool>[];
    daysRepeating.value = 'Never'.tr;
    isDailySelected.value = false;
    isWeekdaysSelected.value = false;
    isCustomSelected.value = false;
    label.value = "";
    fadeDuration.value = 0;
    initialValues = {};
    changedFields = {};
  }

  void addListeners() {
    selectedTime.listen((time) {
      debugPrint('CHANGED CHANGED CHANGED CHANGED');
      timeToAlarm.value =
          Utils.timeUntilAlarm(TimeOfDay.fromDateTime(time), repeatDays);
      _compareAndSetChange('selectedTime', time);
      update();
    });
    repeatDays.listen((days) {
      // daysRepeating.value = isCustomSelected.value?'HW US 2024-2025(${Utils.getRepeatDays(days)})':Utils.getRepeatDays(days);
      daysRepeating.value = Utils.getRepeatDays(days);
      _compareAndSetChange('daysRepeating', daysRepeating.value);
      update();
    });
    setupListener<int>(fadeDuration, 'fadeDuration');
    setupListener<double?>(volume, 'volume');
  }

  void resetCycleDays() {
    final dataAlarmCycleBase = Get.find<GetStorageProvider>().readCurrentAlarmCycleData();
    final maxDays = dataAlarmCycleBase?.maxCycleDays() ?? 6;
    cycleDays.value = List<bool>.filled(maxDays, false);
  }


  void setCycleDaysRepeatingUp() {
    if (isCustomSelected.value) {
      daysRepeating.value = Utils.getRepeatCycleDays(cycleDays);
      _compareAndSetChange('daysRepeating', cycleDays);
    }
  }

  void _compareAndSetChange(String fieldName, dynamic currentValue) {
    if (initialValues.containsKey(fieldName)) {
      bool hasChanged = initialValues[fieldName] != currentValue;
      changedFields[fieldName] = hasChanged;
    }
  }

  void setupListener<T>(Rx<T> rxVar, String fieldName) {
    rxVar.listen((value) {
      _compareAndSetChange(fieldName, value);
    });
  }

  void checkUnsavedChangesAndNavigate(BuildContext context) {
    int numberOfChangesMade =
        changedFields.entries.where((element) => element.value == true).length;
    if (numberOfChangesMade >= 1) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: themeController.isLightMode.value
            ? lightSecondaryBackgroundColor
            : secondaryBackgroundColor,
        title: 'Discard Changes?'.tr,
        titleStyle: Theme.of(context).textTheme.displaySmall,
        content: Column(
          children: [
            Text('unsavedChanges'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                  child: Text('Cancel'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: primaryBackgroundColor)),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: themeController.isLightMode.value
                              ? Colors.red.withOpacity(0.9)
                              : Colors.red,
                          width: 1)),
                  child: Text('Leave'.tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: themeController.isLightMode.value
                              ? Colors.red.withOpacity(0.9)
                              : Colors.red)),
                ),
              ],
            ).paddingOnly(top: 20),
          ],
        ),
      );
    } else {
      Get.back();
    }
  }

  void setIsDailySelected(bool value) {
    isDailySelected.value = value;
    if (value == true) {
      isCustomSelected.value = false;
      isWeekdaysSelected.value = false;
    }
    update();
  }

  void setIsWeekdaysSelected(bool value) {
    isWeekdaysSelected.value = value;
    if (value == true) {
      isCustomSelected.value = false;
      isDailySelected.value = false;
    }
    update();
  }

  void setIsCustomSelected(bool value) {
    isCustomSelected.value = value;
    if (value == true) {
      isWeekdaysSelected.value = false;
      isDailySelected.value = false;
    }
    update();
  }

  createAlarm(AlarmModel alarmData) async {
    alarmRecord.value = await IsarDb.addAlarm(alarmData);
    update();
    Get.getAlarmsController().initLatestIsarAlarms();
    Get.back();
    Get.getAppController().setAlarm(alarmRecord.value!);
  }

  AlarmModel updatedAlarmModel() {
    return AlarmModel(
        label: label.value,
        alarmID: alarmID,
        days: isCustomSelected.value ? cycleDays.toList() : repeatDays.toList(),
        alarmTime:
            Utils.timeOfDayToString(TimeOfDay.fromDateTime(selectedTime.value)),
        minutesSinceMidnight:
            Utils.timeOfDayToInt(TimeOfDay.fromDateTime(selectedTime.value)),
        assetAudioPath: 'assets/medias/marimba.mp3',
        loopAudio: true,
        vibrate: true,
        volume: volume.value,
        fadeDuration: fadeDuration.value,
        notificationTitle: '',
        notificationBody: '',
        enableNotificationOnKill: Platform.isIOS,
        androidFullScreenIntent: true,
        // type: isWeekdaysSelected.value?1:isCustomSelected.value?2:0,
        type: isWeekdaysSelected.value
            ? 1
            : isCustomSelected.value
                ? 2
                : daysRepeating.value == 'Never'.tr
                    ? 0
                    : 3,
        alarmSettingsId: alarmRecord.value?.alarmSettingsId ??
            (DateTime.now().millisecondsSinceEpoch % 10000 + 1)
        // ringtoneName: customRingtoneName.value,
        // activityMonitor: isActivityMonitorenabled.value
        );
  }

  updateAlarm(AlarmModel alarmData) async {
    if (await IsarDb.doesAlarmExist(alarmRecord.value!.alarmID) == true) {
      alarmData.isarId = alarmRecord.value!.isarId;
      await IsarDb.updateAlarm(alarmData);
      update();
      // Get.getAlarmsController().initLatestIsarAlarms();
      await Alarm.stop(alarmData.alarmSettingsId);
      Get.getAppController().setAlarm(alarmData);
      Get.back();
    } else {
      createAlarm(alarmData);
    }
  }

  AlarmModel createAlarmModel() {
    return AlarmModel(
        alarmTime: Utils.timeOfDayToString(
          TimeOfDay.fromDateTime(
            selectedTime.value,
          ),
        ),
        alarmID: alarmID,
        minutesSinceMidnight: Utils.timeOfDayToInt(
          TimeOfDay.fromDateTime(
            selectedTime.value,
          ),
        ),
        days: isCustomSelected.value ? cycleDays.toList() : repeatDays.toList(),
        label: label.value,
        assetAudioPath: 'assets/medias/marimba.mp3',
        loopAudio: true,
        vibrate: true,
        volume: volume.value,
        fadeDuration: fadeDuration.value,
        notificationTitle: '',
        notificationBody: '',
        enableNotificationOnKill: Platform.isIOS,
        androidFullScreenIntent: true,
        type: isWeekdaysSelected.value
            ? 1
            : isCustomSelected.value
                ? 2
                : daysRepeating.value == 'Never'.tr
                    ? 0
                    : 3,
        alarmSettingsId: alarmRecord.value?.alarmSettingsId ??
            (DateTime.now().millisecondsSinceEpoch % 10000 + 1));
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    debugPrint('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      debugPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      debugPrint(
          'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
    }
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      debugPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      debugPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  Future<void> checkAndroidExternalStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      debugPrint('Requesting external storage permission...');
      final res = await Permission.storage.request();
      debugPrint(
        'External storage permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }
}
