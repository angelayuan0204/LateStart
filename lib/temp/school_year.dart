import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolYearPicker extends StatefulWidget {
  final Function(String) onYearSelected;

  const SchoolYearPicker({super.key, required this.onYearSelected});

  @override
  State<SchoolYearPicker> createState() => _SchoolYearPickerState();
}

class _SchoolYearPickerState extends State<SchoolYearPicker> {
  final List<String> schoolYears = List.generate(
    75,
    (index) {
      int start = 2024 + index;
      return '$start-${start + 1}';
    },
  );

  late String selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = getDefaultSchoolYear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onYearSelected(selectedYear);
    });
  }

  String getDefaultSchoolYear() {
    final now = DateTime.now();
    int startYear = now.month >= 8 ? now.year : now.year - 1;
    return '$startYear-${startYear + 1}';
  }

  void _showYearPicker() {
    int initialIndex = schoolYears.indexOf(selectedYear);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: initialIndex),
            backgroundColor: Colors.black,
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedYear = schoolYears[index];
                widget.onYearSelected(selectedYear);
              });
            },
            children: schoolYears
                .map((year) => Center(
                      child: Text(
                        year,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   title: const Text(
    //     'School Year',
    //     style: TextStyle(color: Colors.white),
    //   ),
    //   subtitle: Text(
    //     selectedYear,
    //     style: const TextStyle(color: Colors.grey),
    //   ),
    //   onTap: _showYearPicker,
    // );
    return GestureDetector(
      onTap: _showYearPicker,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          selectedYear,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}