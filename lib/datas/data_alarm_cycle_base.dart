
import 'package:intl/intl.dart';

import 'data_school_base.dart';

abstract class DataAlarmCycleBase extends DataSchoolBase {

  DateTime startDate();
  DateTime endDate();
  Set<DateTime> excludedDates();
  int maxCycleDays();

  //todo 排查Breakout Days & Weekends（表中HW US CYCLE DAYS 24-25的数据）
  Set<String> excludedDatesToStringSet() {
    Set<String> setFormattedDate = {};
    for (int i = 0; i < excludedDates().length; i++) {
      setFormattedDate.add(formattedDate(excludedDates().elementAt(i)));
    }
    return setFormattedDate;
  }

  String formattedDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

}