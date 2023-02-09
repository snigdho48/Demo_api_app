import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../shared_pref.dart';
import '../../helper_functions.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  Rx<String> email = ''.obs;
  Rx<String> username = ''.obs;
  Rx<String> password = ''.obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController newenail = TextEditingController();

  @override
  Future<void> onInit() async {
    email.value = await getemail();
    password.value = await getpass();
    username.value = await getname();
    BackButtonInterceptor.add(myInterceptor);

    super.onInit();
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  void clear() {
    oldPassword.clear();
    newPassword.clear();
    name.clear();
    newenail.clear();
  }

  @override
  void dispose() {
    newPassword.dispose();
    oldPassword.dispose();
    name.dispose();
    newenail.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
  }

  void updateinfo() async {
    await setemail(email: email.value);
    print('email update');
    await setpass(pass: password.value);
    print('password update');
    await setname(name: username.value);
    print('name updated');
    update();
  }
}
