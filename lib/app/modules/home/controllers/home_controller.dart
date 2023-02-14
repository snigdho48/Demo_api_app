import 'package:demo_app/app/data/Api_Get.dart';
import 'package:demo_app/app/modules/networkCheck/controllers/network_check_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/notification.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final connected = Get.put(NetworkCheckController()).obs;

  @override
  Future<void> onInit() async {
    print(connected.value.type.value.toString());
    if (await connected.value.type.value) {
      await getModel();
      print('connected');
    }
    await Permission.notification.isDenied.then((value) async {
      NotificationService notificationService = NotificationService();
      await notificationService.init();
      await notificationService.requestIOSPermissions();
      await notificationService.requestAndroidPermission();
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
    });
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
