import 'package:get/get.dart';
import 'package:late_start/services/calendar_controller.dart';
import 'package:late_start/services/input_time_controller.dart';
import 'package:late_start/services/settings_controller.dart';
import 'package:late_start/services/theme_controller.dart';

import '../providers/get_storage_provider.dart';
import '../services/edit_alarms_controller.dart';
import '../services/alarms_controller.dart';
import '../services/app_controller.dart';
import '../services/firebase_provider.dart';

extension AppGet on GetInterface {

  S _get<S>(S Function() getS) => Get.isRegistered<S>()
      ? Get.find<S>()
      : Get.put<S>(getS());

  Future<void> startAppServices() async {
    Get.lazyPut(() => AppController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => EditAlarmsController(), fenix: true);
    Get.lazyPut(() => InputTimeController(), fenix: true);
    Get.lazyPut(() => ThemeController(), fenix: true);
    await Get.putAsync(() => GetStorageProvider().init());
    Get.lazyPut(() => AlarmsController(), fenix: true);
    Get.lazyPut(() => CalendarController(), fenix: true);
    // Get.lazyPut(() => FirebaseController(), fenix: true);
    await Get.putAsync(() => FirebaseProvider().init());
  }

  AppController getAppController() => _get<AppController>(() => AppController());

  SettingsController getSettingsController() => _get<SettingsController>(() => SettingsController());

  EditAlarmsController getEditAlarmsController() => _get<EditAlarmsController>(() => EditAlarmsController());

  InputTimeController getInputTimeController() => _get<InputTimeController>(() => InputTimeController());

  ThemeController getThemeController() => _get<ThemeController>(() => ThemeController());

  AlarmsController getAlarmsController() => _get<AlarmsController>(() => AlarmsController());

  CalendarController getCalendarController() => _get<CalendarController>(() => CalendarController());

  FirebaseProvider getFirebaseProvider() => _get<FirebaseProvider>(() => FirebaseProvider());

}