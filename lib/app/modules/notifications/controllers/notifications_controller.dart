import 'package:get/get.dart';

import '../../../services/notification.service.dart';
import '../../../shared_pref.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  List<dynamic> arguments = [];

  @override
  Future<void> onInit() async {
    PushNoti = await getNoti();

    try {} catch (e) {
      print(e);
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
