import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/Api_Get.dart';
import '../../helper_functions.dart';
import '../../home/model_model.dart';

class DetailPreviewController extends GetxController {
  //TODO: Implement DetailPreviewController
  final data = Get.arguments;
  Rx<bool> isLoading = true.obs;
  Rx<Model> model = Model().obs;

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLoading.value = true;
      model.value = await getSingleModel(id: data.toString());
      isLoading.value = false;
    });
    BackButtonInterceptor.add(myInterceptor);
    super.onInit();
  }

  @override
  void dispose() {
    BackButtonInterceptor.add(myInterceptor);
    super.dispose();
  }

  @override
  void onClose() {}
}
