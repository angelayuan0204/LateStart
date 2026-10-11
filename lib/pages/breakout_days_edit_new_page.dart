import 'package:alarm/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/datas/data_base.dart';
import 'package:late_start/datas/data_manager.dart';

import '../temp/school_date_picker.dart';
import '../utils/constants.dart';

class BreakoutDaysEditNewPage extends StatefulWidget {

  final DataBase? dataBase;

  const BreakoutDaysEditNewPage({super.key, this.dataBase});

  @override
  State<BreakoutDaysEditNewPage> createState() => _BreakoutDaysEditNewPageState();
}

class _BreakoutDaysEditNewPageState extends State<BreakoutDaysEditNewPage> {

  late Map<String, bool> checkedFlattenMap;
  late Map<String, List<DateTime>> flattenEvents;

  late Map<DateTime, List<String>> localEvents;
  late Map<String, List<DateTime>> localFlattenEvents;

  final _storage = GetStorage();
  final String breakoutDaysKey = 'custom_breakout_days';
  final String breakoutCheckedKey = 'checked_breakout_days';
  final String breakoutDaysResultKey = 'custom_breakout_days_result';

  late Map<DateTime, List<String>> sourceEvent;

  
  @override
  void initState() {
    super.initState();
    sourceEvent = widget.dataBase?.schoolEvents()??<DateTime, List<String>>{};
    if (sourceEvent.isEmpty) {
      flattenEvents = {};
      localFlattenEvents = {};
      Get.getFirebaseProvider().fetchPublicBreakoutDays().then((res) {
        sourceEvent = res;
        _initEvents();
      });
    } else {
      _initEvents();
    }

  }

