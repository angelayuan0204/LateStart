
import 'package:isar/isar.dart';
part 'alarm_model.g.dart';

@collection
class AlarmModel {
  Id isarId = Isar.autoIncrement;

  late String alarmTime;
  late String alarmID;
  late bool isEnabled;
  late int minutesSinceMidnight;
  late List<bool> days;
  late String label;
  late String assetAudioPath;
  late bool loopAudio;
  late bool vibrate;
  late double? volume;
  late int fadeDuration;
  late String notificationTitle;
  late String notificationBody;
  late bool enableNotificationOnKill;
  late bool androidFullScreenIntent;
  late int type;
  late int alarmSettingsId;
  late String? alarmSettingsDateTime;
  late String? alarmNextDateTime;
  // late String ringtoneName;
  // late int activityMonitor;

  AlarmModel({
    required this.alarmTime,
    required this.alarmID,
    this.isEnabled = true,
    required this.minutesSinceMidnight,
    required this.days,
    required this.label,
    required this.assetAudioPath,
    required this.loopAudio,
    required this.vibrate,
    this.volume,
    required this.fadeDuration,
    required this.notificationTitle,
    required this.notificationBody,
    required this.enableNotificationOnKill,
    required this.androidFullScreenIntent,
    this.type = 0,
    required this.alarmSettingsId,
    this.alarmSettingsDateTime,
    this.alarmNextDateTime,
  });

  Map<String, dynamic> toSQFliteMap() {
    return {
      'alarmTime': alarmTime,
      'alarmID': alarmID,
      'isEnabled': isEnabled ? 1 : 0,
      'minutesSinceMidnight': minutesSinceMidnight,
      'days': boolListToString(days),
      'label': label,
      'assetAudioPath': assetAudioPath,
      'loopAudio': loopAudio ? 1 : 0,
      'vibrate': vibrate ? 1 : 0,
      'volume': '${volume??''}',
      'fadeDuration': fadeDuration,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
      'enableNotificationOnKill': enableNotificationOnKill ? 1 : 0,
      'androidFullScreenIntent': androidFullScreenIntent ? 1 : 0,
      'type': type,
      'alarmSettingsId': alarmSettingsId,
      'alarmSettingsDateTime': alarmSettingsDateTime,
      'alarmNextDateTime': alarmNextDateTime
    };
  }

  String boolListToString(List<bool> boolList) {
    var rotatedList = [boolList.last] + boolList.sublist(0, boolList.length - 1);
    return rotatedList.map((b) => b ? '1' : '0').join();
  }

  // String intListToString(List<int> intList) {
  //   if (intList.isEmpty) {
  //     return "";
  //   }
  //   var rotatedList = [intList.last] + intList.sublist(0, intList.length - 1);
  //   return rotatedList.map((b) => b).join();
  // }

  double? getVolume() {
    return double.tryParse('$volume');
  }

}