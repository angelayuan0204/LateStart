import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/services/edit_alarms_controller.dart';

import '../services/theme_controller.dart';
import '../utils/constants.dart';

class LabelTitle extends StatelessWidget {
  final ThemeController themeController = Get.getThemeController();
  LabelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (EditAlarmsController controller) {
      return ListTile(
        tileColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text('Label'.tr, style: TextStyle(color: themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor,),),
        ),
        trailing: InkWell(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                width: 100,
                alignment: Alignment.centerRight,
                child: Text((controller.label.value.trim().isNotEmpty) ? controller.label.value : 'Off'.tr, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: (controller.label.value.trim().isEmpty) ? themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor : themeController.isLightMode.value
                        ? lightPrimaryTextColor : primaryTextColor,),),
              ),
              Icon(
                Icons.chevron_right,
                color: (controller.label.value.trim().isEmpty) ? themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor : themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor,),
            ],
          ),
        ),
        onTap: () {
          Get.defaultDialog(
            title: 'Add a label'.tr,
            titlePadding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
            backgroundColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            titleStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: themeController.isLightMode.value ? lightPrimaryTextColor : primaryTextColor,),
            contentPadding: const EdgeInsets.all(21),
            content: TextField(
              autofocus: true,
              controller: controller.labelController,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: themeController.isLightMode.value ? lightPrimaryTextColor.withOpacity(0.75) : primaryTextColor.withOpacity(0.75),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeController.isLightMode.value ? lightPrimaryTextColor.withOpacity(0.75) : primaryTextColor.withOpacity(0.75), width: 1,),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeController.isLightMode.value ? lightPrimaryTextColor.withOpacity(0.75) : primaryTextColor.withOpacity(0.75), width: 1,),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeController.isLightMode.value ? lightPrimaryTextColor.withOpacity(0.75) : primaryTextColor.withOpacity(0.75), width: 1,),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),),
                hintText: 'Enter a label'.tr,
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: themeController.isLightMode.value ? lightPrimaryDisabledTextColor : primaryDisabledTextColor,),),
              onChanged: (text) {
                if (text.trim().isEmpty) {
                  controller.labelController.text = '';
                  if (text.isNotEmpty) {
                    Get.snackbar('Note'.tr, 'noWhitespace'.tr, backgroundColor: Colors.red, colorText: Colors.white,);
                  }
                  controller.update();
                }
              },
            ),
            buttonColor: themeController.isLightMode.value ? lightSecondaryBackgroundColor : secondaryBackgroundColor,
            confirm: TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor),),
              child: Text('Save'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: themeController.isLightMode.value ? lightPrimaryTextColor : secondaryTextColor,),),
              onPressed: () {
                controller.label.value = controller.labelController.text;
                controller.update();
                Get.back();
              },
            ),
          );
        },
      );
    });
  }

}