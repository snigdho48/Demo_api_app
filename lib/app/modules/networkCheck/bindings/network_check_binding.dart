import 'package:get/get.dart';

import '../controllers/network_check_controller.dart';

class NetworkCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkCheckController>(
      () => NetworkCheckController(),
    );
  }
}
