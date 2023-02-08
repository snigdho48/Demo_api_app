import 'package:get/get.dart';

import '../../../data/Api_Get.dart';
import '../../../shared_pref.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  Future<void> onInit() async {
    await getModel();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  futureCall() async {
    Future? navigator;
    await getstatus().then((value) {
      if (value) {
        Future.delayed(Duration(seconds: 3), () {
          navigator = Get.offNamed('/home');
        });
      } else {
        Future.delayed(Duration(seconds: 3), () {
          navigator = Get.offNamed('/login');
        });
      }
    });
    return navigator;
  }
}
