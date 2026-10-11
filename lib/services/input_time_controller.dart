import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';

class InputTimeController extends GetxController {
  final isTimePicker = false.obs;
  final isTimePickerTimer = false.obs;
  TextEditingController inputHrsController = TextEditingController();
  TextEditingController inputMinutesController = TextEditingController();
  TextEditingController inputHoursControllerTimer = TextEditingController();
  TextEditingController inputMinutesControllerTimer = TextEditingController();
  TextEditingController inputSecondsControllerTimer = TextEditingController();
  final selectedDateTime = DateTime.now().obs;
  bool isInputtingTime = false;

  void confirmTimeInput() {
    setTime();
    changeDatePicker();
  }

  @override
  void onInit() {
    isTimePicker.value = true;
    isTimePickerTimer.value = true;
    super.onInit();
  }

  final isAM = true.obs;
  changePeriod(String period) {
    isAM.value = period == 'AM';
    update();
  }

  changeDatePicker() {
    isTimePicker.value = !isTimePicker.value;
  }

  changeTimePickerTimer() {
    isTimePickerTimer.value = !isTimePickerTimer.value;
  }

  int convert24(int value, int meridiemIndex) {
    if (!Get.getSettingsController().is24HrsEnabled.value) {
      if (meridiemIndex == 0) {
        if (value == 12) {
          value = value - 12;
        }
      } else {
        if (value != 12) {
          value = value + 12;
        }
      }
    }
    return value;
  }

  void setTime() {
    selectedDateTime.value = Get.getEditAlarmsController().selectedTime.value;
    isAM.value = Get.getEditAlarmsController().selectedTime.value.hour < 12;
    inputHrsController.text = Get.getSettingsController().is24HrsEnabled.value
        ? selectedDateTime.value.hour.toString()
        : (selectedDateTime.value.hour == 0
            ? 12.toString()
            : (selectedDateTime.value.hour > 12
                ? (selectedDateTime.value.hour - 12).toString()
                : selectedDateTime.value.hour.toString()));
    inputMinutesController.text = selectedDateTime.value.minute.toString();
    try {
      int hour = int.parse(inputHrsController.text);
      if (!Get.getSettingsController().is24HrsEnabled.value) {
        if (isAM.value) {
          if (hour == 12) {
            hour = hour - 12;
          }
        } else {
          if (hour != 12) {
            hour = hour + 12;
          }
        }
      }

      int minute = int.parse(inputMinutesController.text);
      final time = TimeOfDay(hour: hour, minute: minute);
      DateTime today = DateTime.now();
      DateTime tomorrow = today.add(const Duration(days: 1));
      bool isNextDay =
          (time.hour == today.hour && time.minute < today.minute) ||
              (time.hour < today.hour);
      bool isNextMonth = isNextDay && (today.day > tomorrow.day);
      bool isNextYear = isNextMonth && (today.month > tomorrow.month);
      int day = isNextDay ? tomorrow.day : today.day;
      int month = isNextMonth ? tomorrow.month : today.month;
      int year = isNextYear ? tomorrow.month : today.month;
      selectedDateTime.value =
          DateTime(year, month, day, time.hour, time.minute);
      Get.getEditAlarmsController().selectedTime.value = selectedDateTime.value;

      if (!Get.getSettingsController().is24HrsEnabled.value) {
        if (selectedDateTime.value.hour == 0) {
          Get.getEditAlarmsController().hours.value = 12;
        } else if (selectedDateTime.value.hour > 12) {
          Get.getEditAlarmsController().hours.value =
              (selectedDateTime.value.hour - 12);
        } else {
          Get.getEditAlarmsController().hours.value = selectedDateTime.value.hour;
        }
      } else {
        Get.getEditAlarmsController().hours.value = convert24(
            selectedDateTime.value.hour,
            Get.getEditAlarmsController().meridiemIndex.value);
      }
      Get.getEditAlarmsController().minutes.value = selectedDateTime.value.minute;
      if (selectedDateTime.value.hour >= 12) {
        Get.getEditAlarmsController().meridiemIndex.value = 1;
      } else {
        Get.getEditAlarmsController().meridiemIndex.value = 0;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  @override
  void onClose() {
    inputHrsController.dispose();
    inputMinutesController.dispose();
    inputHoursControllerTimer.dispose();
    inputMinutesControllerTimer.dispose();
    inputSecondsControllerTimer.dispose();
    super.onClose();
  }
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    try {
      var value = int.parse(newValue.text);
      if (value < minRange) {
        return TextEditingValue(text: minRange.toString());
      } else if (value > maxRange) {
        return TextEditingValue(text: maxRange.toString());
      }
      return newValue;
    } catch (e) {
      debugPrint(e.toString());
      return newValue;
    }
  }
}
