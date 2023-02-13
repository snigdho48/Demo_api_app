import 'package:get/get.dart';

import '../controllers/imagedashboard_controller.dart';

class ImagedashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagedashboardController>(
      () => ImagedashboardController(),
    );
  }
}
