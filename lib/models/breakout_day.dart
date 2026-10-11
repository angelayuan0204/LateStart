class BreakoutDay {
  String category;
  String name;
  String? date;        // 单日事件
  String? startDate;   // 多日事件
  String? endDate;
  String weekday;
  bool include;

  BreakoutDay({
    required this.category,
    required this.name,
    this.date,
    this.startDate,
    this.endDate,
    this.weekday = '',
    this.include = true,
  });

  Map<String, dynamic> toJson() => {
    'category': category,
    'name': name,
    'date': date,
    'startDate': startDate,
    'endDate': endDate,
    'weekday': weekday,
    'include': include,
  };

  factory BreakoutDay.fromJson(Map<String, dynamic> json) => BreakoutDay(
    category: json['category'] ?? '',
    name: json['name'] ?? '',
    date: json['date'],
    startDate: json['startDate'],
    endDate: json['endDate'],
    weekday: json['weekday'] ?? '',
    include: json['include'] ?? true,
  );
}