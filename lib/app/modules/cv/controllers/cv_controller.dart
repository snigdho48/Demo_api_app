import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../networkCheck/controllers/network_check_controller.dart';

class CvController extends GetxController {
  //TODO: Implement CvController
  final formKey = GlobalKey<FormState>();
  final connected = Get.put(NetworkCheckController()).obs;
  final name = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phone = TextEditingController().obs;
  final lastInstitutionName = TextEditingController().obs;
  final address = TextEditingController().obs;
  final education = GroupController(
    isMultipleSelection: true,
  ).obs;
  final gender = RadioGroupController().obs;
  final activeIndex = 0.obs;
  final index = 1.obs;
  List<TextEditingController> experience = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void newindex() {
    index.value++;
  }
}
