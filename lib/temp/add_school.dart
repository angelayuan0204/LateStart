import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/datas/DATA_HWUS.dart';
import 'package:late_start/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../datas/data_base.dart';
import '../datas/dynamic_data_base.dart';
import '../datas/school_calendar_model.dart';
import '../pages/breakout_days_edit_new_page.dart';
import '../services/firebase_provider.dart';
import 'school_date_picker.dart';
import 'school_year.dart';

class AddSchoolPage extends StatefulWidget {
  final DataBase? dataBase;
  final bool isOnlyLocal;
  const AddSchoolPage({super.key, required this.dataBase, required this.isOnlyLocal});

  @override
  State<AddSchoolPage> createState() => _AddSchoolPageState();
}

class _AddSchoolPageState extends State<AddSchoolPage> {
  String? selectedSchoolYear;
  String? selectedCycleDays;
  bool includeWeekends = true;
  bool privateUse = false;

  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolAbbreviationController = TextEditingController();
  final TextEditingController firstDayController = TextEditingController();
  final TextEditingController lastDayController = TextEditingController();

  final List<String> schoolYearOptions = ['2025-2026', '2026-2027'];
  final List<String> cycleDayOptions = ['2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String selectedStartYear = '0';
  String selectedEndYear = '0';
  DateTime? firstDay, lastDay;

  @override
  void initState() {
    super.initState();
    _initFromDataBase();
  }

  void _initFromDataBase() {
    final db = widget.dataBase??DATA_HWUS();
    // 学校名称与缩写
    schoolNameController.text = widget.dataBase == null ? "" : db.fullName();
    schoolAbbreviationController.text = widget.dataBase == null ? "" : db.abbreviation();

    // 获取 calendars 中最后一条
    if (db.schoolCalendarModels().isNotEmpty) {
      final lastCalendar = db.schoolCalendarModels().last;

      firstDay = lastCalendar.startDate;
      lastDay = lastCalendar.endDate;

      firstDayController.text = "${firstDay!.month}/${firstDay!.day}/${firstDay!.year}";
      lastDayController.text = "${lastDay!.month}/${lastDay!.day}/${lastDay!.year}";

      selectedStartYear = firstDay!.year.toString();
      selectedEndYear = lastDay!.year.toString();
      selectedSchoolYear = "$selectedStartYear-$selectedEndYear";

      selectedCycleDays = lastCalendar.maxCycleDays.toString();
      includeWeekends = lastCalendar.isExcludedWeekend;
    } else {
      firstDay = DateTime.now();
      lastDay = DateTime.now().add(const Duration(days: 365));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Update School', style: TextStyle(color: primaryTitleGrayColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Center(
            //   child: Text(
            //     "Create a school",
            //     style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            const Text('School Year'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 1.0,
                    ),
                  ),
                color: Colors.transparent,),
              child: SchoolYearPicker(
                onYearSelected: (year) {
                  setState(() {
                    selectedSchoolYear = year;
                    selectedStartYear = year.split('-')[0];
                    selectedEndYear = year.split('-')[1];
                  });
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Text('School Name'),
            TextField(
              controller: schoolNameController,
              decoration: const InputDecoration(
                hintText: 'Enter your school name',
                hintStyle: TextStyle(color: Colors.grey),//
                border: OutlineInputBorder(),
                isDense: true,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text('Abbreviation'),
            TextField(
              controller: schoolAbbreviationController,
              decoration: const InputDecoration(
                hintText: 'Enter your school abbreviation',
                hintStyle: TextStyle(color: Colors.grey),//
                border: OutlineInputBorder(),
                isDense: true,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            DateScrollerField(
              label: "First Day of School Cycle",
              initialDate: DateTime(int.parse(selectedStartYear), 8, 1),
              startYear: int.parse(selectedStartYear),
              endYear: int.parse(selectedStartYear),
              onDateSelected: (date) {
                firstDayController.text = "${date.month}/${date.day}/${date.year}";
                firstDay = date;
              },
            ),
            const SizedBox(height: 10),
            DateScrollerField(
              label: "Last Day of School Cycle",
              initialDate: DateTime(int.parse(selectedEndYear), 6, 30),
              startYear: int.parse(selectedEndYear),
              endYear: int.parse(selectedEndYear),
              onDateSelected: (date) {
                lastDayController.text = "${date.month}/${date.day}/${date.year}";
                lastDay = date;
              },
            ),
            const SizedBox(height: 10),
            const Text('Cycle Days'),
            DropdownButtonFormField<String>(
              hint: const Text('Choose 2-10 Day Cycle, Select Only', style: TextStyle(color: Colors.grey)),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              dropdownColor: Colors.black,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              value: (selectedCycleDays?.isEmpty ?? true) ? null : selectedCycleDays,
              onChanged: (value) => setState(() => selectedCycleDays = value ?? ''),
              items: cycleDayOptions.map((cycle) {
                return DropdownMenuItem(
                  value: cycle,
                  child: Text(cycle),
                );
              }).toList(),
            ),
            // const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: const BorderSide(color: Colors.white),
                  ),
                  checkColor: WidgetStateProperty.all(primaryColor),
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  }),
                  side: const BorderSide(width: 1.5, color: Colors.white),
                ),
              ),
              child: CheckboxListTile(
                value: includeWeekends,
                onChanged: (value) => setState(() => includeWeekends = value!),
                title: const Text('Weekends Excluded', style: TextStyle(color: Colors.white, fontSize: 14)),
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            // const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Breakout Days'),
                TextButton(
                  onPressed: () async {
                    await Navigator.push<SchoolCalendarModel?>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BreakoutDaysEditNewPage(
                          dataBase: widget.dataBase??DATA_HWUS(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Edit', style: TextStyle(color: primaryColor)),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: _uploadSchoolData,
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _uploadSchoolData() async {
    if (schoolNameController.text.trim().isEmpty ||
        schoolAbbreviationController.text.trim().isEmpty ||
        firstDay == null ||
        lastDay == null ||
        (selectedCycleDays ?? '').isEmpty) {
      toast("Please complete all the fields.".tr);
      return;
    }

    final provider = Get.getFirebaseProvider();
    String email = provider.currentUserEmail;
      if (!widget.isOnlyLocal && email.isEmpty) {
        final success = await provider.signInWithGoogle();
        if (!success) {
          toast("Sign in error!");
          return;
        }
        email = provider.currentUserEmail;
      }

    if (Get.getCalendarController().getCurrentData != null) {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Get.getThemeController().isLightMode.value
            ? lightSecondaryBackgroundColor
            : secondaryBackgroundColor,
        title: 'Delete Local Data?'.tr,
        titleStyle: Theme.of(context).textTheme.displaySmall,
        content: Column(
          children: [
            // Text('delete sure?'.tr,
            //     style: Theme.of(context).textTheme.bodyMedium,
            //     textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: primaryColor,
                          width: 1)),
                  child: Text('Cancel'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: primaryColor)),
                ),
                SizedBox(width: 10,),
                OutlinedButton(
                  onPressed: () async {
                    await Get.getCalendarController().cleanCurrentData();
                    Get.back();
                    await _doUploadSchoolData(provider, email);
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Get.getThemeController().isLightMode.value
                              ? Colors.red.withOpacity(0.9)
                              : Colors.red,
                          width: 1)),
                  child: Text('Delete'.tr,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Get.getThemeController().isLightMode.value
                              ? Colors.red.withOpacity(0.9)
                              : Colors.red)),
                ),
              ],
            ).paddingOnly(top: 20),
          ],
        ),
      );
    } else {
      _doUploadSchoolData(provider, email);
    }
  }

  _doUploadSchoolData(FirebaseProvider provider, String email) async {

    try {

      final storage = GetStorage();

      // 从本地读取 Breakout Days 数据
      // Map<String, dynamic> storedBreakout = storage.read('custom_breakout_days') ?? {};
      // Map<String, dynamic> checkedBreakout = storage.read('checked_breakout_days') ?? {};
      final checkedBreakoutResult = storage.read('custom_breakout_days_result');
      Map<DateTime, List<String>> schoolEvents = {};
      Set<DateTime> breakoutDays = {};
      if (checkedBreakoutResult != null) {
        (checkedBreakoutResult as Map).forEach((key, value) {
          final date = DateTime.tryParse(key);
          if (date != null) {
            List<String> eventValues = List<String>.from(value);
            if (eventValues.last == "Convocation") {
              eventValues.last = "Convo-\ncation";
            } else if (eventValues.last.contains("#")) {
              eventValues.last = eventValues.last.split("#").first;
            }
            schoolEvents[date] = eventValues;
          }
        });
      } else {
        schoolEvents = (widget.dataBase??DATA_HWUS()).schoolEvents();
      }
      // 所有 schoolEvents 的日期
      breakoutDays.addAll(schoolEvents.keys);

      if(includeWeekends && firstDay != null && lastDay != null) {
        DateTime current = firstDay!;
        while (!current.isAfter(lastDay!)) {
          if (current.weekday == DateTime.saturday || current.weekday == DateTime.sunday) {
            breakoutDays.add(DateTime(current.year, current.month, current.day));
          }
          current = current.add(const Duration(days: 1));
        }
      }

      final newCalendar = SchoolCalendarModel(
        startDate: firstDay!,
        endDate: lastDay!,
        breakoutDays: breakoutDays,
        isExcludedWeekend: includeWeekends,
        hasLateStart: false,
        maxCycleDays: int.parse(selectedCycleDays!),
      );

      late final DynamicDataBase newData;

      if (widget.dataBase != null) {
        // 编辑模式：更新最后一条 calendar
        // final db = widget.dataBase! as DynamicDataBase;
        final calendars = List<SchoolCalendarModel>.from(widget.dataBase!.schoolCalendarModels());

        if (calendars.isNotEmpty) {
          calendars[calendars.length - 1] = newCalendar;
        } else {
          calendars.add(newCalendar);
        }

        newData = DynamicDataBase(
          fullName: schoolNameController.text.trim(),
          abbreviation: schoolAbbreviationController.text.trim().toUpperCase(),
          startDate: newCalendar.startDate,
          endDate: newCalendar.endDate,
          schoolCalendarModels: calendars,
          schoolEvents: schoolEvents,
        );

        if (!widget.isOnlyLocal) await provider.updateSchoolData(userEmail: email, newData: newData);
      } else {
        // 新建模式：添加为 calendars 第一条
        final calendars = [newCalendar];

        newData = DynamicDataBase(
          fullName: schoolNameController.text.trim(),
          abbreviation: schoolAbbreviationController.text.trim().toUpperCase(),
          startDate: newCalendar.startDate,
          endDate: newCalendar.endDate,
          schoolCalendarModels: calendars,
          schoolEvents: schoolEvents,
        );
        if (!widget.isOnlyLocal)  await provider.createSchoolData(userEmail: email, schoolData: newData);
      }
      Get.getCalendarController().setCurrentData = newData;
      Get.back();
    } catch (e) {
      debugPrint("error: $e");
      toast("Error: ${e.toString()}");
    }

  }

  @override
  void dispose() {
    final storage = GetStorage();
    storage.remove('custom_breakout_days');
    storage.remove('checked_breakout_days');
    storage.remove('custom_breakout_days_result');
    super.dispose();
  }

