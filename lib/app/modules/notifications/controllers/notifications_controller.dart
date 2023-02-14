import 'dart:math';

import 'package:get/get.dart';

import '../../../data/DB.dart';
import '../../../services/notification.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;

  @override
  Future<void> onInit() async {
    await getAllPush();
    try {
      arguments = await Get.arguments as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

List<Map<String, dynamic>> PushNoti = [];

getAllPush() async {
  await Db.getNoti().listen((event) {
    PushNoti.clear();
    event.docs.forEach((element) {
      var rng = Random();
      // final time = (element.data()['time'].seconds) * 1000;
      // final schedule = DateTime.fromMillisecondsSinceEpoch(time).toUtc();
      // print(time.runtimeType);
      PushNoti.add(element.data());
      NotificationService().showNotification(
        rng.nextInt(1000),
        element.data()['msg'],
        element.data()['msg'],
        payload: element.data().toString(),
      );
    });
  });
}
