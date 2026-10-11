import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:late_start/base/app_get.dart';
import 'package:late_start/models/calendar_event_model.dart';
import 'package:late_start/pages/edit_alarms_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/calendar_controller.dart';
import '../services/theme_controller.dart';
import '../utils/constants.dart';
import 'calendar_event_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarPageState();

}

class _CalendarPageState extends State<CalendarPage> {

  ThemeController themeController = Get.getThemeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(builder: (CalendarController controller) {
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
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: false,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                  ),),
                                ).withSize(width: MediaQuery.of(context).size.width - 40, height: 60),
                                ...controller.matchedDataBase.map((e) {
                                  return MaterialButton(
                                    onPressed: () {
                                      controller.setCurrentData = e;
                                    },
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor.withAlpha(50),
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(e.abbreviation(), style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),),
                                  ).withSize(width: MediaQuery.of(context).size.width - 40, height: 60);
                                })

                              ],
                            ),
                          ).marginOnly(top: MediaQuery.of(context).size.height/4),
                        ],
                      ) : ListView(children: [
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
                                  child: Text('Event - ${e.id} : ${e.eventName}', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal,),
                                  ),
                                ),
                              ),
                              // const Divider(),
                            ],
                          );
                        }),
                      ],),
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
              child: const Icon(Icons.add_alarm_outlined).paddingOnly(left: 20, right: 5),
              onTap: () {
                Get.to(const EditAlarmsPage());
              },
            ),
            GestureDetector(
              child: const Icon(Icons.add).paddingOnly(left: 5, right: 20),
              onTap: () {
                if (Get.getCalendarController().getSelectedDay == null) {
                  toast('Please select a date!');
                  return;
                }
                Get.to(CalendarEventPage(calendarEventModel: CalendarEventModel()
                  ..calendarDate = Get.getCalendarController().getSelectedDay!
                  ..eventName = ''
                  ..isAlarmOpen = true,
                ));
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
                        Text('Calendar'.tr, style: themeController.getAppTitleTextStyle(context, scalingFactor: controller.scalingFactor.value),),
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

}