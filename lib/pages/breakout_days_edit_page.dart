import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../datas/data_base.dart';
import '../datas/school_calendar_model.dart';
import '../models/breakout_day_item.dart';

class BreakoutDaysEditPage extends StatefulWidget {
  final DataBase? dataBase;
  const BreakoutDaysEditPage({
    super.key,
    this.dataBase,
  });

  @override
  State<BreakoutDaysEditPage> createState() => _BreakoutDaysEditPageState();
}

class _BreakoutDaysEditPageState extends State<BreakoutDaysEditPage> {
  final DateFormat _format = DateFormat('yyyy-MM-dd');
  final GetStorage _storage = GetStorage();

  late String _storageKey;
  late SchoolCalendarModel _currentCalendar;

  /// Breakout days + events 集合
  List<BreakoutDayItem> _items = [];

  /// 每天的事件列表（key = 日期字符串，value = List<String>）
  Map<String, List<String>> _events = {};

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initModelAndLoad();
  }

  void _initModelAndLoad() {
    SchoolCalendarModel? calendar = widget.dataBase?.schoolCalendarModels().last;

    calendar ??= SchoolCalendarModel(
      startDate: DateTime(DateTime.now().year, 8, 1),
      endDate: DateTime(DateTime.now().year + 1, 6, 30),
      breakoutDays: {},
      isExcludedWeekend: true,
      hasLateStart: false,
      maxCycleDays: 8,
    );

    _currentCalendar = calendar;

    String abbr = widget.dataBase?.abbreviation() ?? 'unknown';
    _storageKey = 'breakout_events_${abbr}_${calendar.startDate.toIso8601String()}_${calendar.endDate.toIso8601String()}';

    final raw = _storage.read(_storageKey);
    if (raw != null) {
      try {
        final map = Map<String, dynamic>.from(raw);
        _items = (map['items'] as List)
            .map((e) => BreakoutDayItem.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        _events = Map<String, List<String>>.from((map['events'] ?? {}).map(
              (key, val) => MapEntry(key, List<String>.from(val)),
        ));
        final baseEvents = widget.dataBase?.schoolEvents() ?? {};
        // 合并 widget.dataBase?.schoolEvents()
        for (final entry in baseEvents.entries) {
          _events.update(
            entry.key.toString().split(' ').first,
            // entry.key.toString(),
            (existing) => [...existing, ...entry.value],
            ifAbsent: () => List<String>.from(entry.value),
          );
        }
      } catch (e) {
        _items = _initFromCalendar(calendar);
        _events = {};
      }
    } else {
      _items = _initFromCalendar(calendar);
      _events = {};
    }

    _sortItems();
    setState(() => _initialized = true);
  }

  List<BreakoutDayItem> _initFromCalendar(SchoolCalendarModel calendar) {
    final list = <BreakoutDayItem>[];
    for (final dt in calendar.breakoutDays) {
      final dateOnly = DateTime(dt.year, dt.month, dt.day);
      list.add(BreakoutDayItem(
        id: dateOnly.toIso8601String(),
        date: dateOnly,
        selected: true,
        isCustom: false,
      ));
    }
    return list;
  }

  void _sortItems() {
    _items.sort((a, b) => a.date.compareTo(b.date));
  }

  Future<void> _saveToStorage() async {
    final raw = {
      'items': _items.map((e) => e.toJson()).toList(),
      'events': _events,
    };
    await _storage.write(_storageKey, raw);
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// ✅ 添加 Breakout Day
  Future<void> _onAddDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;
    final dateOnly = DateTime(picked.year, picked.month, picked.day);

    final existing = _items.indexWhere((it) => _isSameDate(it.date, dateOnly));
    if (existing >= 0) {
      setState(() {
        _items[existing].selected = true;
      });
    } else {
      _items.add(BreakoutDayItem(
        id: DateTime.now().toIso8601String(),
        date: dateOnly,
        selected: true,
        isCustom: true,
      ));
      _sortItems();
    }
    await _saveToStorage();
  }

  /// ✅ 添加 Event
  Future<void> _onAddEvent() async {
    DateTime selectedDate = DateTime.now();
    String eventText = '';

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    selectedDate = picked;
                  }
                },
                child: Text(
                  'Date: ${_format.format(selectedDate)}',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(labelText: 'Event name'),
                onChanged: (v) => eventText = v.trim(),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                if (eventText.isEmpty) return;
                final key = _format.format(selectedDate);
                _events.putIfAbsent(key, () => []);
                _events[key]!.add(eventText);

                // 如果该天已有 breakout 记录，则融合；否则创建新的未选中项
                final existing = _items.indexWhere((it) => _isSameDate(it.date, selectedDate));
                if (existing < 0) {
                  _items.add(BreakoutDayItem(
                    id: DateTime.now().toIso8601String(),
                    date: selectedDate,
                    selected: false,
                    isCustom: true,
                  ));
                  _sortItems();
                }

                await _saveToStorage();
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  /// ✅ 删除单个事件
  Future<void> _deleteEvent(String dateKey, int index) async {
    _events[dateKey]?.removeAt(index);
    if (_events[dateKey]?.isEmpty ?? false) {
      _events.remove(dateKey);
    }
    await _saveToStorage();
    setState(() {});
  }

  Future<void> _toggleSelected(BreakoutDayItem item) async {
    setState(() => item.selected = !item.selected);
    await _saveToStorage();
  }

  Future<void> _onDeleteItem(BreakoutDayItem item) async {
    if (!item.isCustom) {
      toast('This date is from calendar data and cannot be deleted.');
      return;
    }
    _items.removeWhere((it) => it.id == item.id);
    await _saveToStorage();
    setState(() {});
  }

  Future<void> _onSaveAndExit() async {
    final updated = SchoolCalendarModel(
      startDate: _currentCalendar.startDate,
      endDate: _currentCalendar.endDate,
      breakoutDays: _items
          .where((e) => e.selected)
          .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
          .toSet(),
      isExcludedWeekend: _currentCalendar.isExcludedWeekend,
      hasLateStart: _currentCalendar.hasLateStart,
      maxCycleDays: _currentCalendar.maxCycleDays,
      // schoolEvents: _events, // ✅ 同步 events 数据
    );
    await _saveToStorage();
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Breakout Days & Events'),
        centerTitle: true,
        actions: [
          TextButton(onPressed: _onAddDate, child: const Text('Add Day', style: TextStyle(color: Colors.white))),
          TextButton(onPressed: _onAddEvent, child: const Text('Add Event', style: TextStyle(color: Colors.white))),
          TextButton(onPressed: _onSaveAndExit, child: const Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No days yet'))
          : ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, i) {
          final item = _items[i];
          final dateKey = _format.format(item.date);
          final eventList = _events[dateKey] ?? [];

          return ExpansionTile(
            initiallyExpanded: eventList.isNotEmpty, // ✅ 有事件才默认展开
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                Checkbox(
                  value: item.selected,
                  onChanged: (_) => _toggleSelected(item),
                ),
                Text(item.formatted()),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _onDeleteItem(item),
            ),
            children: [
              // 显示已有事件
              for (int j = 0; j < eventList.length; j++)
                ListTile(
                  title: Text(eventList[j]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          String edited = eventList[j];
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text('Edit Event'),
                                content: TextField(
                                  autofocus: true,
                                  controller: TextEditingController(text: edited),
                                  onChanged: (v) => edited = v,
                                ),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      if (edited.trim().isNotEmpty) {
                                        setState(() {
                                          _events[dateKey]![j] = edited.trim();
                                        });
                                        _saveToStorage();
                                      }
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _deleteEvent(dateKey, j),
                      ),
                    ],
                  ),
                ),

              const Divider(),

              // ✅ 添加事件入口
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton.icon(
                  onPressed: () async {
                    String eventText = '';
                    await showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Add Event'),
                          content: TextField(
                            autofocus: true,
                            decoration: const InputDecoration(labelText: 'Event name'),
                            onChanged: (v) => eventText = v.trim(),
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                if (eventText.isEmpty) return;
                                _events.putIfAbsent(dateKey, () => []);
                                _events[dateKey]!.add(eventText);

                                // 如果该天没有 BreakoutDay，则创建一个未选中项
                                if (!_items.any((it) => _isSameDate(it.date, item.date))) {
                                  _items.add(BreakoutDayItem(
                                    id: DateTime.now().toIso8601String(),
                                    date: item.date,
                                    selected: false,
                                    isCustom: true,
                                  ));
                                  _sortItems();
                                }

                                _saveToStorage();
                                Navigator.pop(ctx);
                                setState(() {});
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Event'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}