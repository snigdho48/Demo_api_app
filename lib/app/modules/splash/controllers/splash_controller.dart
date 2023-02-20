import 'package:get/get.dart';

import '../../../data/Api_Get.dart';
import '../../../shared_pref.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final connected = Get.put(NetworkCheckController());

  Future<void> onInit() async {
    if (connected.type.value) {
      await getModel();
    }
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
    if(Get.arguments != null){
      await Get.toNamed('/notifications', arguments: Get.arguments);
    }else{
      await getstatus().then((value) {
        if (value) {
          Future.delayed(Duration(seconds: 2), () {
            navigator = Get.offNamed('/home');
          });
        } else {
          Future.delayed(Duration(seconds: 2), () {
            navigator = Get.offNamed('/login');
          });
        }
      });
    }

    return navigator;
  }
}
