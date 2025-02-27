import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app_2024/consts/images.dart';
import 'package:weather_app_2024/consts/strings.dart';
import 'package:weather_app_2024/controllers/main_controller.dart';
import 'package:weather_app_2024/models/current_weather_model.dart';
import 'package:weather_app_2024/models/hourly_weather_model.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    MainController controller = Get.put(MainController());

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: date.text.color(theme.primaryColor).make(),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                    onPressed: () {
                      controller.changeTheme();
                    },
                    icon: Icon(
                        controller.isDark.value
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: theme.iconTheme.color)),
              ),
            ),
          ],
        ),
        body: Obx(
          () => controller.isloaded.value == true
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: controller.currentWeatherData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        CurrentWeatherData data = snapshot.data;
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data.name}"
                                  .text
                                  .uppercase
                                  .fontFamily("poppins_bold")
                                  .size(32.sp)
                                  .letterSpacing(3)
                                  .color(theme.primaryColor)
                                  .make(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/weather/${data.weather![0].icon}.png",
                                    width: 80.w,
                                    height: 80.h,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "${data.main!.temp}$degree",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            fontSize: 64.sp,
                                            fontFamily: "poppins",
                                          )),
                                      TextSpan(
                                          text: " ${data.weather![0].main}",
                                          style: TextStyle(
                                            color: theme.primaryColor,
                                            letterSpacing: 3,
                                            fontSize: 14.sp,
                                            fontFamily: "poppins",
                                          )),
                                    ],
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_less_rounded,
                                          color: theme.iconTheme.color),
                                      label: "${data.main!.tempMax}$degree"
                                          .text
                                          .color(theme.iconTheme.color)
                                          .make()),
                                  TextButton.icon(
                                      onPressed: null,
                                      icon: Icon(Icons.expand_more_rounded,
                                          color: theme.iconTheme.color),
                                      label: "${data.main!.tempMin}$degree"
                                          .text
                                          .color(theme.iconTheme.color)
                                          .make())
                                ],
                              ),
                              10.h.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(3, (index) {
                                  var iconsList = [clouds, humidity, windspeed];
                                  var values = [
                                    "${data.clouds!.all}",
                                    "${data.main!.humidity}",
                                    "${data.wind!.speed} km/h"
                                  ];
                                  return Column(
                                    children: [
                                      Image.asset(
                                        iconsList[index],
                                        width: 60.w,
                                        height: 60.h,
                                      )
                                          .box
                                          .gray200
                                          .padding(const EdgeInsets.all(8))
                                          .roundedSM
                                          .make(),
                                      10.h.heightBox,
                                      values[index].text.gray400.make(),
                                    ],
                                  );
                                }),
                              ),
                              5.h.heightBox,
                              const Divider(),
                              10.h.heightBox,
                              todayWeatherDetails(controller),
                              10.h.heightBox,
                              const Divider(),
                              5.h.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "Next 7 Days"
                                      .text
                                      .semiBold
                                      .size(16.sp)
                                      .color(theme.primaryColor)
                                      .make(),
                                  TextButton(
                                      onPressed: () {},
                                      child: "View All".text.make()),
                                ],
                              ),
                              nextSevenDays(theme),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  ListView nextSevenDays(ThemeData theme) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        var day = DateFormat("EEEE")
            .format(DateTime.now().add(Duration(days: index + 1)));
        return Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: day.text.semiBold.color(theme.primaryColor).make()),
                Expanded(
                  child: TextButton.icon(
                      onPressed: null,
                      icon: Image.asset("assets/weather/50n.png", width: 40.w),
                      label: "26$degree"
                          .text
                          .size(16.sp)
                          .color(theme.primaryColor)
                          .make()),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "37$degree /",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: "poppins",
                            fontSize: 16.sp,
                          )),
                      TextSpan(
                          text: " 26$degree",
                          style: TextStyle(
                            color: theme.iconTheme.color,
                            fontFamily: "poppins",
                            fontSize: 16.sp,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<dynamic> todayWeatherDetails(MainController controller) {
    return FutureBuilder(
      future: controller.hourlyWeatherData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          HourlyWeatherData hourlyData = snapshot.data;
          return SizedBox(
            height: 160.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:
                  hourlyData.list!.length > 6 ? 6 : hourlyData.list!.length,
              itemBuilder: (BuildContext context, int index) {
                var time = DateFormat.jm().format(
                    DateTime.fromMillisecondsSinceEpoch(
                        hourlyData.list![index].dt!.toInt() * 1000));

                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Vx.gray200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      time.text.make(),
                      Image.asset(
                        "assets/weather/${hourlyData.list![index].weather![0].icon}.png",
                        width: 80.w,
                      ),
                      10.h.heightBox,
                      "${hourlyData.list![index].main!.temp}$degree"
                          .text
                          .make(),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
