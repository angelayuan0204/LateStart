import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/utils/constants.dart';

import '../models/calendar_event_model.dart';

class AlarmRingEventPage extends StatefulWidget {
  final AlarmSettings alarmSettings;
  final CalendarEventModel calendarEventModel;

  const AlarmRingEventPage(
      {super.key,
      required this.alarmSettings,
      required this.calendarEventModel});

  @override
  State<AlarmRingEventPage> createState() => _AlarmRingEventPageState();
}

class _AlarmRingEventPageState extends State<AlarmRingEventPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.calendarEventModel.eventName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // const Text('🔔', style: TextStyle(fontSize: 50)),
          Image.asset(
            'assets/images/ic_alarm_ring_1.png',
            width: 50,
            height: 50,
            color: primaryColor,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RawMaterialButton(
              //   onPressed: () {
              //     final now = DateTime.now();
              //     Alarm.set(
              //       alarmSettings: widget.alarmSettings.copyWith(
              //         dateTime: DateTime(now.year, now.month, now.day, now.hour, now.minute,).add(const Duration(minutes: 1)),
              //       ),
              //     ).then((_) => Navigator.pop(context));
              //   },
              //   child: Text('Snooze', style: Theme.of(context).textTheme.titleLarge,),
              // ),
              RawMaterialButton(
                constraints:
                    const BoxConstraints.expand(width: 120, height: 120),
                fillColor: primaryColor,
                shape: const CircleBorder(),
                onPressed: () async {
                  await Alarm.stop(widget.alarmSettings.id).then((_) async {
                    await this.forNext();
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'STOP',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Future<void> forNext() async {
    if (widget.calendarEventModel.repeatOption != 'Weekly' && widget.calendarEventModel.repeatOption != 'Month') {
      widget.calendarEventModel.isAlarmOpen = false;
      Get.getCalendarController()
          .addOrUpdateCalendarEvent(widget.calendarEventModel);
    }
    Get.getAlarmsController().initLatestIsarAlarms();
    debugPrint('already executed dispose');
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      debugPrint('App is inactive');
    } else if (state == AppLifecycleState.paused) {
      debugPrint('App is paused (in background)');
      await forNext();
      debugPrint('exec forNext() success!');
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('App is resumed (in foreground)');
    }
  }

  @override
  dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
