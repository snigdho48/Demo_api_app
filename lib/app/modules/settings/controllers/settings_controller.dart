import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Conostant.dart';
import '../../helper_functions.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  final theme = false.obs;
  final connected = Get.put(NetworkCheckController());

  @override
  void onInit() {
    theme.value = ThemeServices().theme == ThemeMode.light ? true : false;
    BackButtonInterceptor.add(myInterceptor);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void changetheme() {
    ThemeServices().swtichTheme();
    theme.value = !theme.value;
    update();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void onClose() {}
}
