import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/datas/data_base.dart';
import 'package:late_start/datas/data_manager.dart';
import 'package:late_start/models/alarm_model.dart';
import 'package:uuid/uuid.dart';

import '../models/calendar_event_model.dart';
import '../providers/get_storage_provider.dart';
import '../providers/isar_provider.dart';
import '../utils/utils.dart';

class CalendarController extends GetxController {
  RxDouble scalingFactor = 1.0.obs;
  ScrollController scrollController = ScrollController();
  RxString calendarSet = ''.obs;
  final Rx<DataBase?> _currentData = Rx<DataBase?>(null);
  TextEditingController searchInputController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final RxList<DataBase> _matchedDataBase = <DataBase>[].obs;
  final _storage = Get.find<GetStorageProvider>();

  //tab calendar
  final Rx<DateTime?> _selectedDay = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> _focusedDay = Rx<DateTime>(DateTime.now());
  final RxList<CalendarEventModel> _eventLoader =
      RxList<CalendarEventModel>([]);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() {
    scrollController.addListener(() {
      final offset = scrollController.offset;
      const maxOffset = 100.0;
      const minFactor = 0.8;
      const maxFactor = 1.0;

      final newFactor = 1.0 - (offset / maxOffset).clamp(0.0, 1.0);
      scalingFactor.value = (minFactor + (maxFactor - minFactor) * newFactor);
      update();
    });
    // DataBase? storageDataBase = _storage.readCurrentCalendarData();
    DataBase? storageDataBase = _storage.readNewCurrentCalendarData();
    if (storageDataBase == null) {
      searchInputController.addListener(() {
        _matchedDataBase.clear();
        if (searchInputController.text.isNotEmpty) {
          _matchedDataBase.addAll(
              DataManager.getNewFuzzyMatchedDataBase(searchInputController.text) ??
                  []);
        }
        update();
      });
      searchFocusNode.addListener(() {
        if (searchFocusNode.hasFocus) {
          _matchedDataBase.clear();
          if (searchInputController.text.isEmpty) {
            _matchedDataBase.addAll(
              DataManager.getNewFuzzyMatchedDataBase(searchInputController.text) ?? [],
            );
          }
          update(); // 通知 UI 更新
        }
      });

    } else {
      setCurrentData = storageDataBase;
    }
    setFocusedDay = DateTime.now();
  }

  List<DataBase> get matchedDataBase => _matchedDataBase;

  set setCurrentData(DataBase e) {
    _storage.writeCurrentCalendarData(e).then((_) {
      _currentData.value = e;
      update();
    }).catchError((e) {
      debugPrint(e.toString());
    });
    // _storage.writeCurrentCalendarDataKey(e.fullName()).then((_) {
    //   _currentData.value = e;
    //   update();
    // }).catchError((e) {
    //   debugPrint(e.toString());
    // });
  }

  cleanCurrentData() async {
    List<CalendarEventModel> alarmOpenCalendarEvents =
        await IsarDb.getCalendarEvents();
    for (final event in alarmOpenCalendarEvents) {
      await cleanCalendarEventModelEvent(event);
    }
    await _storage.cleanCurrentCalendarData();
    _currentData.value = null;
    update();
  }

  cleanCalendarEventModelEvent(CalendarEventModel calendarEventModel) async {
    await deleteCalendarEvent(calendarEventModel);
    await refreshData();
    await Get.getAlarmsController().initLatestIsarAlarms();
    await Alarm.stop(calendarEventModel.id);
  }

  DataBase? get getCurrentData => _currentData.value;

  set setSelectedDay(DateTime e) {
    _selectedDay.value = e;
    update();
  }

  DateTime? get getSelectedDay => _selectedDay.value;

  set setFocusedDay(DateTime e) {
    _focusedDay.value = e;
    update();
    IsarDb.getEventsByCalendarMonth(e).then((e) {
      _eventLoader.clear();
      _eventLoader.addAll(e);
      update();
    });
  }

