import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app_2024/screens/splash_screen.dart';
import 'package:weather_app_2024/screens/weather_app.dart';
import 'package:weather_app_2024/utils/our_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App 2024',
            builder: EasyLoading.init(),
            theme: CustomThemes.lightTheme,
            darkTheme: CustomThemes.darkTheme,
            themeMode: ThemeMode.system,
            home: const SplashScreen(),
          );
        });
  }
}
