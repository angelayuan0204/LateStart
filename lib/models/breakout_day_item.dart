import 'package:intl/intl.dart';

class BreakoutDayItem {
  final String id; // 唯一 id（可用于删除）
  final DateTime date;
  bool selected;
  final bool isCustom; // 是否为用户新增

  BreakoutDayItem({
    required this.id,
    required this.date,
    required this.selected,
    required this.isCustom,
  });

  factory BreakoutDayItem.fromJson(Map<String, dynamic> json) {
    return BreakoutDayItem(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      selected: json['selected'] as bool,
      isCustom: json['isCustom'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'selected': selected,
    'isCustom': isCustom,
  };

  String formatted() => DateFormat('yyyy-MM-dd').format(date);
}