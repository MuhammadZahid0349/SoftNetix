import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_2024/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    hourlyWeatherData = getHourlyWeather(latitude.value, longitude.value);
    super.onInit();
    loadThemeFromPrefs();
  }

  RxBool isDark = false.obs;
  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxBool isloaded = false.obs;

  changeTheme() {
    isDark.value = !isDark.value;
    // Save theme preference to SharedPreferences
    saveThemeToPrefs(isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> saveThemeToPrefs(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    isDark.value = isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  getUserLocation() async {
    try {
      bool isLocationEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        // If not enabled, prompt the user to enable location services
        bool serviceStatus = await Geolocator.openLocationSettings();
        if (!serviceStatus) {
          return Future.error("Failed to enable location services.");
        }
      }

      // Check location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Permission is denied forever");
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error("Permission is denied");
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // latitude.value = position.latitude;
      // longitude.value = position.longitude;
      // print(latitude.value);
      longitude.value = 66.990501;
      latitude.value = 24.860966;

      isloaded.value = true;
    } on PlatformException catch (e) {
      throw Exception("PlatformException occurred: ${e.message}");
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}
