import 'package:demo_app/app/modules/networkCheck/controllers/network_check_controller.dart';
import 'package:demo_app/app/shared_pref.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  Rx<String> errMsg = "".obs;
  bool isLogin = false;
  final register = false.obs;
  final loginErr = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final name = TextEditingController();
  final connection = Get.find<NetworkCheckController>();

  @override
  void onInit() {
    isLogin = false;
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
      final bool isValid = EmailValidator.validate(email);
      if (!isValid) {
        errMsg.value = "Please Enter Valid Email";
        return success;
      } else {
        if (isLogin) {
          if (email == await getemail() && password == await getpass()) {
            setstatus(isLogin: true);
            print('all set');
            success = true;
            return success;
          } else {
            if (email != await getemail() && password != await getpass()) {
              success = false;
              errMsg.value = "Please Register First";
              return success;
            }
            if (email != await getemail()) {
              success = false;
              errMsg.value = "Please Enter correct Email";
              return success;
            }
            if (email != await getpass()) {
              success = false;
              loginErr.value = true;
              errMsg.value = "Please Enter correct Password";
              return success;
            }
          }
        } else {
          if (errMsg.value == "Password is not strong enough") {
            Get.showSnackbar(
              GetSnackBar(
                backgroundColor: Colors.redAccent,
                messageText: Text(
                  "Password is not strong enough",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              ),
            );
            return success;
          }

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
    }
    return success;
  }
}
