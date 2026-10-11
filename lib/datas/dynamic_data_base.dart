import 'data_base.dart';
import 'school_calendar_model.dart';

class DynamicDataBase extends DataBase {
  final String _fullName;
  final String _abbreviation;
  final DateTime _startDate;
  final DateTime _endDate;
  final List<SchoolCalendarModel> _schoolCalendarModels;
  final Map<DateTime, List<String>> _schoolEvents;

  DynamicDataBase({
    required String fullName,
    required String abbreviation,
    required DateTime startDate,
    required DateTime endDate,
    required List<SchoolCalendarModel> schoolCalendarModels,
    required Map<DateTime, List<String>> schoolEvents,
  })
      : _fullName = fullName,
        _abbreviation = abbreviation,
        _startDate = startDate,
        _endDate = endDate,
        _schoolCalendarModels = schoolCalendarModels,
        _schoolEvents = schoolEvents;

  @override
  String abbreviation() => _abbreviation;

  @override
  String fullName() => _fullName;

  @override
  DateTime startDate() => _startDate;

  @override
  DateTime endDate() => _endDate;

  @override
  List<SchoolCalendarModel> schoolCalendarModels() => _schoolCalendarModels;

  @override
  Map<DateTime, List<String>> schoolEvents() => _schoolEvents;

  DynamicDataBase copyWith({
    String? fullName,
    String? abbreviation,
    DateTime? startDate,
    DateTime? endDate,
    List<SchoolCalendarModel>? schoolCalendarModels,
    Map<DateTime, List<String>>? schoolEvents,
  }) {
    return DynamicDataBase(
      fullName: fullName ?? this.fullName(),
      abbreviation: abbreviation ?? this.abbreviation(),
      startDate: startDate ?? this.startDate(),
      endDate: endDate ?? this.endDate(),
      schoolCalendarModels: schoolCalendarModels ?? this.schoolCalendarModels(),
      schoolEvents: schoolEvents ?? this.schoolEvents(),
    );
  }

  // fromJson：从 Firestore / Storage / JSON 字典构造
  factory DynamicDataBase.fromJson(Map<String, dynamic> data) {
    final List<dynamic> calendarsJson = data['calendars'] ?? [];
    final Map<String, dynamic> eventsJson =
    Map<String, dynamic>.from(data['events'] ?? {});

    final calendars = calendarsJson.map((c) {
      return SchoolCalendarModel(
        startDate: DateTime.parse(c['startDate']),
        endDate: DateTime.parse(c['endDate']),
        breakoutDays: (c['breakoutDays'] as List<dynamic>)
            .map((e) => DateTime.parse(e))
            .toSet(),
        isExcludedWeekend: c['isExcludedWeekend'] ?? true,
        hasLateStart: c['hasLateStart'] ?? false,
        maxCycleDays: c['maxCycleDays'],
      );
    }).toList();

    final Map<DateTime, List<String>> events = {};
    eventsJson.forEach((key, value) {
      events[DateTime.parse(key)] = List<String>.from(value);
    });

    return DynamicDataBase(
      fullName: data['fullName'] ?? 'Unknown School',
      abbreviation: data['abbreviation'] ?? 'Unknown',
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      schoolCalendarModels: calendars,
      schoolEvents: events,
    );
  }

  // toJson：转成可存储到 Firestore / GetStorage 的格式
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> eventsJson = {};
    _schoolEvents.forEach((key, value) {
      eventsJson[key.toIso8601String()] = value;
    });

    return {
      'fullName': _fullName,
      'abbreviation': _abbreviation,
      'startDate': _startDate.toIso8601String(),
      'endDate': _endDate.toIso8601String(),
      'calendars': _schoolCalendarModels.map((model) => model.toJson()).toList(),
      'events': eventsJson,
    };
  }

}