  _initEvents() {
    flattenEvents = DataManager.flatten(sourceEvent, true);
    // 按日期升序排序 flattenEvents
    final sortedEntries = flattenEvents.entries.toList()
      ..sort((a, b) {
        final aFirstDate = a.value.isNotEmpty ? a.value.first : DateTime(9999);
        final bFirstDate = b.value.isNotEmpty ? b.value.first : DateTime(9999);
        return aFirstDate.compareTo(bFirstDate);
      });

    // 转回 Map（保持排序）
    flattenEvents = {for (var e in sortedEntries) e.key: e.value};

    debugPrint('BreakoutDaysEditNewPage:flattenEvents->$flattenEvents');
    checkedFlattenMap = {for (var key in flattenEvents.keys) key: true};
    debugPrint('BreakoutDaysEditNewPage:checkedFlattenMap->$checkedFlattenMap');

    // 初始化本地自定义 Breakout 事件数据
    localEvents = {};
    localFlattenEvents = {};

    // ========== 恢复保存的数据 ==========
    final savedLocal = _storage.read(breakoutDaysKey);
    if (savedLocal != null && savedLocal is Map) {
      localEvents = savedLocal.map((key, value) {
        final date = DateTime.tryParse(key);
        if (date != null) {
          return MapEntry(date, List<String>.from(value));
        } else {
          return MapEntry(DateTime(2000), <String>[]);
        }
      });
      localFlattenEvents = DataManager.flatten(localEvents, false);
    }

    // 恢复勾选状态
    final savedChecked = _storage.read(breakoutCheckedKey);
    if (savedChecked != null && savedChecked is Map) {
      // savedChecked 是 Map<String, bool>
      checkedFlattenMap = {
        for (var entry in savedChecked.entries)
          entry.key: entry.value == true, // 防止 null
      };
    }

    setState(() {

    });
    debugPrint('BreakoutDaysEditNewPage restored:\nlocalEvents: $localEvents\ncheckedFlattenMap: $checkedFlattenMap');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
        title: Text("Breakout Days", style: Get.getThemeController().getAppTitleTextStyle(context),),
        // title: const Text(""),
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              // 保存 localEvents
              final dataToSave = localEvents.map((key, value) => MapEntry(key.toIso8601String(), value));
              await _storage.write(breakoutDaysKey, dataToSave);

              // 保存勾选状态
              await _storage.write(breakoutCheckedKey, checkedFlattenMap);

              // 1 从 flattenEvents 中筛选所有被勾选的项目
              final selectedEvents = <String, List<DateTime>>{};
              checkedFlattenMap.forEach((key, isChecked) {
                if (isChecked == true && flattenEvents.containsKey(key)) {
                  selectedEvents[key] = flattenEvents[key]!;
                }
              });
              // checkedFlattenMap.forEach((key, isChecked) {
              //   if (isChecked == true && flattenEvents.containsKey(key)) {
              //     //  提取干净 event 名（去掉时间戳部分）
              //     final cleanKey = key.split('#').first;
              //     selectedEvents[cleanKey] = flattenEvents[key]!;
              //   }
              // });

              // 2 将 selectedEvents 转换为 Map<DateTime, List<String>>
              final Map<DateTime, List<String>> selectedDateMap = {};
              for (final entry in selectedEvents.entries) {
                for (final date in entry.value) {
                  selectedDateMap.putIfAbsent(date, () => []).add(entry.key);
                }
              }

              // 3 合并 selectedDateMap 与 localEvents
              final Map<DateTime, List<String>> merged = {...selectedDateMap};

              for (final entry in localEvents.entries) {
                merged.update(
                  entry.key,
                      (existing) => [...existing, ...entry.value],
                  ifAbsent: () => entry.value,
                );
              }

              // 4 保存到本地
              final dataToSaveResult = merged.map((key, value) => MapEntry(key.toIso8601String(), value));
              await _storage.write(breakoutDaysResultKey, dataToSaveResult);

              Get.snackbar('Saved', 'Your breakout days and selections have been saved.');
              Navigator.pop(context);
            },
            child: Text("Done", style:  Theme.of(context).textTheme.displaySmall!.copyWith(color: primaryColor),),),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("National Holidays \"*\"", style: Get.getThemeController().getAppTitleTextStyle(context).copyWith(color: primaryColor),),
          ...flattenEvents.entries.map((entry) {
            final title = entry.key;
            final dates = entry.value;
            // final dateRangeText = _formatDateRange(dates);

            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title == 'Convo-\ncation'?'Convocation':title.replaceAll('\n', ' ').split("#").first,
                            style: Get.getThemeController().getAppTextStyle().copyWith(color: primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Checkbox(
                          activeColor: Colors.transparent,
                          checkColor: primaryColor,
                          // 选中时填充框的背景颜色（因为我们想要白色背景，所以设为白色）
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.transparent; // 背景白色
                            }
                            return Colors.transparent; // 未选中时背景白色
                          }),
                          // 边框颜色
                          side: const BorderSide(
                            color: Colors.white, // 边框灰色
                            width: 1.5,
                          ),
                          value: checkedFlattenMap[title],
                          onChanged: (v) {
                            setState(() {
                              checkedFlattenMap[title] = v ?? false;
                            });
                            // 实时保存选择状态
                            // _storage.write(breakoutCheckedKey, checkedFlattenMap);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 0),
                      child: _buildDateRangeText(dates),
                    ),
                    // if (dateRangeText.isNotEmpty)

                    // const Divider(height: 0),
                    // const SizedBox(height: 8),
                  ],
                );
              },
            );
          }),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text("Add a Breakout Day", style: Get.getThemeController().getAppTitleTextStyle(context).copyWith(color: primaryColor),)
              ),
              GestureDetector(
                child: const Icon(Icons.add_circle_sharp, size: 20, color: primaryColor,).paddingSymmetric(horizontal: 10),
                onTap: () {
                  _addBreakoutDay();
                },
              )
            ],
          ),
          const SizedBox(height: 6),
          ...localFlattenEvents.entries.map((entry) {
            final title = entry.key;
            final dates = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Get.getThemeController().getAppTextStyle().copyWith(color: primaryColor),
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.remove_circle_sharp, size: 20, color: primaryColor,).paddingSymmetric(horizontal: 10),
                      onTap: () {
                        setState(() {
                          // 同时从 localEvents 中移除对应事件
                          localEvents.removeWhere((key, value) => value.contains(title));
                          localFlattenEvents = {...localFlattenEvents}..remove(title);

                          // 同步保存删除后的状态
                          // final dataToSave = localEvents.map((key, value) => MapEntry(key.toIso8601String(), value));
                          // _storage.write(breakoutDaysKey, dataToSave);

                        });
                      },

                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: _buildDateRangeText(dates),
                ),
                // if (dateRangeText.isNotEmpty)

                // const Divider(height: 1),
                // const SizedBox(height: 8),
              ],
            );
          }),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  _addBreakoutDay() {

    TextEditingController breakoutDayTitleController = TextEditingController();
    DateTime? startDateTime = widget.dataBase?.startDate()??DateTime.now(), endDateTime = widget.dataBase?.startDate()??DateTime.now();
    Get.defaultDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      backgroundColor: Get.getThemeController().isLightMode.value
          ? lightSecondaryBackgroundColor
          : secondaryBackgroundColor,
      title: 'Add a Breakout Day'.tr,
      titleStyle: Theme.of(context).textTheme.displaySmall,
      content: Column(
        children: [
          // Text('title'.tr,
          //     style: Theme.of(context).textTheme.bodyMedium,
          //     textAlign: TextAlign.center),
          TextField(
            controller: breakoutDayTitleController,
            decoration: const InputDecoration(
              hintText: 'Input Name',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 10),
          DateScrollerField(
            label: "Start Date",
            initialDate: startDateTime,
            startYear: widget.dataBase?.startDate().year??DateTime.now().year,
            endYear: widget.dataBase?.endDate().year??DateTime.now().add(const Duration(days: 365)).year,
            onDateSelected: (date) {
              startDateTime = date;
              // firstDayController.text = "${date.month}/${date.day}/${date.year}";
              // firstDay = date;
            },
          ),
          const SizedBox(height: 10),
          DateScrollerField(
            label: "End Date",
            initialDate: endDateTime,
            startYear: widget.dataBase?.startDate().year??DateTime.now().year,
            endYear: widget.dataBase?.endDate().year??DateTime.now().add(const Duration(days: 365)).year,
            onDateSelected: (date) {
              endDateTime = date;
              // firstDayController.text = "${date.month}/${date.day}/${date.year}";
              // firstDay = date;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Get.getThemeController().isLightMode.value
                            ? Colors.red.withOpacity(0.9)
                            : Colors.red,
                        width: 1)),
                child: Text('Cancel'.tr,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Get.getThemeController().isLightMode.value
                            ? Colors.red.withOpacity(0.9)
                            : Colors.red)),
              ),
              TextButton(
                onPressed: () async {
                  // 校验输入
                  if (breakoutDayTitleController.text.trim().isEmpty) {
                    Get.snackbar('Error', 'Please input a title');
                    return;
                  }
                  if (startDateTime == null || endDateTime == null) {
                    Get.snackbar('Error', 'Please select both start and end dates');
                    return;
                  }

                  // 确保 start <= end
                  if (!startDateTime!.isSameSecond(endDateTime!) && endDateTime!.isBefore(startDateTime!)) {
                    Get.snackbar('Error', 'End date must be after start date');
                    return;
                  }

                  localEvents[startDateTime!] = [breakoutDayTitleController.text.trim()];
                  // 生成日期区间
                  List<DateTime> dateRange = [];
                  for (DateTime d = startDateTime!;
                  !d.isAfter(endDateTime!);
                  d = d.add(const Duration(days: 1))) {
                    dateRange.add(DateTime(d.year, d.month, d.day));
                    localEvents[dateRange.last] = [breakoutDayTitleController.text.trim()];
                  }

                  // 保存到 localEvents
                  // localEvents[startDateTime!] = [breakoutDayTitleController.text.trim()];

                  // 重新计算 flatten + checked map
                  localFlattenEvents = DataManager.flatten(localEvents, false);
                  // checkedLocalFlattenMap = {
                  //   for (var key in localFlattenEvents.keys) key: true,
                  // };

                  // 刷新界面
                  setState(() {});

                  // 关闭弹窗
                  Get.back();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
                child: Text('Add'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.white)).paddingSymmetric(horizontal: 23),
              ),
            ],
          ).paddingOnly(top: 20),
        ],
      ),
    );

  }


  String _formatDateRange(List<DateTime> dates) {
    if (dates.isEmpty) return '';
    // 先排序，确保首尾是时间范围
    dates.sort((a, b) => a.compareTo(b));
    final formatter = DateFormat('MM-dd-yyyy');
    final start = formatter.format(dates.first);
    final end = formatter.format(dates.last);
    return '$start to $end';
    // 如果想单日不重复写两遍，也可改成：
    // return start == end ? start : '$start to $end';
  }

  Widget _buildDateRangeText(List<DateTime> dates) {
    if (dates.isEmpty) return const SizedBox.shrink();
    dates.sort((a, b) => a.compareTo(b));

    final formatter = DateFormat('MM-dd-yyyy');
    final start = formatter.format(dates.first);
    final end = formatter.format(dates.last);
    final isSame = start == end;

    return RichText(
      text: TextSpan(
        style: Get.getThemeController().getAppTextStyle(),
        children: [
          TextSpan(text: start),
          ...[
            const TextSpan(
              text: '  to  ',
              style: TextStyle(color: primaryColor),
            ),
            TextSpan(text: !isSame?end:start, style: Get.getThemeController().getAppTextStyle()),
          ],
        ],
      ),
    );
  }

}