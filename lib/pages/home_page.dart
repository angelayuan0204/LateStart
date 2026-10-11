
import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/pages/alarm_ring_event_page.dart';
import 'package:late_start/utils/constants.dart';
import 'package:late_start/utils/utils.dart';

import '../datas/data_alarm_cycle_base.dart';
import '../models/alarm_model.dart';
import '../models/calendar_event_model.dart';
import '../providers/get_storage_provider.dart';
import '../providers/isar_provider.dart';
import '../temp/main.dart';
import '../temp/settings.dart';
import 'alarm_ring_page.dart';
import 'alarms_page.dart';
import 'calendar_new_page.dart';
import 'edit_alarms_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  static StreamSubscription<AlarmSettings>? subscription;

  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = [
    const AlarmsPage(),
    const CalendarNewPage(),
    // const MyApp(),
    const SettingsPage()
  ];

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      Get.getEditAlarmsController().checkAndroidNotificationPermission();
      Get.getEditAlarmsController().checkAndroidScheduleExactAlarmPermission();
    }
    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);

  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    AlarmModel? alarmModel = await IsarDb.findByAlarmSettingsId(alarmSettings.id);
    CalendarEventModel? calendarEventModel = await IsarDb.getCalendarEventById(alarmSettings.id);
    if (alarmModel != null) {
      DateTime? nextDateTime = DateTime.tryParse(alarmModel.alarmNextDateTime??'');
      if (nextDateTime != null && Utils.isWithinOneMinute(nextDateTime)) {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) =>
                AlarmRingPage(alarmSettings: alarmSettings, alarmModel: alarmModel,),
          ),
        );
      } else {
        if (nextDateTime != null) {
          if (alarmModel.isEnabled) {
            if (alarmModel.type == 0) {
              alarmModel.isEnabled = false;
              await Alarm.stop(alarmSettings.id);
              await IsarDb.updateAlarm(alarmModel);
              await Get.getAlarmsController().initLatestIsarAlarms();
            } else {
              await Alarm.stop(alarmSettings.id);
              Get.getAppController().setAlarm(alarmModel);
            }
          } else {
            await Alarm.stop(alarmSettings.id);
          }
        } else {
          await Alarm.stop(alarmSettings.id);
        }
      }
    } else if (calendarEventModel != null) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) =>
              AlarmRingEventPage(alarmSettings: alarmSettings, calendarEventModel: calendarEventModel,),
        ),
      );
    } else {
      await Alarm.stop(alarmSettings.id);
    }

    // loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Image.asset('assets/images/ic_alarm.png', width: 30, height: 30, color: _selectedIndex == 0?primaryColor:Colors.white,), label: ''),
            BottomNavigationBarItem(icon: Image.asset('assets/images/ic_calendar.jpg', width: 30, height: 30, color: _selectedIndex == 1?primaryColor:Colors.white,), label: ''),
            BottomNavigationBarItem(icon: Image.asset('assets/images/ic_setting.png', width: 30, height: 30, color: _selectedIndex == 2?primaryColor:Colors.white,), label: ''),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      floatingActionButton: _selectedIndex == 0?FloatingActionButton(
        onPressed: () {
          DataAlarmCycleBase? dataAlarmCycleBase = Get.find<GetStorageProvider>().readCurrentAlarmCycleData();
          if (dataAlarmCycleBase == null) {
            _onItemTapped(1);
            return;
          }
          Get.to(const EditAlarmsPage());
        },
        child: const Icon(Icons.add),
      ):null,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if (_selectedIndex == 0) {
      //   Get.getAlarmsController().initLatestIsarAlarms(needRefreshAlarm: true);
      // }
    });

  }

}