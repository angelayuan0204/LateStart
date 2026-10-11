import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/models/alarm_model.dart';
import 'package:late_start/utils/constants.dart';

import '../providers/isar_provider.dart';

class AlarmRingPage extends StatefulWidget {
  final AlarmSettings alarmSettings;

  final AlarmModel alarmModel;

  const AlarmRingPage(
      {super.key, required this.alarmSettings, required this.alarmModel});

  @override
  State<AlarmRingPage> createState() => _AlarmRingPageState();
}

class _AlarmRingPageState extends State<AlarmRingPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // IsarDb.findByAlarmSettingsId(widget.alarmSettings.id).then((res) {
    //   if (res != null) {
    //     alarmModel = res;
    //     setState(() {
    //     });
    //     // forNext();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.alarmModel.label,
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

  Future<void> forNext() async {
    await doNext(widget.alarmModel);
    List<AlarmModel>? alarms = await IsarDb.findSameAlarms(
        widget.alarmSettings.dateTime.toString(), widget.alarmSettings.id);
    if (alarms != null && alarms.isNotEmpty) {
      for (int i = 0; i < alarms.length; i++) {
        await doNext(alarms[i]);
      }
    }
    debugPrint('already executed dispose');
  }

  Future<void> doNext(AlarmModel? alarmModel) async {
    if (alarmModel != null) {
      await Alarm.stop(alarmModel.alarmSettingsId);
      if (alarmModel.type == 2 ||
          alarmModel.type == 1 ||
          alarmModel.type == 3) {
        await Get.getAppController().setAlarm(alarmModel);
      } else {
        alarmModel.isEnabled = false;
        await IsarDb.updateAlarm(alarmModel);
        await Get.getAlarmsController().initLatestIsarAlarms();
      }
    }
  }

  @override
  dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
