import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/breakout_day.dart';

class BreakoutDaysEditPage extends StatefulWidget {
  final List<BreakoutDay> initialDays;
  const BreakoutDaysEditPage({super.key, required this.initialDays});

  @override
  State<BreakoutDaysEditPage> createState() => _BreakoutDaysEditPageState();
}

class _BreakoutDaysEditPageState extends State<BreakoutDaysEditPage> {
  late List<BreakoutDay> editableList;

  @override
  void initState() {
    super.initState();
    editableList = List.from(widget.initialDays);
  }

  void _addCustomBreakout() {
    setState(() {
      editableList.add(BreakoutDay(
        category: "Custom",
        name: "",
        startDate: "",
        endDate: "",
        weekday: "",
      ));
    });
  }

  void _removeBreakout(int index) {
    setState(() {
      editableList.removeAt(index);
    });
  }

  void _confirm() {
    Get.back(result: editableList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Breakout Days"),
        actions: [
          IconButton(onPressed: _addCustomBreakout, icon: const Icon(Icons.add)),
          IconButton(onPressed: _confirm, icon: const Icon(Icons.check)),
        ],
      ),
      body: ListView.builder(
        itemCount: editableList.length,
        itemBuilder: (context, index) {
          final item = editableList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(item.name.isEmpty ? "Untitled" : item.name),
              subtitle: Text(item.date ?? "${item.startDate} → ${item.endDate}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: item.include,
                    onChanged: (v) => setState(() => item.include = v!),
                  ),
                  if (item.category == "Custom")
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => _removeBreakout(index),
                    ),
                ],
              ),
              onTap: () async {

              },
            ),
          );
        },
      ),
    );
  }
}
