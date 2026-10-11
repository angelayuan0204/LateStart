import 'package:isar/isar.dart';
part 'calendar_event_model.g.dart';

@collection
class CalendarEventModel {

  Id id = Isar.autoIncrement;
  late String eventName;
  String? title;
  String? description;
  late DateTime calendarDate;
  late DateTime start;
  late DateTime end;
  DateTime? alarmDateTime;
  bool isAlarmOpen = false;
  String? alarmBeforeValue;
  @enumerated
  String repeatOption = 'None';

  CalendarEventModel copyWith({
    Id? id,
    String? eventName,
    String? title,
    String? description,
    DateTime? calendarDate,
    DateTime? start,
    DateTime? end,
    DateTime? alarmDateTime,
    bool? isAlarmOpen,
    String? alarmBeforeValue,
    String? repeatOption,
  }) {
    return CalendarEventModel()
      ..id = id ?? this.id
      ..eventName = eventName ?? this.eventName
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..calendarDate = calendarDate ?? this.calendarDate
      ..start = start ?? this.start
      ..end = end ?? this.end
      ..alarmDateTime = alarmDateTime ?? this.alarmDateTime
      ..isAlarmOpen = isAlarmOpen ?? this.isAlarmOpen
      ..alarmBeforeValue = alarmBeforeValue ?? this.alarmBeforeValue
      ..repeatOption = repeatOption ?? this.repeatOption;
  }

}