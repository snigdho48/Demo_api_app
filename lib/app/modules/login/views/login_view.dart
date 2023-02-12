import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../helper_functions.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exitApp(),
      child: Scaffold(
        backgroundColor: HexColor("#D0E0E8"),
        appBar: AppBar(
          title: Obx(() => controller.connection.type.value
              ? SizedBox()
              : controller.register.value
                  ? Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  : Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
          centerTitle: true,
          backgroundColor: HexColor("#D0E0E8"),
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Image.asset(
                'assets/images/img.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => controller.register.value
                          ? const Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              child: Text(
                                "Name :",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.green),
                              ),
                            )
                          : const SizedBox()),
                      Obx(() => controller.register.value
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: controller.name,
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 1))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter your Name';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : const SizedBox()),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Text(
                          "Email :",
                          style: TextStyle(fontSize: 23, color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 1))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Text(
                          "Password :",
                          style: TextStyle(fontSize: 23, color: Colors.green),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: [
                            TextField(
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 1))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => controller.register.value ||
                                    controller.loginErr.value
                                ? FlutterPwValidator(
                                    controller: controller.passwordController,
                                    minLength: 6,
                                    normalCharCount: 1,
                                    uppercaseCharCount: 1,
                                    numericCharCount: 1,
                                    specialCharCount: 1,
                                    width: 400,
                                    height: 150,
                                    onSuccess: () {
                                      print("Matched");
                                    },
                                    onFail: (value) {
                                      print("value");
                                    },
                                  )
                                : SizedBox())
                          ])),
                      Obx(() => controller.errMsg.value.isNotEmpty
                          ? Center(
                              child: Text(
                              controller.errMsg.value,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.red),
                            ))
                          : const SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              child: Obx(() => controller.register.value
                                  ? const Text(
                                      "Register",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20),
                                    )),
                              onPressed: () async {
                                if (controller.register.value) {
                                  controller.isLogin = false;
                                } else {
                                  controller.isLogin = true;
                                }
                                await controller.loginState().then((value) =>
                                    value ? Get.offAllNamed('/home') : null);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          controller.errMsg.value = "";
                          controller.register.value =
                              !controller.register.value;
                        },
                        child: Center(
                          child: Obx(() => controller.register.value
                              ? const Text(
                                  "Already have an account ? Login",
                                  style: TextStyle(fontSize: 20),
                                )
                              : const Text(
                                  "Don't have an account ? Register",
                                  style: TextStyle(fontSize: 20),
                                )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
