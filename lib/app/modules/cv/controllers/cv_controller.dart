import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../networkCheck/controllers/network_check_controller.dart';
import '../models/checkmodel.dart';

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
  final index = (-1).obs;
  RxList<TextEditingController> textcontroler1 =
      RxList<TextEditingController>([]);
  RxList<TextEditingController> textcontroler2 =
      RxList<TextEditingController>([]);
  RxList<CheckboxItem> checkboxList = RxList<CheckboxItem>([
    CheckboxItem(text: 'SSC'),
    CheckboxItem(text: 'HSC'),
    CheckboxItem(text: 'BSC'),
    CheckboxItem(text: 'MSC'),
  ]);

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
    textcontroler1.add(TextEditingController());
    textcontroler2.add(TextEditingController());
  }

  void removeindex() {
    textcontroler1.removeLast();
    textcontroler2.removeLast();
    index.value--;
  }
}
