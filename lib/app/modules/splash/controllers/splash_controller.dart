import 'package:get/get.dart';

import '../../../shared_pref.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final connected = Get.put(NetworkCheckController());

  Future<void> onInit() async {
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

    navigator = await getstatus().then((value) async {
      if (value) {
        await getPayload().then((value2) {
          print('value2: $value2');
          if (value2.isNotEmpty) {
            Get.offAllNamed('/notifications', arguments: value2);
          } else {
            Get.offAllNamed('/home');
          }
        });
      } else {
        Get.offAllNamed('/login');
      }
    });
    return navigator;
  }
}
