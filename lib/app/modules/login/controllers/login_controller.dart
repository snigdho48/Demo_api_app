import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:demo_app/app/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKey = GlobalKey<FormState>();
  Rx<String> errMsg = "".obs;
  bool isLogin = false;
  final register = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final name = TextEditingController();
  @override
  void onInit() {
    BackButtonInterceptor.add(myInterceptor);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    name.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  void setErrorMsg(String s) {
    errMsg.value = s;
  }

  @override
  void onClose() {}

  Future<bool> loginState() async {
    errMsg.value = "";
    bool success = false;
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      if (isLogin) {
        print('success');
        if (email == await getemail() && password == await getpass()) {
          setstatus(isLogin: true);
          print('all set');
          success = true;
        } else {
          errMsg.value = "Please Register First";
          print(errMsg.value);
          return success;
        }
      } else {
        try {
          await removeemail();
          await removepass();
          await removename();
        } catch (e) {
          return success;
        }
        await setemail(email: email);
        await setpass(pass: password);
        await setname(name: name.text);
        await setstatus(isLogin: true);
        isLogin = true;
        print('$getstatus(), $getemail(), $getpass()');
        print('success');
        success = true;
      }
    }
    return success;
  }
}
