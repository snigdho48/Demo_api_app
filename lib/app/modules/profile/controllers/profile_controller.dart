import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../shared_pref.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Future<void> onInit() async {
    email.value = await getemail();
    password.value = await getpass();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    oldPassword.dispose();
    newPassword.dispose();
    name.dispose();
  }

  void updateinfo({email, password}) async {
    if (email.isNotEmpty) {
      await setemail(email: email);
      return;
    }
    if (password.isNotEmpty) {
      await setpass(pass: password);
      return;
    }
  }
}
