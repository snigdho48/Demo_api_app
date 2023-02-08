import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('assets/images/img_1.png'),
        title: Text(
          "Welcome to Splash Screen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade400,
        showLoader: true,
        loadingText: Text("Loading..."),
        navigator: controller.futureCall());
  }
}
