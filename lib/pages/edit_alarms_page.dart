import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/models/alarm_model.dart';
import 'package:late_start/services/edit_alarms_controller.dart';
import 'package:late_start/services/input_time_controller.dart';
import 'package:late_start/services/settings_controller.dart';
import 'package:late_start/widgets/repeat_title.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:numberpicker/numberpicker.dart';

import '../services/theme_controller.dart';
import '../utils/constants.dart';
import '../widgets/custom_volume_title.dart';
import '../widgets/fade_duration_title.dart';
import '../widgets/label_title.dart';

class EditAlarmsPage extends StatefulWidget {
  const EditAlarmsPage({super.key});

  @override
  State<EditAlarmsPage> createState() => _EditAlarmsPageState();
}

class _EditAlarmsPageState extends State<EditAlarmsPage> {

  ThemeController themeController = Get.getThemeController();
  SettingsController settingsController = Get.getSettingsController();

  @override
  void initState() {
    super.initState();
    Get.getEditAlarmsController().onInit();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (EditAlarmsController editAlarmsController) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          editAlarmsController.checkUnsavedChangesAndNavigate(context);
        },
        child: Scaffold(
          appBar: _buildAppBar(editAlarmsController),
          body: ListView(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.32,
                color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
                child: GetBuilder(init: Get.getInputTimeController(), builder: (InputTimeController inputTimeController) {
                  return InkWell(
                    onTap: () {
                      inputTimeController.changeDatePicker();
                    },
                    child: inputTimeController.isTimePicker.value?Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,children: [
                      _buildNumberPicker(settingsController.is24HrsEnabled.value?0:1, settingsController.is24HrsEnabled.value?23:12, editAlarmsController.hours.value, (value) {
                        editAlarmsController.hours.value = value;
                        editAlarmsController.selectedTime.value = DateTime(editAlarmsController.selectedTime.value.year, editAlarmsController.selectedTime.value.month, editAlarmsController.selectedTime.value.day,
                            inputTimeController.convert24(value, editAlarmsController.meridiemIndex.value), editAlarmsController.selectedTime.value.minute);
                        inputTimeController.inputHrsController.text = editAlarmsController.hours.value.toString();
                        inputTimeController.inputMinutesController.text = editAlarmsController.minutes.value.toString();
                        inputTimeController.changePeriod(editAlarmsController.meridiemIndex.value == 0? 'AM':'PM');
                        editAlarmsController.update();
                        inputTimeController.update();
                      }),
                      Text(':', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold, color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor),).paddingSymmetric(horizontal: Get.width * 0.02),
                      _buildNumberPicker(0, 59, editAlarmsController.minutes.value, (value) {
                        editAlarmsController.minutes.value = value;
                        editAlarmsController.selectedTime.value = DateTime(editAlarmsController.selectedTime.value.year, editAlarmsController.selectedTime.value.month, editAlarmsController.selectedTime.value.day, editAlarmsController.selectedTime.value.hour,
                          editAlarmsController.minutes.value);
                        inputTimeController.inputHrsController.text = editAlarmsController.hours.value.toString();
                        inputTimeController.inputMinutesController.text = editAlarmsController.minutes.value.toString();
                        inputTimeController.changePeriod(editAlarmsController.meridiemIndex.value == 0 ? 'AM':'PM');
                        editAlarmsController.update();
                        inputTimeController.update();
                      }),
                      Text(':', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold, color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor),)
                          .paddingSymmetric(horizontal: Get.width * 0.02).visible(!(settingsController.is24HrsEnabled.value)),
                      _buildNumberPicker(0, 1, editAlarmsController.meridiemIndex.value, (value) {
                        editAlarmsController.meridiemIndex.value = value;
                        editAlarmsController.selectedTime.value = DateTime(editAlarmsController.selectedTime.value.year, editAlarmsController.selectedTime.value.month, editAlarmsController.selectedTime.value.day, inputTimeController.convert24(editAlarmsController.hours.value, editAlarmsController.meridiemIndex.value),
                            editAlarmsController.minutes.value);
                        inputTimeController.inputHrsController.text = editAlarmsController.hours.value.toString();
                        inputTimeController.inputMinutesController.text = editAlarmsController.minutes.value.toString();
                        inputTimeController.changePeriod(editAlarmsController.meridiemIndex.value == 0 ? 'AM':'PM');
                        editAlarmsController.update();
                        inputTimeController.update();
                      }, infiniteLoop: false, zeroPad: false, textMapper: (numberText) {
                        return editAlarmsController.meridiem[int.parse(numberText)].value;
                      }).visible(!(settingsController.is24HrsEnabled.value)),
                    ],):Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _buildTextField('HH', 0, settingsController.is24HrsEnabled.value?23:12, (_) {
                        inputTimeController.setTime();
                      }, inputTimeController.inputHrsController),
                      Text(':', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,).withWidth(16),
                      _buildTextField('MM', 00, 59, (_) {
                        inputTimeController.setTime();
                      }, inputTimeController.inputMinutesController),
                      16.width,
                      DropdownButton(
                        underline: Container(),
                        value: inputTimeController.isAM.value?'AM':'PM',
                        dropdownColor: themeController.isLightMode.value?lightPrimaryBackgroundColor:primaryBackgroundColor,
                        items: ['AM', 'PM'].map((String period) => DropdownMenuItem<String>(child: Text(period), value: period,)).toList(),
                        onChanged: (getPeriod) {
                          inputTimeController.changePeriod(getPeriod!);
                          inputTimeController.setTime();
                        }
                      ).visible(!settingsController.is24HrsEnabled.value),
                      12.width,
                      InkWell(
                        onTap: () {
                          inputTimeController.confirmTimeInput();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primaryColor, width: 1.0),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.done, color: primaryColor,),
                        ),
                      ).visible(inputTimeController.isTimePicker.isFalse)
                    ],),

                  );
                },),
              ),
              const RepeatTitle(),
              Container(color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
                child: Divider(
                  color: themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,
                ),
              ),
              FadeDurationTitle(),
              Container(color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
                child: Divider(
                  color: themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,
                ),
              ),
              LabelTitle(),
              Container(color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
                child: Divider(
                  color: themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,
                ),
              ),
              const CustomVolumeTitle(),

            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingActionButton(editAlarmsController),
        ),
      );
    });
  }

  Widget _buildNumberPicker(int minValue, int maxValue, int value, ValueChanged<int> onChanged, {bool infiniteLoop = true, bool zeroPad = true, TextMapper? textMapper}) => NumberPicker(minValue: minValue, maxValue: maxValue, value: value, onChanged: onChanged, infiniteLoop: infiniteLoop, itemWidth: Get.width * 0.17, zeroPad: zeroPad,
    selectedTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold, color: primaryColor),
    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20, color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor),
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: Get.width * 0.005,
            color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor,
          ),
          bottom: BorderSide(
            width: Get.width * 0.005,
            color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor,
          ),
        )
    ),
    textMapper: textMapper,
  );

  _buildAppBar(EditAlarmsController controller) => AppBar(
    backgroundColor: controller.alarmRecord.value != null ? themeController.isLightMode.value ? lightPrimaryBackgroundColor : primaryBackgroundColor
        : themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: Theme.of(context).iconTheme,
    // title: controller.alarmRecord.value != null ? const Text('') : Text('Rings in @timeToAlarm'.trParams(
    //   {
    //     'timeToAlarm':
    //     controller.timeToAlarm.value.toString(),
    //   },
    // ), style: Theme.of(context).textTheme.titleSmall,),
    title: const Text(''),

  );

  _buildTextField(String hintText, int minRange, int maxRange, ValueChanged<String> onChanged, TextEditingController controller) => TextField(
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintText,
      border: InputBorder.none,
    ),
    textAlign: TextAlign.center,
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp('[1,2,3,4,5,6,7,8,9,0]'),
      ),
      LengthLimitingTextInputFormatter(2),
      LimitRange(minRange, maxRange)
    ],
  ).withWidth(80);

  _buildFloatingActionButton(EditAlarmsController controller) => TextButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor),),
    child: Text((controller.alarmRecord.value = Get.arguments) == null || (controller.alarmRecord.value!.alarmID.isEmpty) ? 'Save'.tr : 'Update'.tr,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
        color: themeController.isLightMode.value ? lightPrimaryTextColor : secondaryTextColor,
      ),
    ),
    onPressed: () async {
      try {
        controller.alarmRecord.value = Get.arguments;
        if (controller.alarmRecord.value == null|| controller.alarmRecord.value!.alarmID.isEmpty) {
          await controller.createAlarm(controller.createAlarmModel());
          Get.getAlarmsController().initLatestIsarAlarms(needRefreshAlarm: true);
        } else {
          AlarmModel updatedAlarmModel = controller.updatedAlarmModel();
          await controller.updateAlarm(updatedAlarmModel);
        }
      } catch (e) {
        debugPrint(e.toString());
      }

    },
  ).withSize(width: Get.width * 0.8, height: Get.height * 0.06).paddingAll(18);
}