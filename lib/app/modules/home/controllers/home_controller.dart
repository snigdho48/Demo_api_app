import 'package:demo_app/app/data/Api_Get.dart';
import 'package:demo_app/app/modules/networkCheck/controllers/network_check_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final connected = Get.put(NetworkCheckController()).obs;

  @override
  Future<void> onInit() async {
    print(connected.value.type.value.toString());
    if (await connected.value.type.value) {
      await getModel();
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
