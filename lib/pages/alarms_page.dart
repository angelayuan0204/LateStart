import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/pages/calendar_event_page.dart';
import 'package:late_start/pages/edit_alarms_page.dart';
import 'package:late_start/services/settings_controller.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/alarm_model.dart';
import '../models/calendar_event_model.dart';
import '../providers/isar_provider.dart';
import '../services/alarms_controller.dart';
import '../services/theme_controller.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AlarmsPageState();

}

class _AlarmsPageState extends State<AlarmsPage> {

  ThemeController themeController = Get.getThemeController();
  SettingsController settingsController = Get.getSettingsController();

  @override
  void initState() {
    super.initState();
    Get.getAlarmsController().initLatestIsarAlarms(needRefreshAlarm: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(builder: (AlarmsController controller) {
          return NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              _buildSliverAppBar(Get.height / 70.9),//7.9
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                controller.initLatestIsarAlarms();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GlowingOverscrollIndicator(
                      color: themeController.isLightMode.value? lightPrimaryDisabledTextColor: primaryDisabledTextColor,
                      axisDirection: AxisDirection.down,
                      child: controller.latestIsarAlarms.isEmpty ? Stack(
                        children: [
                          Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.alarm_add, color: Colors.transparent, size: 30,).marginOnly(bottom: 20),
                              Text('Set up to get started!'.tr, textWidthBasis:TextWidthBasis.longestLine, style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: Colors.transparent,),//themeController.isLightMode.value ? lightPrimaryDisabledTextColor:primaryDisabledTextColor
                              ),
                              60.height
                            ],
                          ).center().paddingSymmetric(horizontal: 20),
                          ListView()
                        ],
                      ): ListView.separated(
                        separatorBuilder: (context, _) {
                          // return SizedBox(height: Get.height * 0.02,);
                          return const SizedBox(height: 0,);
                        },
                        itemCount: controller.latestIsarAlarms.length + 1,
                        itemBuilder: (context, index) {
                          return _buildAlarmsListItem(controller, controller.latestIsarAlarms, index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },),
      ),
    );
  }

  Future<bool> showDeleteAlarmConfirmationPopupOnSwipe(BuildContext context,) async {
    var result = await Get.defaultDialog(titlePadding: const EdgeInsets.symmetric(vertical: 20,),
      backgroundColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
      title: 'Confirmation'.tr,
      titleStyle: Theme.of(context).textTheme.displaySmall,
      content: Column(
        children: [
          Text('Delete this alarm?'.tr, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.only(top: 20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryTextColor.withOpacity(0.5),)),
                  child: Text('Cancel'.tr, style: Theme.of(context).textTheme.displaySmall!,),),
                TextButton(
                  onPressed: () {
                    Get.back(result: true); // User confirmed
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor),),
                  child: Text('delete'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: primaryBackgroundColor,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  _buildSliverAppBar(double expandedHeight) => SliverAppBar(
    actions: [Container()],
    automaticallyImplyLeading: false,
    expandedHeight: expandedHeight,
    floating: true,
    pinned: true,
    snap: false,
    centerTitle: true,
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center everything vertically
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder(builder: (AlarmsController controller) {
                  return Container(
                    padding: EdgeInsets.only(left: 25 * controller.scalingFactor.value,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Alarms'.tr, style: themeController.getAppTitleTextStyle(context, scalingFactor: controller.scalingFactor.value).copyWith(color: primaryTitleGrayColor),),
                        // Text(
                        //   controller.alarmTime.value.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        //   color: themeController.isLightMode.value?lightPrimaryTextColor.withOpacity(0.75,) : primaryTextColor.withOpacity(0.75,),
                        //   fontSize: 14 *controller.scalingFactor.value,),
                        // ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ).center();
      },
    ),
  );

  _buildAlarmsListItem(AlarmsController controller, List<AlarmModel> alarms, int index) {
    if (index == alarms.length) {
      return SizedBox(height: Get.height * 0.1,);
    }
    final AlarmModel alarm = alarms[index];
    final repeatDays = alarm.type == 4 ? Utils.getEventLabelName(alarm.label): alarm.type == 2? Utils.getRepeatCycleDays(alarm.days) : Utils.getRepeatDays(alarm.days);
    return Dismissible(
      direction: alarm.type == 4?DismissDirection.none:DismissDirection.endToStart,
      onDismissed: (direction) async {
        bool userConfirmed = await showDeleteAlarmConfirmationPopupOnSwipe(context);
        if (userConfirmed) {
          await Get.getAppController().stopAlarm(alarm);
          await IsarDb.deleteAlarm(alarm.isarId);
        } else {
          Get.back();
        }
        controller.initLatestIsarAlarms();
      },
      key: ValueKey(alarms[index]),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        alignment: Alignment.center,
        child: const Icon(Icons.delete,color: Colors.white,),
      ),
      child: GestureDetector(
        onTap: () async {
          if (alarm.type == 4) {
            CalendarEventModel? calendarEventModel = await Get.getCalendarController().getCalendarEventModelFromAlarmModel(alarm);
            if (calendarEventModel != null) {
              Get.to(CalendarEventPage(calendarEventModel: calendarEventModel));
            }

          } else {
            Get.to(const EditAlarmsPage(), arguments: alarms[index]);
          }

        },
        onLongPress: () {},
        onLongPressEnd: (details) {
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Card(
            color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18,),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(alarm.label, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w800, color: alarm.isEnabled? primaryColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor, fontSize: 18),).paddingOnly(bottom: 10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(repeatDays.replaceAll('Never'.tr, 'One Time'.tr,), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: alarm.isEnabled == true ? primaryColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
                            if (alarm.label.isNotEmpty) VerticalDivider(color: alarm.isEnabled? primaryColor : themeController.isLightMode.value ? primaryColor : primaryDisabledTextColor, thickness: 1.4, width: 6, indent: 3.1, endIndent: 3.1,).paddingSymmetric(horizontal: 6),
                            Expanded(
                              child: Text(alarm.type == 4 ? DateFormat("MM-dd-yyyy HH:mm").format(DateTime.parse(alarm.alarmTime)) : '${alarm.label} | ${Utils.formatAlarmDateTime(alarm.alarmNextDateTime)}', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: alarm.isEnabled? primaryColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
                              // child: Text(alarm.type == 4 ? DateFormat("MM-dd-yyyy HH:mm").format(DateTime.parse(alarm.alarmTime)) : '${alarm.label} | ${(alarm.alarmNextDateTime??'').replaceAll(':00.000', '')}', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, color: alarm.isEnabled? primaryColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
                                // (alarm.alarmNextDateTime??'').replaceAll(':00.000', '')
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(alarm.type == 4?DateFormat("HH:mm").format(DateTime.parse(alarm.alarmTime)):(settingsController.is24HrsEnabled.value ? Utils.split24HourFormat(alarm.alarmTime) : Utils.convertTo12HourFormat(alarm.alarmTime,))[0], style: Theme.of(context,).textTheme.displayLarge!.copyWith(color: alarm.isEnabled == true ? themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 3.0,),
                            child: Text((settingsController.is24HrsEnabled.value ? Utils.split24HourFormat(alarm.alarmTime) : Utils.convertTo12HourFormat(alarm.alarmTime,))[1], style: Theme.of(context).textTheme.displayMedium!.copyWith(color: alarm.isEnabled == true ? themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  // Showing the switch and pop up menu button
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Expanded(
                    flex: 0,
                    child: Switch.adaptive(activeColor: secondaryColor, value: alarm.isEnabled,
                      onChanged: (bool value) async {
                        if (alarm.type == 4) {
                          alarm.isEnabled = value && !DateTime.parse(alarm.alarmTime).isBefore(DateTime.now());
                          await Get.getCalendarController().setCalendarEventModelAlarmOpen(alarm);
                          controller.initLatestIsarAlarms();
                          if (alarm.isEnabled) {
                            Get.getAppController().setAlarm(alarm);
                          } else {
                            Get.getAppController().stopAlarm(alarm);
                          }

                        } else {
                          alarm.isEnabled = value;
                          await IsarDb.updateAlarm(alarm);
                          controller.refreshTimer = true;
                          controller.refreshUpcomingAlarms();
                          controller.initLatestIsarAlarms();
                          if (value) {
                            Get.getAppController().setAlarm(alarm);
                          } else {
                            Get.getAppController().stopAlarm(alarm);
                          }
                        }
                      },
                    ),
                  ),
                    // _buildItemPopupMenuButton(alarm, controller);
                  ],
                ).paddingSymmetric(horizontal: 10),
              ],
            ).center().paddingOnly(left: 25.0, right: 0.0, top: 18, bottom: 18),
          ).paddingSymmetric(horizontal: 10).center(),
        ),
      ),
    );
  }

  _buildItemPopupMenuButton(AlarmModel alarm, AlarmsController controller) {
    return Expanded(
      flex: 0, child: PopupMenuButton(
      onSelected: (value) async {
        if (value == 0) {
          toasty(context, 'todo for preview alarm');
        } else if (value == 1) {
          await IsarDb.deleteAlarm(alarm.isarId);
          if (Get.isSnackbarOpen) {
            Get.closeAllSnackbars();
          }
          Get.snackbar('Alarm deleted', 'The alarm has been deleted.',
            duration: const Duration(seconds: 4),
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15,),
            mainButton: TextButton(
              onPressed: () async {
                await IsarDb.addAlarm(alarm);
              },
              child: const Text('Undo'),
            ),
          );
          // String ringtoneName = alarm.ringtoneName;
          // await AudioUtils.updateRingtoneCounterOfUsage(customRingtoneName: ringtoneName, counterUpdate: CounterUpdate.decrement,);
          controller.refreshTimer = true;
          controller.refreshUpcomingAlarms();
        }
      },
      color: themeController.isLightMode.value ? lightPrimaryBackgroundColor : primaryBackgroundColor,
      icon: Icon(Icons.more_vert,
        color: alarm.isEnabled == true ? themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor : themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Text('Preview Alarm'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text(
              'Delete Alarm'.tr,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red,),
            ),
          ),
        ];
      },
    ),
    );
  }

}