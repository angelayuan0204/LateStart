

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/services/edit_alarms_controller.dart';

import '../services/theme_controller.dart';
import '../utils/constants.dart';

class CustomVolumeTitle extends StatefulWidget {


  const CustomVolumeTitle({super.key});

  @override
  State<CustomVolumeTitle> createState() => _CustomVolumeTitleState();
}

class _CustomVolumeTitleState extends State<CustomVolumeTitle> {
  final ThemeController themeController = Get.getThemeController();
  double lastVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (EditAlarmsController controller) {
      bool isCustomVolume = controller.volume.value != null;
      return Column(
        children: [
          ListTile(
            tileColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Custom Volume'.tr,
                style: TextStyle(color: themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor,),
              ),
            ),
            trailing: Switch.adaptive(
              value: isCustomVolume,
              activeColor: secondaryColor,
              onChanged: (value) {
                controller.volume.value = !value ? null : lastVolume;
                controller.update();
              },
            ),
            onTap: () {
              controller.volume.value = null;
              controller.update();
            },
          ),
          Container(
            color: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            height: 30,
            child: controller.volume.value != null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(controller.volume.value! > 0.7 ? Icons.volume_up_rounded : controller.volume.value! > 0.1 ? Icons.volume_down_rounded : Icons.volume_mute_rounded,).paddingOnly(left: 20),
                Expanded(
                  child: Slider(
                    value: controller.volume.value!,
                    onChanged: (value) {
                      lastVolume = value;
                      controller.volume.value = lastVolume;
                      controller.update();
                    },
                  ),
                ),
              ],
            ).paddingOnly(bottom: 10) : const SizedBox(),
          ),
        ],
      );
    });
  }
}