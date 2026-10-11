import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/secure_storage_provider.dart';
import '../utils/constants.dart';

class ThemeController extends GetxController {
  var isLightMode = true.obs;
  final _secureStorageProvider = SecureStorageProvider();

  @override
  void onInit() {
    _loadThemeValue();
    super.onInit();
  }

  void _loadThemeValue() async {
    isLightMode.value =
        await _secureStorageProvider.readThemeValue() == AppTheme.light;
    Get.changeThemeMode(isLightMode.value ? ThemeMode.light : ThemeMode.dark);
  }

  void _saveThemeValuePreference() async {
    await _secureStorageProvider.writeThemeValue(
      theme: isLightMode.value ? AppTheme.light : AppTheme.dark,
    );
  }

  void toggleThemeValue(bool enabled) {
    isLightMode.value = enabled;
    _saveThemeValuePreference();
  }

  TextStyle getAppTitleTextStyle(BuildContext context, {double scalingFactor = 1.0}) => Theme.of(context).textTheme.displaySmall!.copyWith(
    color: isLightMode.value ? lightPrimaryDisabledTextColor:primaryDisabledTextColor,
    fontSize: 16 * scalingFactor,);

  Color getAppTextColor() => isLightMode.value
      ? lightPrimaryTextColor
      : primaryTextColor;

  TextStyle getAppTextStyle() => TextStyle(
      color: getAppTextColor(),
      fontWeight: FontWeight.normal);
}