  DateTime get getFocusedDay => _focusedDay.value;

  setSelectedDayAndFocusedDay(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay.value = selectedDay;
    _focusedDay.value = focusedDay;
    update();
    // IsarDb.getEventsByCalendarMonth(selectedDay).then((e) {
    //   debugPrint(
    //       'selectedDay: $selectedDay, eventLoader result: ${e.toString()}');
    //   _eventLoader.value = e;
    //   update();
    // });
  }

  // onTableCalendarPageChanged(DateTime focusedDay) {
  //   _focusedDay.value = focusedDay;
  //   update();
  //   IsarDb.getEventsByCalendarMonth(focusedDay).then((e) {
  //     debugPrint(
  //         'onTableCalendarPageChanged focusedDay: $focusedDay, eventLoader result: ${e.toString()}');
  //     _eventLoader.value = e;
  //     update();
  //   });
  //
  // }

  set setEventLoader(List<CalendarEventModel> e) {
    _eventLoader.value = e;
    update();
  }

  List<CalendarEventModel> get getEventLoader => _eventLoader;

  addOrUpdateCalendarEvent(CalendarEventModel event) async {
    await IsarDb.addOrUpdateCalendarEvent(event);
    _eventLoader.value =
        await IsarDb.getEventsByCalendarMonth(event.calendarDate);
    update();
  }

  deleteCalendarEvent(CalendarEventModel event) async {
    await IsarDb.deleteCalendarEvent(event.id);
    _eventLoader.value =
        await IsarDb.getEventsByCalendarMonth(event.calendarDate);
    update();
  }

  Future<List<AlarmModel>> calendarEventModelsToAlarmModels() async {
    List<CalendarEventModel> alarmOpenCalendarEvents =
        await IsarDb.getCalendarEvents();
    List<AlarmModel> calendarEventAlarmModels = await Future.wait(
        alarmOpenCalendarEvents.map((e) async {
          e.alarmDateTime = await IsarDb.getComputedAlarmTime(e);
          return calendarEventModelToAlarmModel(e);
        })
    );
    return calendarEventAlarmModels;
  }

  AlarmModel calendarEventModelToAlarmModel(CalendarEventModel e) {
    return AlarmModel(
        alarmTime: e.alarmDateTime.toString(),
        type: 4,
        isEnabled: e.isAlarmOpen && !e.alarmDateTime!.isBefore(DateTime.now()),
        alarmID: const Uuid().v4(),
        minutesSinceMidnight: Utils.timeOfDayToInt(TimeOfDay.fromDateTime(
          e.alarmDateTime!,
        )),
        days: [],
        label: 'eId:${e.id} & name:${e.eventName}',
        assetAudioPath: 'assets/medias/marimba.mp3',
        loopAudio: true,
        vibrate: true,
        fadeDuration: 0,
        notificationTitle: '',
        notificationBody: '',
        enableNotificationOnKill: Platform.isIOS,
        androidFullScreenIntent: true,
        alarmSettingsId: e.id);
  }

  setCalendarEventModelAlarmOpen(AlarmModel alarm) async {
    CalendarEventModel? alarmOpenCalendarEvent =
        await getCalendarEventModelFromAlarmModel(alarm);
    if (alarmOpenCalendarEvent != null) {
      alarmOpenCalendarEvent.isAlarmOpen = alarm.isEnabled;
      await IsarDb.addOrUpdateCalendarEvent(alarmOpenCalendarEvent);
    }
  }

  Future<CalendarEventModel?> getCalendarEventModelFromAlarmModel(
      AlarmModel alarm) async {
    int? eId = int.tryParse(
        RegExp(r'eId:(\d+)').firstMatch(alarm.label)?.group(1) ?? '');
    if (eId != null) {
      return await IsarDb.getCalendarEventById(eId);
    }
    return null;
  }

  refreshData() => setFocusedDay = _focusedDay.value;

  @override
  void dispose() {
    super.dispose();
    searchInputController.dispose();
  }
}