// _uploadSchoolData() async {
  //
  //   if (Get.getFirebaseProvider().currentUserEmail == '') {
  //     if (!await Get.getFirebaseProvider().signInWithGoogle()) {
  //       toast("sign in error!");
  //       return;
  //     }
  //   }
  //   await Get.getFirebaseProvider().createSchoolData(userEmail: Get.getFirebaseProvider().currentUserEmail, schoolData: DATA_HWUS());
  //   toast("createSchoolData success!");
  // }


}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class MMDDDateInputFormatter extends TextInputFormatter {
  final bool isStartDate;
  final String schoolYear;

  MMDDDateInputFormatter({required this.isStartDate, required this.schoolYear});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);

    String formatted = '';

    // Handle Month
    if (digitsOnly.length >= 1) {
      int firstDigit = int.parse(digitsOnly[0]);
      if (firstDigit > 1) return oldValue;
      formatted = digitsOnly[0];
    }
    if (digitsOnly.length >= 2) {
      int month = int.parse(digitsOnly.substring(0, 2));
      if (month < 1 || month > 12) return oldValue;
      formatted = digitsOnly.substring(0, 2) + '/';
    }

    // Handle Day
    if (digitsOnly.length == 3) {
      String dayTens = digitsOnly[2];
      if (!RegExp(r'[0-3]').hasMatch(dayTens)) return oldValue;
      formatted += dayTens;
    }

    if (digitsOnly.length == 4) {
      int month = int.parse(digitsOnly.substring(0, 2));
      int day = int.parse(digitsOnly.substring(2, 4));

      int year = int.parse(schoolYear.split('-')[isStartDate ? 0 : 1]);

      int maxDay;
      if (month == 2) {
        bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        maxDay = isLeapYear ? 29 : 28;
      } else if ([4, 6, 9, 11].contains(month)) {
        maxDay = 30;
      } else {
        maxDay = 31;
      }

      if (day < 1 || day > maxDay) return oldValue;

      formatted += digitsOnly.substring(2, 4) + '/$year';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

}
