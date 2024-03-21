import 'package:get/get.dart';
import 'package:weather_app_2024/screens/weather_app.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashHandle();
  }

  Future<void> splashHandle() async {
    await Future.delayed(const Duration(seconds: 3)); // Add await here
    Get.to(() => const WeatherApp());
  }
}
