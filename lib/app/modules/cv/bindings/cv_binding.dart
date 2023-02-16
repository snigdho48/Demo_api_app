import 'package:get/get.dart';

import '../controllers/cv_controller.dart';

class CvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CvController>(
      () => CvController(),
    );
  }
}
