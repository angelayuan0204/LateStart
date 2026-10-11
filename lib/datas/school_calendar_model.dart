class SchoolCalendarModel {

  late DateTime startDate;
  late DateTime endDate;
  late Set<DateTime> breakoutDays;
  bool isExcludedWeekend;
  bool hasLateStart;
  int maxCycleDays;

  SchoolCalendarModel({required this.startDate, required this.endDate, required this.breakoutDays, this.isExcludedWeekend = true, required this.hasLateStart, required this.maxCycleDays});

  int getDayOfCycle(DateTime givenDate) {
    DateTime currentDate = DateTime(givenDate.year, givenDate.month, givenDate.day);

    List<DateTime> validDates = [];
    for (DateTime date = startDate; date.isBefore(endDate) || date.isAtSameMomentAs(endDate); date = date.add(const Duration(days: 1))) {
      if (isExcludedWeekend && (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday)) {
        continue;
      }

      DateTime validDate = DateTime(date.year, date.month, date.day);

      if (breakoutDays.contains(validDate)) {
        continue;
      }

      validDates.add(validDate);
    }

    if (!validDates.contains(currentDate)) {
      return -1;
    }

    int index = validDates.indexOf(currentDate);
    return (index % maxCycleDays) + 1;
  }

  factory SchoolCalendarModel.fromJson(Map<String, dynamic> json) {
    return SchoolCalendarModel(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      breakoutDays: (json['breakoutDays'] as List<dynamic>)
          .map((e) => DateTime.parse(e))
          .toSet(),
      isExcludedWeekend: json['isExcludedWeekend'] ?? true,
      hasLateStart: json['hasLateStart'] ?? false,
      maxCycleDays: json['maxCycleDays'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'breakoutDays': breakoutDays.map((d) => d.toIso8601String()).toList(),
      'isExcludedWeekend': isExcludedWeekend,
      'hasLateStart': hasLateStart,
      'maxCycleDays': maxCycleDays,
    };
  }
}