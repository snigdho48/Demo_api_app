import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#D0E0E8"),
      appBar: AppBar(
        title: const Text(
          "LoginPage",
          style: TextStyle(fontSize: 28),
        ),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 1))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
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
                            child: const Text(
                              "LogIn",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              controller.isLogin = true;
                              print('clicked  login');
                              await controller.loginState().then((value) =>
                                  value ? Get.offAllNamed('/home') : null);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              controller.isLogin = false;
                              await controller.loginState().then((value) =>
                                  value ? Get.offAllNamed('/home') : null);
                            },
                          ),
                        ),
                      ],
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
    );
  }
}
