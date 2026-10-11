import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import '../datas/data_base.dart';
import 'add_school.dart';

class ConfigurationsPage extends StatelessWidget {
  const ConfigurationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Configurations',
              style: TextStyle(
                color: primaryTitleGrayColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '(LateStart Pro)',
              style: TextStyle(
                color: primaryTitleGrayColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const ListTile(
            //   leading: Icon(
            //     Icons.person,
            //     color: primaryColor,
            //   ),
            //   title: Text('Sign in/Register for Pro'),
            // ),
            ListTile(
              leading: const Icon(Icons.apartment, color: primaryColor),
              title: const Text('Add/Update the School'),
              onTap: () async {
                if ((Get.getFirebaseProvider().currentUserEmail) =="") {
                  if (!await Get.getFirebaseProvider().signInWithGoogle()) {
                    toast("sign in error!");
                    return;
                  }
                }
                DataBase? dataBase = await Get.getFirebaseProvider().fetchSchoolDataByEmail(Get.getFirebaseProvider().currentUserEmail);
                Get.to(AddSchoolPage(dataBase: dataBase, isOnlyLocal: false,));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AddSchoolPage(dataBase: null,)),
                // );
              },
            ),
            if (Get.getCalendarController().getCurrentData != null)
              ListTile(
                leading: Icon(
                  Icons.auto_delete_outlined,
                  color: primaryColor,
                ),
                title: Text('Delete Local School'),
                onTap: () {
                  Get.defaultDialog(
                    titlePadding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Get.getThemeController().isLightMode.value
                        ? lightSecondaryBackgroundColor
                        : secondaryBackgroundColor,
                    title: 'Delete Local Data?'.tr,
                    titleStyle: Theme.of(context).textTheme.displaySmall,
                    content: Column(
                      children: [
                        // Text('delete sure?'.tr,
                        //     style: Theme.of(context).textTheme.bodyMedium,
                        //     textAlign: TextAlign.center),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: primaryColor,
                                      width: 1)),
                              child: Text('Cancel'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: primaryColor)),
                            ),
                            SizedBox(width: 10,),
                            OutlinedButton(
                              onPressed: () async {
                                await Get.getCalendarController().cleanCurrentData();
                                Get.getCalendarController().init();
                                Get.back();
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Get.getThemeController().isLightMode.value
                                          ? Colors.red.withOpacity(0.9)
                                          : Colors.red,
                                      width: 1)),
                              child: Text('Delete'.tr,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      color: Get.getThemeController().isLightMode.value
                                          ? Colors.red.withOpacity(0.9)
                                          : Colors.red)),
                            ),
                          ],
                        ).paddingOnly(top: 20),
                      ],
                    ),
                  );

                },
              ),
            // const ListTile(
            //   leading: Icon(
            //     Icons.admin_panel_settings,
            //     color: primaryColor,
            //   ),
            //   title: Text('Sign in/Register as School Admin'),
            // ),
          ],
        ),
      ),
    );
  }
}
