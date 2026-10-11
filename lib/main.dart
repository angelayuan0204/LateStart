import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:late_start/pages/app_error_page.dart';
import 'package:late_start/pages/splash_page.dart';
import 'package:nb_utils/nb_utils.dart';

import 'utils/constants.dart';
import 'utils/language.dart';

Locale? loc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }
  // await Get.getFirebaseController().initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: lightThemeData,
      darkTheme: themeData,
      themeMode: ThemeMode.system,
      translations: AppTranslations(),
      locale: loc,
      fallbackLocale: const Locale('en', 'US'),
      builder: (BuildContext context, Widget? error) {
        ErrorWidget.builder = (FlutterErrorDetails? error) {
          return AppErrorPage(errorDetails: error!);
        };
        return error!;
      },
      // home: const HomePage(),
      home: const SplashPage(),
    );
  }
}