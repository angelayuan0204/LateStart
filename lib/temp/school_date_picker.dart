import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:late_start/utils/constants.dart';

class DateScrollerField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;
  final int startYear;
  final int endYear;

  const DateScrollerField({
    super.key,
    required this.label,
    required this.initialDate,
    required this.onDateSelected,
    required this.startYear,
    required this.endYear,
  });

  @override
  State<DateScrollerField> createState() => _DateScrollerFieldState();
}

class _DateScrollerFieldState extends State<DateScrollerField> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  List<int> _daysInMonth(int year, int month) {
    final daysPerMonth = [31, _isLeapYear(year) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return List<int>.generate(daysPerMonth[month - 1], (i) => i + 1);
  }

  void _openDatePicker() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black, // whole bottom sheet background
    builder: (context) {
      int year = selectedDate.year;
      int month = selectedDate.month;
      int day = selectedDate.day;

      return SizedBox(
        height: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(year, month, day);
                      widget.onDateSelected(selectedDate);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: Colors.black,
                      scrollController: FixedExtentScrollController(
                        initialItem: year - widget.startYear,
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        year = widget.startYear + index;
                        if (day > _daysInMonth(year, month).length) {
                          day = _daysInMonth(year, month).last;
                        }
                      },
                      children: List.generate(
                        widget.endYear - widget.startYear + 1,
                        (index) => Center(
                          child: Text(
                            "${widget.startYear + index}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: Colors.black,
                      scrollController: FixedExtentScrollController(initialItem: month - 1),
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        month = index + 1;
                        if (day > _daysInMonth(year, month).length) {
                          day = _daysInMonth(year, month).last;
                        }
                      },
                      children: List.generate(
                        12,
                        (index) => Center(
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setStateDayPicker) {
                        List<int> days = _daysInMonth(year, month);
                        return CupertinoPicker(
                          backgroundColor: Colors.black,
                          scrollController: FixedExtentScrollController(initialItem: day - 1),
                          itemExtent: 32,
                          onSelectedItemChanged: (index) {
                            day = days[index];
                          },
                          children: days
                              .map((d) => Center(
                                    child: Text(
                                      "$d",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    String displayText = selectedDate != null
        ? "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}"
        : "MM/DD/YYYY";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        GestureDetector(
          onTap: _openDatePicker,
          child: Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              displayText,
              style: TextStyle(
                color: selectedDate != null ? Colors.white : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
