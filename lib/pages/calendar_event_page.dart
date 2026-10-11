import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_schedule_view/flutter_schedule_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:late_start/services/alarms_controller.dart';
import 'package:late_start/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../base/app_get.dart';
import '../models/calendar_event_model.dart';
import '../providers/isar_provider.dart';
import '../utils/event_utils.dart';

class CalendarEventPage extends StatefulWidget {
  final CalendarEventModel calendarEventModel;
  const CalendarEventPage({super.key, required this.calendarEventModel});

  @override
  State<CalendarEventPage> createState() => _CalendarEventPageState();
}

class _CalendarEventPageState extends State<CalendarEventPage> {
  final TextEditingController _titleController = TextEditingController();

  List<FlutterWeekViewEvent> events = [];

  String _selectedOption = 'None', _selectedRepeatOption = 'None';

  int _initialTime = 8;

  bool isNewEvent = true;

  final List<String> _options = [
    'None',
    'At time of event',
    '5 min before',
    '15 min before',
    '30 min before',
    '1 hour before',
    '1 day before',
    '1 week before',
  ];

  final List<String> _optionsRepeat = [
    'None',
    'Weekly',
    'Month',
  ];

  @override
  void initState() {
    super.initState();
    isNewEvent = widget.calendarEventModel.eventName.isEmpty;
    if (!isNewEvent) {
      _titleController.text = widget.calendarEventModel.eventName;
      if (widget.calendarEventModel.isAlarmOpen && (widget.calendarEventModel.alarmBeforeValue??_options[0]) == _options[0]) {
        _selectedOption = _options[1];
      } else {
        _selectedOption = widget.calendarEventModel.alarmBeforeValue??_selectedOption;
      }
      // _selectedOption = widget.calendarEventModel.alarmBeforeValue??(widget.calendarEventModel.isAlarmOpen?_options[1]:_selectedOption);
      _selectedRepeatOption = widget.calendarEventModel.repeatOption;
      _initialTime = max(0, widget.calendarEventModel.start.hour - 1);
      events.add(FlutterWeekViewEvent(
        padding: const EdgeInsets.only(left: 16, right: 16),
        title: '',
        description: '',
        eventTextBuilder: createEventTextBuilder,
        start: HourMinute(hour: widget.calendarEventModel.start.hour, minute: widget.calendarEventModel.start.minute).atDate(widget.calendarEventModel.calendarDate),
        end: HourMinute(hour: widget.calendarEventModel.end.hour, minute: widget.calendarEventModel.end.minute).atDate(widget.calendarEventModel.calendarDate),
        decoration: () => newEventDecoration(context),
        isNewEvent: true,
        onTap: (event) => debugPrint('Event 1 has been tapped !'),
      ));
      // _createEvent(widget.calendarEventModel.start, widget.calendarEventModel.end);
    } else {
      events.add(FlutterWeekViewEvent(
        padding: const EdgeInsets.only(left: 16, right: 16),
        title: '',
        description: '',
        eventTextBuilder: createEventTextBuilder,
        start: const HourMinute(hour: 12, minute: 0).atDate(widget.calendarEventModel.calendarDate),
        end: const HourMinute(hour: 13, minute: 0).atDate(widget.calendarEventModel.calendarDate),
        decoration: () => newEventDecoration(context),
        isNewEvent: true,
        onTap: (event) => debugPrint('Event 1 has been tapped !'),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),),
        title: Text("New Event", style: Get.getThemeController().getAppTitleTextStyle(context),),
        // title: const Text(""),
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              if (_titleController.text.isEmpty) {
                toast('Event Name is not empty!'.tr);
                return;
              }
              if (events.isEmpty) {
                toast('The start time and end time need to be set.!'.tr);
                return;
              }
              // 'None',
              // 'At time of event',
              // '5 min before',
              // '15 min before',
              // '30 min before',
              // '1 hour before',
              // '1 day before',
              // '1 week before',
              widget.calendarEventModel.start = events[0].start;
              widget.calendarEventModel.end = events[0].end;
              widget.calendarEventModel.eventName = _titleController.text;
              widget.calendarEventModel.alarmBeforeValue = _selectedOption;
              widget.calendarEventModel.alarmDateTime =
                  _selectedOption == _options[0]?null:
                  _selectedOption == _options[1]?events[0].start:
                  _selectedOption == _options[2]?events[0].start.subtract(const Duration(minutes: 5)):
                  _selectedOption == _options[3]?events[0].start.subtract(const Duration(minutes: 15)):
                  _selectedOption == _options[4]?events[0].start.subtract(const Duration(minutes: 30)):
                  _selectedOption == _options[5]?events[0].start.subtract(const Duration(hours: 1)):
                  _selectedOption == _options[6]?events[0].start.subtract(const Duration(days: 1)):
                  _selectedOption == _options[7]?events[0].start.subtract(const Duration(days: 7)):
                  null;
              widget.calendarEventModel.isAlarmOpen = _selectedOption != _options[0];
              widget.calendarEventModel.calendarDate = widget.calendarEventModel.start.copyWith(hour: 0, minute: 0, second: 0, );
              widget.calendarEventModel.repeatOption = _selectedRepeatOption;
              widget.calendarEventModel.alarmDateTime = await IsarDb.getComputedAlarmTime(widget.calendarEventModel);
              await Get.getCalendarController().addOrUpdateCalendarEvent(widget.calendarEventModel);
              await Get.getAppController().setAlarm(Get.getCalendarController().calendarEventModelToAlarmModel(widget.calendarEventModel));
              await Get.getAlarmsController().initLatestIsarAlarms();
              Get.getCalendarController().setFocusedDay = Get.getCalendarController().getFocusedDay;
              // Get.getCalendarController().setSelectedDayAndFocusedDay(DateTime(widget.calendarEventModel.calendarDate.year, widget.calendarEventModel.calendarDate.month, widget.calendarEventModel.calendarDate.day), DateTime(widget.calendarEventModel.calendarDate.year, widget.calendarEventModel.calendarDate.month));
              Get.back();
            },
            child: Text("Done", style:  Theme.of(context).textTheme.displaySmall!.copyWith(color: primaryColor),),),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            cursorColor: Get.getThemeController().getAppTextColor(),
            decoration: InputDecoration(
              labelText: "Event Name",
              border: InputBorder.none,
              labelStyle: Get.getThemeController().getAppTextStyle(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Get.getThemeController().getAppTextColor()), // 未聚焦时边框颜色
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Get.getThemeController().getAppTextColor()), // 聚焦时边框颜色
              ),
            ),),
          const Divider(),
          Text(DateFormat("MM-dd-yyyy").format(widget.calendarEventModel.calendarDate).tr, style: Get.getThemeController().getAppTextStyle().copyWith(fontSize: 12)).paddingOnly(left: 10),
          const Divider(),
          DayView(
              date: widget.calendarEventModel.calendarDate,
              initialTime: HourMinute(hour: _initialTime),
              userZoomable: false,
              showTimeRangeText: true,
              events: events,
              style: const DayViewStyle(
                backgroundColor: secondaryBackgroundColor,//Color(0xFF9FA8DA),//Colors.white,
                hourRowHeight: 60,
                backgroundRulesColor: Color(0xFFE5E5E5),
                currentTimeRuleColor: primaryColor,//Color(0xFF2563EB),
                currentTimeCircleColor: primaryColor,//Color(0xFF2563EB),
                currentTimeCircleRadius: 5,
                currentTimeRuleHeight: 1,
                currentTimeCirclePosition: CurrentTimeCirclePosition.left,
                currentTimeTextStyle: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5,),),
              hoursColumnStyle: HoursColumnStyle(
                width: 55,
                color: secondaryBackgroundColor,//Color(0xFF9FA8DA),
                textAlignment: Alignment.center,
                textStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
                timeRangeTextStyle: TextStyle(color: Get.getThemeController().getAppTextColor(), fontSize: 12, fontWeight: FontWeight.w400, height: 1.5,),
                interval: const Duration(hours: 1),
              ),
              dragAndDropOptions: DragAndDropOptions(
                // startingGesture: isMobilePlatform()
                //     ? DragStartingGesture.longPress
                //     : DragStartingGesture.tap,
                startingGesture: DragStartingGesture.tap,
                onEventDragged: (FlutterWeekViewEvent event, DateTime dateTime) {
                  DateTime newStartTime = adjustDateTime(dateTime);
                  if (_canCreateEvent(newStartTime, event.end.add(newStartTime.difference(event.start)))) {
                    event.shiftEventTo(newStartTime);
                  }
                },
              ),
              resizeEventOptions: ResizeEventOptions(
                minimumEventDuration: const Duration(minutes: 30),
                snapToGridGranularity: const Duration(minutes: 5),
                onEventResizedUp: (FlutterWeekViewEvent event, DateTime newStartTime) {
                  if (_canCreateEvent(newStartTime, event.end)) {
                    event.start = newStartTime;
                  }
                },
                onEventResizeUpUpdate: (FlutterWeekViewEvent event, DateTime newStartTime) {
                  if (_canCreateEvent(newStartTime, event.end)) {
                    event.start = newStartTime;
                  }
                },
                onEventResizedDown: (FlutterWeekViewEvent event, DateTime newEndTime) {
                  if (_canCreateEvent(event.start, newEndTime)) {
                    event.end = newEndTime;
                  }
                },
                onEventResizeDownUpdate: (FlutterWeekViewEvent event, DateTime newEndTime) {
                  if (_canCreateEvent(event.start, newEndTime)) {
                    event.end = newEndTime;
                  }
                },
              ),
              dragPredicate: (event) {
                return event.isNewEvent;
              },
              resizePredicate: (event) {
                return event.isNewEvent;
              },
              onBackgroundTappedDown: _onBackgroundTappedDown).withHeight(420.0),
          const Divider(),
          ListTile(
            title: Text("Repeat:".tr, style: Get.getThemeController().getAppTextStyle()),
            trailing: Container(
              width: MediaQuery.of(context).size.width/3,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(border: Border.all(color: Get.getThemeController().getAppTextColor()), borderRadius: BorderRadius.circular(8.0)),
              child: DropdownButton<String>(
                dropdownColor: Colors.black,//const Color(0xFF9FA8DA),
                isExpanded: true,
                value: _selectedRepeatOption,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeatOption = newValue!;
                  });
                },
                items: _optionsRepeat.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: Get.getThemeController().getAppTextStyle().copyWith(color: value == _selectedRepeatOption ? primaryColor : Colors.white), textAlign: TextAlign.left,),
                  );
                }).toList(),
              ),
            ),
          ),
          // 6.height,
          ListTile(
            title: Text("Alarm:".tr, style: Get.getThemeController().getAppTextStyle()),
            trailing: Container(
              height: 40,
              width: MediaQuery.of(context).size.width/3,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(border: Border.all(color: Get.getThemeController().getAppTextColor()), borderRadius: BorderRadius.circular(8.0),),
              child: DropdownButton<String>(
                dropdownColor: Colors.black,//const Color(0xFF9FA8DA),
                isExpanded: true,
                value: _selectedOption,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                },
                items: _options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: Get.getThemeController().getAppTextStyle().copyWith(color: value == _selectedOption ? primaryColor : Colors.white), textAlign: TextAlign.left, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
      floatingActionButton: !isNewEvent? _buildFloatingActionButton():null,
    );
  }

  _onBackgroundTappedDown(DateTime dateTime) {
    var list = pickNewTime(dateTime);
    for (int i = 0; i < list.length; i++) {
      if (_canCreateEvent(list[i], list[i].add(const Duration(minutes: 30)))) {
        _createEvent(list[i], list[i].add(const Duration(minutes: 30)));
        break;
      }
    }
  }

  bool _canCreateEvent(DateTime newEventStart, DateTime newEventEnd) {
    // if (!newEventStart.isAfter(DateTime.now())) {
    //   print('++++++++_canCreateEvent,return 00');
    //   return false;
    // }

    if (!newEventEnd.isAfter(newEventStart)) {
      debugPrint('++++++++_canCreateEvent,return 11');
      return false;
    }
    // if (!DateUtils.isSameDay(newEventStart, DateTime.now())) {
    //   print('++++++++_canCreateEvent,return 22');
    //   return false;
    // }
    if (!DateUtils.isSameDay(newEventStart, widget.calendarEventModel.calendarDate)) {
      debugPrint('++++++++_canCreateEvent,return 22');
      return false;
    }

    // if (!DateUtils.isSameDay(newEventEnd, DateTime.now()) &&
    //     !(newEventEnd.hour == 0 &&
    //         newEventEnd.minute == 0 &&
    //         newEventEnd.second == 0)) {
    //   print('++++++++_canCreateEvent,return 33');
    //   return false;
    // }
    if (!DateUtils.isSameDay(newEventEnd, widget.calendarEventModel.calendarDate) && !(newEventEnd.hour == 0 && newEventEnd.minute == 0 && newEventEnd.second == 0)) {
      debugPrint('++++++++_canCreateEvent,return 33');
      return false;
    }
    for (int i = 0; i < events.length; i++) {
      var event = events[i];
      if (event.isNewEvent) {
        continue;
      }
      if ((newEventStart.isAfter(event.end) || newEventStart.isAtSameMomentAs(event.end)) || (newEventEnd.isBefore(event.start) || newEventEnd.isAtSameMomentAs(event.start))) {
        continue;
      }
      return false;
    }

    return true;
  }

  _createEvent(DateTime start, DateTime end) {
    debugPrint('create event: start ${start.toString()} - end:${end.toString()}');
    setState(() {
      // events.removeWhere((element) => element.isNewEvent);
      events.clear();
      events.add(
        FlutterWeekViewEvent(
          title: NEW_EVENT_TEXT,
          description: NEW_EVENT_TEXT,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: () => newEventDecoration(context),
          eventTextBuilder: createEventTextBuilder,
          start: start,
          end: end,
          isNewEvent: true,
          onTap: (event) {
            debugPrint('+++++++++++++++++++++onTap:${event.start},${event.end}');
          },
        ),
      );
    });
  }

  _buildFloatingActionButton() => TextButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor),),
    child: Text('Delete'.tr ,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
        color: Get.getThemeController().isLightMode.value ? lightPrimaryTextColor : secondaryTextColor,
      ),
    ),
    onPressed: () async {
      if (widget.calendarEventModel.repeatOption == 'Weekly' || widget.calendarEventModel.repeatOption == 'Month') {
        showConfirmDialog(context, 'This is a repeat event. If you choose to delete it, all related events in the calendar will be removed.', onAccept: () async {
          await _deleteCalendarEvent();
          Get.back();
        });
      } else {
        await _deleteCalendarEvent();
      }
    },
  ).withSize(width: Get.width * 0.8, height: Get.height * 0.06).paddingAll(18);

  _deleteCalendarEvent() async {
    // await Get.getCalendarController().deleteCalendarEvent(widget.calendarEventModel);
    // await Get.getCalendarController().refreshData();
    // await Get.getAlarmsController().initLatestIsarAlarms();
    // await Alarm.stop(widget.calendarEventModel.id);
    await Get.getCalendarController().cleanCalendarEventModelEvent(widget.calendarEventModel);
    Get.back();
  }
}