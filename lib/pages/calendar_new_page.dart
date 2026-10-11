import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/datas/DATA_HWUS.dart';
import 'package:late_start/datas/data_base.dart';
import 'package:late_start/models/calendar_event_model.dart';
import 'package:late_start/pages/edit_alarms_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../datas/data_alarm_cycle_base.dart';
import '../datas/dynamic_data_base.dart';
import '../main2.dart';
import '../providers/get_storage_provider.dart';
import '../services/calendar_controller.dart';
import '../services/theme_controller.dart';
import '../temp/add_school.dart';
import '../utils/constants.dart';
import 'calendar_event_page.dart';

class CalendarNewPage extends StatefulWidget {
  const CalendarNewPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarNewPageState();

}

class _CalendarNewPageState extends State<CalendarNewPage> with WidgetsBindingObserver {

  ThemeController themeController = Get.getThemeController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(builder: (CalendarController controller) {
          // controller.getEventLoader.sort((a, b) => DateTime.parse(a.description!).compareTo(DateTime.parse(b.description!)));
          // controller.getEventLoader.sort((a, b) => a.start.compareTo(b.start));
          List<CalendarEventModel> sortedEvents = controller.getEventLoader..sort((a, b) => (a.start.hour * 60 + a.start.minute).compareTo((b.start.hour * 60 + b.start.minute)));
          return NestedScrollView(controller: controller.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              _buildSliverAppBar(Get.height / 70.9),//7.9
            ],
            body:RefreshIndicator(
              onRefresh: () async {
                // controller.initLatestIsarAlarms();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: GlowingOverscrollIndicator(
                      color: themeController.isLightMode.value? lightPrimaryDisabledTextColor: primaryDisabledTextColor,
                      axisDirection: AxisDirection.down,
                      child: controller.getCurrentData == null ? Stack(
                        children: [
                          ListView(),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('School Name'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 18),),
                                10.height,
                                Container(
                                  decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
                                  child: Padding(padding: const EdgeInsets.all(6), child: TextField(
                                    controller: controller.searchInputController,
                                    focusNode: controller.searchFocusNode,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: false,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                  ),),
                                ).withSize(width: MediaQuery.of(context).size.width - 40, height: 60),
                                ...controller.matchedDataBase.map((e) {
                                  return _buildMatchedDataBaseWidget(e.abbreviation(), () {
                                    controller.setCurrentData = DynamicDataBase(
                                      fullName: e.fullName(),
                                      abbreviation: e.abbreviation(),
                                      startDate: e.startDate(),
                                      endDate: e.endDate(),
                                      schoolCalendarModels: e.schoolCalendarModels(),
                                      schoolEvents: e.schoolEvents(),
                                    );
                                    // controller.setCurrentData = e;
                                    // Get.to(AddSchoolPage(dataBase: e, isOnlyLocal: true,));
                                  });
                                }),
                                if (controller.matchedDataBase.isNotEmpty)
                                  ...Get.getFirebaseProvider().firebaseDataBase.map((e) {
                                    return _buildMatchedDataBaseWidget(e.abbreviation(), () {
                                      // controller.setCurrentData = e;
                                      // Get.to(AddSchoolPage(dataBase: e, isOnlyLocal: true,));
                                      controller.setCurrentData = DynamicDataBase(
                                        fullName: e.fullName(),
                                        abbreviation: e.abbreviation(),
                                        startDate: e.startDate(),
                                        endDate: e.endDate(),
                                        schoolCalendarModels: e.schoolCalendarModels(),
                                        schoolEvents: e.schoolEvents(),
                                      );
                                    });
                                  }),
                                if (controller.matchedDataBase.isNotEmpty)
                                  _buildMatchedDataBaseWidget("Configure a Cycle".tr, () async {
                                    await Get.getFirebaseProvider().signOutFromGoogle();
                                      if ((Get.getFirebaseProvider().currentUserEmail) =="") {
                                      if (!await Get.getFirebaseProvider().signInWithGoogle()) {
                                        toast("sign in error!");
                                        return;
                                        }
                                      }
                                      // await Get.getFirebaseProvider().uploadPublicBreakoutDays(
                                      //   days: publicDaysMap,
                                      //   updatedBy: Get.getFirebaseProvider().currentUserEmail,
                                      // );
                                      DataBase? dataBase = await Get.getFirebaseProvider().fetchSchoolDataByEmail(Get.getFirebaseProvider().currentUserEmail);
                                      // DataBase? dataBase = await Get.getFirebaseProvider().fetchSchoolDataByEmail(Get.getFirebaseProvider().currentUserEmail);
                                      Get.to(AddSchoolPage(dataBase: dataBase, isOnlyLocal: false,));
                                  }),
                              ],
                            ),
                          ).marginOnly(top: MediaQuery.of(context).size.height/4),
                        ],
                      ) : //_buildOldContent(controller),
                      Column(
                        children: [
                          TableCalendar(
                            rowHeight: 52,//48 72
                            focusedDay: controller.getFocusedDay,
                            firstDay: controller.getCurrentData!.startDate(),
                            lastDay: controller.getCurrentData!.endDate(),
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month',
                            },
                            selectedDayPredicate: (day) {
                              return isSameDay(controller.getSelectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              controller.setSelectedDay = selectedDay.toUtc();
                              // controller.setSelectedDayAndFocusedDay(selectedDay.toUtc(), focusedDay.toUtc());
                            },
                            onPageChanged: (focusedDay) {
                              controller.setFocusedDay = focusedDay.toUtc();
                            },
                            eventLoader:  (day) {
                              return controller.getCurrentData!.eventLoader(day.toUtc());
                            },
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (BuildContext context, DateTime day, List<dynamic> events, bool isOutside) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // const Expanded(child: SizedBox()),
                                    const Spacer(flex: 14,),
                                    ...events.map((e) {
                                      Color eventTextColor = Colors.white;
                                      // RegExp format1 = RegExp(r'^LS\nDay \d+$');
                                      RegExp format1 = RegExp(r'^Day \d+\nLS$');
                                      RegExp format2 = RegExp(r'^Day \d+\n$');

                                      if (format1.hasMatch(e)) {
                                        eventTextColor = primaryColor;
                                      } else if (format2.hasMatch(e)) {
                                        eventTextColor = Colors.white;
                                      } else {
                                        eventTextColor = Colors.red;
                                        if (!e.toString().contains("\n")) {
                                          e = '$e\n';
                                        }
                                      }
                                      if (e.toString() == "Day 0\n") {
                                        eventTextColor = Colors.white;
                                      }
                                      return Text(e, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 7, color: isOutside ? const Color(0xFFAEAEAE) : eventTextColor, fontWeight: FontWeight.normal), textAlign: TextAlign.center,);
                                    }),
                                    const Spacer(flex: 1),
                                    // const Expanded(child: SizedBox()),
                                  ],
                                );
                                // return Text("${events.isNotEmpty?events[0]:''}");
                              },

                            ),
                            // loadEventsForDisabledDays: true,
                            calendarStyle: const CalendarStyle(
                              cellPadding: EdgeInsets.all(0),
                              cellMargin: EdgeInsets.only(top: 4.0, bottom: 18.0),
                            ),
                          ),
                          20.height,
                          Expanded(
                             child: controller.getEventLoader.isNotEmpty ? StickyGroupedListView<CalendarEventModel, DateTime>(
                               stickyHeaderBackgroundColor: primaryBackgroundColor,
                               elements: sortedEvents,
                               groupBy: (event) => DateTime(
                                 DateTime.parse(event.description!).year,
                                 DateTime.parse(event.description!).month,
                                 DateTime.parse(event.description!).day,
                               ),
                               groupSeparatorBuilder: (CalendarEventModel date) => _buildDateHeader(controller, DateTime.parse(date.description!)),
                               itemBuilder: (context, event) => _buildEventItem(context, event),
                               order: StickyGroupedListOrder.ASC,
                             ):const SizedBox(),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  _buildSliverAppBar(double expandedHeight) => SliverAppBar(
    actions: [
      Center(
        child: Row(
          children: [
            GestureDetector(
              child: const Icon(Icons.add_alarm_outlined, color: primaryColor,).paddingOnly(left: 20, right: 5),
              onTap: () {
                DataAlarmCycleBase? dataAlarmCycleBase = Get.find<GetStorageProvider>().readCurrentAlarmCycleData();
                if (dataAlarmCycleBase == null) {
                  return;
                }
                Get.to(const EditAlarmsPage());
              },
            ),
            GestureDetector(
              child: const Icon(Icons.add, color: primaryColor,).paddingOnly(left: 5, right: 20),
              onTap: () async {
                // DataBase? currentCalendarData = Get.find<GetStorageProvider>().readCurrentCalendarData();
                DataBase? currentCalendarData = Get.find<GetStorageProvider>().readNewCurrentCalendarData();
                if (currentCalendarData == null) {
                  return;
                }
                if (Get.getCalendarController().getSelectedDay == null) {
                  toast('Please select a date!');
                  return;
                }
                Get.to(CalendarEventPage(calendarEventModel: CalendarEventModel()
                  ..calendarDate = Get.getCalendarController().getSelectedDay!
                  ..eventName = ''
                  ..isAlarmOpen = true,
                ));
                // if (Get.getCalendarController().getSelectedDay == null) {
                //   toast('Please select a date!');
                //   return;
                // }
                // DateTime? selectDate = await _selectDate(context);
                // if (selectDate != null) {
                //   Get.getCalendarController().setSelectedDay = selectDate;
                //   Get.to(CalendarEventPage(calendarEventModel: CalendarEventModel()
                //     ..calendarDate = Get.getCalendarController().getSelectedDay!
                //     ..eventName = ''
                //     ..isAlarmOpen = true,
                //   ));
                // } else {
                //   toast('Please select a date!');
                // }
              },
            ),
          ],
        ),
      )
    ],
    automaticallyImplyLeading: false,
    expandedHeight: expandedHeight,
    floating: true,
    pinned: true,
    snap: false,
    centerTitle: true,
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder(builder: (CalendarController controller) {
                  return Container(
                    padding: EdgeInsets.only(left: 25 * controller.scalingFactor.value,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Calendar'.tr, style: themeController.getAppTitleTextStyle(context, scalingFactor: controller.scalingFactor.value).copyWith(color: primaryTitleGrayColor),),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ).center();
      },
    ),
  );

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
  }

  Widget _buildOldContent(CalendarController controller) => ListView(children: [
    TableCalendar(
      rowHeight: 52,//48 72
      focusedDay: controller.getFocusedDay,
      firstDay: controller.getCurrentData!.startDate(),
      lastDay: controller.getCurrentData!.endDate(),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      selectedDayPredicate: (day) {
        return isSameDay(controller.getSelectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        controller.setSelectedDayAndFocusedDay(selectedDay.toUtc(), focusedDay.toUtc());
      },
      onPageChanged: (focusedDay) {
        controller.setFocusedDay = focusedDay.toUtc();
      },
      eventLoader:  (day) {
        return controller.getCurrentData!.eventLoader(day.toUtc());
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (BuildContext context, DateTime day, List<dynamic> events, bool isOutside) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              ...events.map((e) {
                return Text(e, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 7, color: isOutside ? const Color(0xFFAEAEAE) : Colors.white, fontWeight: FontWeight.normal), textAlign: TextAlign.center,);
              }),
            ],
          );
          // return Text("${events.isNotEmpty?events[0]:''}");
        },

      ),
      // loadEventsForDisabledDays: true,
      calendarStyle: const CalendarStyle(
        cellPadding: EdgeInsets.all(0),
        cellMargin: EdgeInsets.only(top: 4.0, bottom: 18.0),
      ),
    ),
    20.height,
    ...controller.getEventLoader.map((e) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(CalendarEventPage(calendarEventModel: e));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.description??'', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal,),),
                      20.height,
                      Text(e.eventName, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal,),),
                    ],
                  ),
                  Column(
                    children: [
                      Text(DateFormat('HH:mm').format(e.start), style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal,),),
                      20.height,
                      Text(DateFormat('HH:mm').format(e.end), style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal,),),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const Divider(),
        ],
      );
    }),
  ],);

  Widget _buildDateHeader(CalendarController controller, DateTime date) {
    String formattedDate = DateFormat('EEEE — MMM\u2009d').format(date);
    String weekDay = DateFormat('EEEE').format(date);
    String formattedWeekDay = weekDay[0].toUpperCase() + weekDay.substring(1).toLowerCase();
    String dateResult = formattedDate.replaceFirst(weekDay, formattedWeekDay);
    return Container(
      width: double.infinity,
      height: 30,
      padding: const EdgeInsets.symmetric(/*vertical: 8, */horizontal: 16),
      // margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: const Border(
          top: BorderSide(color: primaryDisabledTextColor, width: 0.5),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
         dateResult,
        // DateFormat('EEEE — MMM d').format(date).toUpperCase(),
        // DateFormat('EEEE — MMM d').format(date).substring(0, 1).toUpperCase() + DateFormat('EEEE — MMM d').format(date).substring(3).toLowerCase(),
        style: (controller.getSelectedDay != null && DateTime(date.year, date.month, date.day
        ) == DateTime(controller.getSelectedDay!.year, controller.getSelectedDay!.month, controller.getSelectedDay!.day
        ))?themeController.getAppTextStyle().copyWith(color: primaryColor):themeController.getAppTextStyle().copyWith(color: primaryTitleGrayColor),//TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _buildEventItem(BuildContext context, CalendarEventModel event) {
    return InkWell(
      onTap: () {
        Get.to(CalendarEventPage(calendarEventModel: event));
      },
      child: Container(
        height: 30,
        padding: const EdgeInsets.only(left: 16, right: 16, /*bottom: 4,*/ ),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左侧内容
            Text(
              event.eventName,
              style: themeController.getAppTextStyle().copyWith(fontSize: 12),
            ).paddingOnly(bottom: 6),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     // if (event.title != null) ...[
            //     //   Text(
            //     //     event.title!,
            //     //     style: themeController.getAppTextStyle(),
            //     //   ),
            //     // ],
            //     // 4.height,
            //     Text(
            //       event.eventName,
            //       style: themeController.getAppTextStyle(),
            //     ),
            //     // if (event.description != null) ...[
            //     //   SizedBox(height: 4),
            //     //   Text(
            //     //     event.description!,
            //     //     style: TextStyle(fontSize: 12, color: Colors.grey),
            //     //   ),
            //     // ],
            //   ],
            // ),
            // 右侧时间
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       DateFormat('h:mm a').format(event.start),
            //       style: themeController.getAppTextStyle(),
            //     ),
            //     // if (event.end.isAfter(event.start)) ...[
            //     //   Text(
            //     //     DateFormat('h:mm a').format(event.end),
            //     //     style: TextStyle(fontSize: 12, color: Colors.grey),
            //     //   ),
            //     // ],
            //   ],
            // ),
            Text(
              DateFormat('HH:mm').format(event.start),
              style: themeController.getAppTextStyle().copyWith(fontSize: 12),
            ).paddingOnly(bottom: 6),
          ],
        ),
      ),
    );
  }

  _buildMatchedDataBaseWidget(String textData, VoidCallback? onPressed) => MaterialButton(
    onPressed: onPressed,
    color: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide(
        color: Theme.of(context).primaryColor.withAlpha(50),
        width: 2,
      ),
    ),
    child: Text(textData, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),),
  ).withSize(width: MediaQuery.of(context).size.width - 40, height: 60);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed");
      Get.getCalendarController().setSelectedDayAndFocusedDay(DateTime.now(), DateTime.now());
      // Get.getCalendarController().setSelectedDay = DateTime.now();
    } else if (state == AppLifecycleState.paused) {
      debugPrint("App paused");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}