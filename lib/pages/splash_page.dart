import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/pages/home_page.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../providers/get_storage_provider.dart';
import '../utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    init().then((_) {
      Get.offAll(const HomePage());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Center(child: Image.asset('assets/images/ic_app.png', width: 100, height: 100,),),
    );
  }

  Future<void> init() async {
    defaultRadius = 16;
    defaultAppButtonRadius = 16;
    await Get.startAppServices();
    await initialize();
    final storage = Get.find<GetStorageProvider>();
    loc = await storage.readLocale();
    await Alarm.init();
  }

}