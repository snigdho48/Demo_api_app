import 'package:demo_app/app/data/Api_Get.dart';
import 'package:demo_app/app/modules/networkCheck/controllers/network_check_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/notification.dart';
import '../../../services/notification.service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final connected = Get.put(NetworkCheckController()).obs;
  @override
  Future<void> onInit() async {
    await Permission.notification.isDenied.then((value) async {
      await NotificationService().requestIOSPermissions();
      await NotificationService().requestAndroidPermission();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
    });

    if (await connected.value.type.value) {
      await getandsetAllPush();
      await getModel();
      print('connected');
    }

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {}
}
