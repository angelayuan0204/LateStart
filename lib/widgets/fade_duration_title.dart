
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/services/edit_alarms_controller.dart';
import 'package:late_start/services/theme_controller.dart';
import 'package:numberpicker/numberpicker.dart';

import '../utils/constants.dart';

class FadeDurationTitle extends StatelessWidget {

  final ThemeController themeController = Get.getThemeController();

  FadeDurationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (EditAlarmsController controller) {
      int duration = 0;
      return InkWell(
        onTap: () {
          Get.defaultDialog(
            onWillPop: () async {
              Get.back();
              controller.fadeDuration.value = duration;
              controller.update();
              return true;
            },
            titlePadding: const EdgeInsets.only(top: 20),
            backgroundColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            title: 'Select duration'.tr,
            titleStyle: Theme.of(context).textTheme.displaySmall,
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NumberPicker(
                      value: controller.fadeDuration.value,
                      minValue: 0,
                      maxValue: 1440,
                      onChanged: (value) {
                        controller.fadeDuration.value = value;
                        controller.update();
                      },
                    ),
                    Text(controller.fadeDuration.value > 1 ? 'minutes'.tr : 'minute'.tr,),
                  ],
                ).paddingSymmetric(vertical: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor,),
                  child: Text('Done'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: themeController.isLightMode.value ? lightPrimaryTextColor : secondaryTextColor,)),
                ),
              ],
            )
          );

        },
        child: ListTile(
          tileColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
          title: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text('Fade Duration'.tr, style: TextStyle(color: themeController.isLightMode.value?lightPrimaryTextColor:primaryTextColor),),
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(controller.fadeDuration.value > 0?'${controller.fadeDuration.value} min': 'Off'.tr, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: (controller.fadeDuration.value <= 0)?themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor
                    :themeController.isLightMode.value?lightPrimaryTextColor:primaryTextColor
              ),),
              Icon(Icons.chevron_right, color: themeController.isLightMode.value?lightPrimaryDisabledTextColor:primaryDisabledTextColor,)
            ],
          ),

        ),
      );
    });
  }

}