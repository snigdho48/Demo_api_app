import 'package:get/get.dart';

import '../../../data/Api_Get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  @override
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
}
