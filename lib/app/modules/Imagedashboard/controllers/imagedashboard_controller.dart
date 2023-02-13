import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:demo_app/app/data/Image_api_get.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class ImagedashboardController extends GetxController {
  //TODO: Implement ImagedashboardController
  final connected = Get.put(NetworkCheckController()).obs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    if (await connected.value.type.value) {
      await getImageModel();
    }
    BackButtonInterceptor.add(myInterceptor);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void onClose() {}
}
