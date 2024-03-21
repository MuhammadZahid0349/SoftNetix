import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app_2024/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashScreenController splashScreenController =
        Get.put(SplashScreenController());
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "SoftNetix Task 1"
                  .text
                  .uppercase
                  .fontFamily("poppins_bold")
                  .size(25.sp)
                  .letterSpacing(3)
                  .color(theme.primaryColor)
                  .make(),
              SizedBox(
                height: 220.h,
                width: Get.width,
                child: Stack(
                  children: [
                    Positioned(
                        right: 50.h,
                        left: 0.h,
                        child: Image.asset(
                          "assets/weather/03d.png",
                        )),
                    Positioned(
                        right: 0.h,
                        left: 40.h,
                        child: Image.asset("assets/weather/50d.png")),
                  ],
                ),
              ),
              "Weather App"
                  .text
                  .uppercase
                  .fontFamily("poppins_bold")
                  .size(22.sp)
                  .color(theme.primaryColor)
                  .make(),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
