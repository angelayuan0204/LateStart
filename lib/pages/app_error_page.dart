import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/pages/home_page.dart';
import 'package:nb_utils/nb_utils.dart';

import '../services/theme_controller.dart';
import '../utils/constants.dart';

class AppErrorPage extends StatefulWidget {

  final FlutterErrorDetails? errorDetails;

  const AppErrorPage({super.key, this.errorDetails});

  @override
  State<AppErrorPage> createState() => _AppErrorPageState();
}

class _AppErrorPageState extends State<AppErrorPage> {

  ThemeController themeController = Get.getThemeController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeController.isLightMode.value
          ? lightPrimaryBackgroundColor
          : primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error Occurred',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: themeController.isLightMode.value
                        ? lightPrimaryTextColor
                        : primaryTextColor,
                  ),
                ),
                (Get.height * 0.18).toInt().height,
                Icon(Icons.warning_amber_outlined, color: themeController.isLightMode.value
                    ? lightPrimaryTextColor
                    : primaryTextColor, size: 50,),
                 30.height,
                Text(
                  kDebugMode
                      ? widget.errorDetails?.summary.toString()??''
                      : 'Something went wrong! Don\'t worry we\'re'
                      'working on it!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: themeController.isLightMode.value
                        ? lightPrimaryTextColor
                        : primaryTextColor,
                  ),
                ),
                30.height,
                OutlinedButton(
                  onPressed: () {
                    Get.offAll(const HomePage());
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Navigate to Home',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ).center(),
          ),
        ),
      ),
    );
  }
}