import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/services/edit_alarms_controller.dart';
import 'package:late_start/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../datas/data_alarm_cycle_base.dart';
import '../providers/get_storage_provider.dart';
import '../services/theme_controller.dart';

class RepeatTitle extends StatefulWidget {
  const RepeatTitle({super.key});

  @override
  State<RepeatTitle> createState() => _RepeatTitleState();
}

class _RepeatTitleState extends State<RepeatTitle> {
  ThemeController themeController = Get.getThemeController();
  List<bool> repeatDays = List<bool>.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.getEditAlarmsController(),
        builder: (EditAlarmsController controller) {
          bool anyDaySelected =
              controller.repeatDays.any((daySelected) => daySelected);
          return InkWell(
            onTap: () {
              Get.bottomSheet(BottomSheet(
                  onClosing: () {
                    _storeOrPreset(controller.repeatDays, repeatDays);
                    controller.update();
                  },
                  backgroundColor: themeController.isLightMode.value
                      ? lightSecondaryBackgroundColor
                      : secondaryBackgroundColor,
                  builder: (BuildContext context) {
                    return GetBuilder(
                        builder: (EditAlarmsController controller) {
                      return SizedBox(
                        height: Get.height * 0.45,
                        child: Column(
                          children: [
                            _buildListTitle(
                                'Daily'.tr, controller.isDailySelected.value,
                                () {
                              controller.setIsDailySelected(
                                  !controller.isDailySelected.value);
                              for (int i = 0;
                                  i < controller.repeatDays.length;
                                  i++) {
                                controller.repeatDays[i] =
                                    controller.isDailySelected.value;
                                controller.update();
                              }
                            }, (value) {
                              controller.setIsDailySelected(value);
                              for (int i = 0;
                                  i < controller.repeatDays.length;
                                  i++) {
                                controller.repeatDays[i] =
                                    controller.isDailySelected.value;
                                controller.update();
                              }
                            }),
                            _buildDivider(),
                            _buildWeeklyTitle(
                                'Weekly'.tr,
                                controller.isWeekdaysSelected.value,
                                controller),
                            // _buildListTitle('Weekly'.tr, controller.isWeekdaysSelected.value, () {
                            //   controller.setIsWeekdaysSelected(!controller.isWeekdaysSelected.value);
                            //   for (int i = 0; i < controller.repeatDays.length; i++) {
                            //     controller.repeatDays[i] = controller.isWeekdaysSelected.value && i >= 0 && i < 5;
                            //     controller.update();
                            //   }
                            // }, (_) {
                            //   controller.setIsWeekdaysSelected(!controller.isWeekdaysSelected.value);
                            //   for (int i = 0; i < controller.repeatDays.length; i++) {
                            //     controller.repeatDays[i] = controller.isWeekdaysSelected.value && i >= 1 && i <= 5;
                            //     controller.update();
                            //   }
                            // }),
                            _buildDivider(),
                            _buildCycleDaysTitle('Cycle Days'.tr,
                                controller.isCustomSelected.value, controller),
                            25.height,
                            TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                primaryColor)),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Done'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: themeController
                                                      .isLightMode.value
                                                  ? lightPrimaryTextColor
                                                  : secondaryTextColor),
                                    ))
                                .withWidth(Get.width)
                                .paddingSymmetric(horizontal: 25),
                          ],
                        ),
                      );
                    });
                  }));
            },
            child: ListTile(
              tileColor: themeController.isLightMode.value
                  ? lightSecondaryBackgroundColor
                  : secondaryBackgroundColor,
              title: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  'Repeat'.tr,
                  style: TextStyle(
                      color: themeController.isLightMode.value
                          ? lightPrimaryTextColor
                          : primaryTextColor,
                      fontWeight:
                          anyDaySelected ? FontWeight.w500 : FontWeight.normal),
                ),
              ),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    controller.daysRepeating.value.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: themeController.isLightMode.value
                            ? lightPrimaryTextColor
                            : primaryTextColor),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: themeController.isLightMode.value
                        ? lightPrimaryDisabledTextColor
                        : primaryDisabledTextColor,
                  )
                ],
              ),
            ),
          );
        });
  }

  void _storeOrPreset(List<bool> toSet, List<bool> toUse) {
    for (var i = 0; i < toUse.length; i++) {
      toSet[i] = toUse[i];
    }
  }

  _buildDivider() => Container(
        color: themeController.isLightMode.value
            ? lightSecondaryBackgroundColor
            : secondaryBackgroundColor,
        child: Divider(
          color: themeController.isLightMode.value
              ? lightPrimaryDisabledTextColor
              : primaryDisabledTextColor,
        ),
      );

  _buildListTitle(String text, bool value, GestureTapCallback onTap,
          ValueChanged onChanged) =>
      ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text),
              Checkbox.adaptive(
                  side: BorderSide(
                      width: 1.5,
                      color: themeController.isLightMode.value
                          ? lightPrimaryTextColor.withOpacity(0.5)
                          : primaryTextColor.withOpacity(0.5)),
                  activeColor: primaryColor.withOpacity(0.8),
                  value: value,
                  onChanged: onChanged)
            ],
          ).paddingAll(8),
        ),
      );

  _buildCycleDaysTitle(
      String text, bool value, EditAlarmsController controller) {
    // DataAlarmCycleBase? dataAlarmCycleBase = Get.find<GetStorageProvider>().readCurrentAlarmCycleData();
    // List<bool> cycleDays = List<bool>.filled(dataAlarmCycleBase!.maxCycleDays(), false);
    List<bool> cycleDays = List.filled(controller.cycleDays.length, false);
    return _buildListTitle(text, value, () {
      _onCycleDaysTap(cycleDays, controller);
    }, (v) {
      _onCycleDaysTap(cycleDays, controller);
      // controller.setIsCustomSelected(v!);
      // _storeOrPreset(controller.cycleDays, cycleDays);
      // controller.update();
    });
  }

  _onCycleDaysTitleTap(List<bool> cycleDays, EditAlarmsController controller) {
    _storeOrPreset(cycleDays, controller.cycleDays);
    // controller.setIsCustomSelected(!controller.isCustomSelected.value);
    Get.defaultDialog(
      onWillPop: () async {
        _storeOrPreset(controller.cycleDays, cycleDays);
        return true;
      },
      barrierDismissible: false,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: 'Cycle Days',
      backgroundColor: themeController.isLightMode.value
          ? lightPrimaryBackgroundColor
          : secondaryBackgroundColor,
      content: GetBuilder(builder: (EditAlarmsController controller) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(
                    side: BorderSide(
                        width: 1.5,
                        color: themeController.isLightMode.value
                            ? lightPrimaryTextColor.withOpacity(0.5)
                            : primaryTextColor.withOpacity(0.5)),
                    activeColor: primaryColor.withOpacity(0.8),
                    value: controller.isCustomSelected.value,
                    onChanged: (v) {
                      controller.isCustomSelected.value = v!;
                      controller.update();
                    }),
                Text(
                  'Harvard-Westlake\nUpper School\nCycle Days_2024-2025',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 15),
                  maxLines: 3,
                )
              ],
            ).paddingOnly(left: 10),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 0, dayName: 'HW US DAY1'.tr)
                : const SizedBox(),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 1, dayName: 'HW US DAY2'.tr)
                : const SizedBox(),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 2, dayName: 'HW US DAY3'.tr)
                : const SizedBox(),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 3, dayName: 'HW US DAY4'.tr)
                : const SizedBox(),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 4, dayName: 'HW US DAY5'.tr)
                : const SizedBox(),
            controller.isCustomSelected.value
                ? _buildCycleDayTitle(controller,
                    dayIndex: 5, dayName: 'HW US DAY6'.tr)
                : const SizedBox(
                    height: 20,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      bool hasTrue = controller.cycleDays.any((it) => it);
                      controller.setIsCustomSelected(
                          hasTrue && controller.isCustomSelected.value);
                      controller.setCycleDaysRepeatingUp();
                      Get.back();
                    },
                    child: Text(
                      'Done'.tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: themeController.isLightMode.value
                              ? lightPrimaryTextColor
                              : secondaryTextColor),
                    )),
              ],
            ).paddingOnly(left: 10),
          ],
        );
      }),
    );
  }

  _onCycleDaysTap(List<bool> cycleDays, EditAlarmsController controller) {
    _storeOrPreset(cycleDays, controller.cycleDays);
    // controller.setIsCustomSelected(!controller.isCustomSelected.value);
    Get.defaultDialog(
      onWillPop: () async {
        _storeOrPreset(controller.cycleDays, cycleDays);
        return true;
      },
      barrierDismissible: false,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: 'Cycle Days',
      backgroundColor: themeController.isLightMode.value
          ? lightPrimaryBackgroundColor
          : secondaryBackgroundColor,
      content: GetBuilder(builder: (EditAlarmsController controller) {
        return Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Checkbox.adaptive(
            //         side: BorderSide(width: 1.5, color: themeController.isLightMode.value ? lightPrimaryTextColor.withOpacity(0.5):primaryTextColor.withOpacity(0.5)),
            //         activeColor: primaryColor.withOpacity(0.8),
            //         value: controller.isCustomSelected.value,
            //         onChanged: (v) {
            //           controller.isCustomSelected.value = v!;
            //           controller.update();
            //         }
            //     ),
            //     Text('Harvard-Westlake\nUpper School\nCycle Days_2024-2025', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15), maxLines: 3,)
            //   ],
            // ).paddingOnly(left: 10),
            for (int i = 0; i < cycleDays.length; i++)
              _buildCycleDayTitle(controller, dayIndex: i, dayName: 'DAY${i + 1}'.tr),

            // _buildCycleDayTitle(controller, dayIndex: 0, dayName: 'DAY1'.tr),
            // _buildCycleDayTitle(controller, dayIndex: 1, dayName: 'DAY2'.tr),
            // _buildCycleDayTitle(controller, dayIndex: 2, dayName: 'DAY3'.tr),
            // _buildCycleDayTitle(controller, dayIndex: 3, dayName: 'DAY4'.tr),
            // _buildCycleDayTitle(controller, dayIndex: 4, dayName: 'DAY5'.tr),
            // _buildCycleDayTitle(controller, dayIndex: 5, dayName: 'DAY6'.tr),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      bool hasTrue = controller.cycleDays.any((it) => it);
                      controller.setIsCustomSelected(
                          hasTrue && controller.isCustomSelected.value);
                      controller.setCycleDaysRepeatingUp();
                      Get.back();
                    },
                    child: Text(
                      'Done'.tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: themeController.isLightMode.value
                              ? lightPrimaryTextColor
                              : secondaryTextColor),
                    )),
              ],
            ).paddingOnly(left: 10),
          ],
        );
      }),
    );
  }

  _buildCycleDayTitle(EditAlarmsController controller,
          {required int dayIndex, required String dayName}) =>
      InkWell(
        onTap: () {
          controller.cycleDays[dayIndex] = !controller.cycleDays[dayIndex];
          bool isCustomSelected =  controller.cycleDays.contains(true);
          controller.isCustomSelected.value =
              isCustomSelected;
          if (!isCustomSelected) {
            controller.daysRepeating.value = 'Never'.tr;
          }
          controller.update();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox.adaptive(
                side: BorderSide(
                    width: 1.5,
                    color: themeController.isLightMode.value
                        ? lightPrimaryTextColor.withOpacity(0.5)
                        : primaryTextColor.withOpacity(0.5)),
                activeColor: primaryColor.withOpacity(0.8),
                value: controller.cycleDays[dayIndex],
                onChanged: (v) {
                  controller.cycleDays[dayIndex] = v!;
                  controller.isCustomSelected.value =
                      controller.cycleDays.contains(true);
                  controller.update();
                }),
            Text(
              dayName,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
            )
          ],
        ).paddingOnly(left: 10),
      );

  _buildWeeklyTitle(String text, bool value, EditAlarmsController controller) {
    // List<bool> repeatDays = List<bool>.filled(7, false);
    return _buildListTitle(text, value, () {
      _onWeeklyTitleTap(controller);
    }, (v) {
      _onWeeklyTitleTap(controller);
    });
  }

  _onWeeklyTitleTap(EditAlarmsController controller) {
    if (controller.isDailySelected.value) {
      _storeOrPreset(controller.repeatDays, repeatDays);
    }
    _storeOrPreset(repeatDays, controller.repeatDays);
    // controller.setIsWeekdaysSelected(!controller.isCustomSelected.value);
    Get.defaultDialog(
      onWillPop: () async {
        _storeOrPreset(controller.repeatDays, repeatDays);
        return true;
      },
      barrierDismissible: false,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: 'Weekly',
      backgroundColor: themeController.isLightMode.value
          ? lightPrimaryBackgroundColor
          : secondaryBackgroundColor,
      content: GetBuilder(builder: (EditAlarmsController controller) {
        return Column(
          children: [
            _buildDayTitle(controller, dayIndex: 0, dayName: 'Mon'.tr),
            _buildDayTitle(controller, dayIndex: 1, dayName: 'Tue'.tr),
            _buildDayTitle(controller, dayIndex: 2, dayName: 'Wed'.tr),
            _buildDayTitle(controller, dayIndex: 3, dayName: 'Thu'.tr),
            _buildDayTitle(controller, dayIndex: 4, dayName: 'Fri'.tr),
            _buildDayTitle(controller, dayIndex: 5, dayName: 'Sat'.tr),
            _buildDayTitle(controller, dayIndex: 6, dayName: 'Sun'.tr),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      bool hasTrue = controller.repeatDays.any((it) => it);
                      controller.setIsWeekdaysSelected(hasTrue);
                      Get.back();
                    },
                    child: Text(
                      'Done'.tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: themeController.isLightMode.value
                              ? lightPrimaryTextColor
                              : secondaryTextColor),
                    )),
              ],
            ).paddingOnly(left: 10),
          ],
        );
      }),
    );
  }

  _buildDayTitle(EditAlarmsController controller,
          {required int dayIndex, required String dayName}) =>
      InkWell(
        onTap: () {
          controller.repeatDays[dayIndex] = !controller.repeatDays[dayIndex];
          controller.update();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox.adaptive(
                side: BorderSide(
                    width: 1.5,
                    color: themeController.isLightMode.value
                        ? lightPrimaryTextColor.withOpacity(0.5)
                        : primaryTextColor.withOpacity(0.5)),
                activeColor: primaryColor.withOpacity(0.8),
                value: controller.repeatDays[dayIndex],
                onChanged: (v) {
                  controller.repeatDays[dayIndex] = v!;
                  controller.update();
                }),
            Text(
              dayName,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
            )
          ],
        ).paddingOnly(left: 10),
      );
}
