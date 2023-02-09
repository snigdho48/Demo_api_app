import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(),
        bottomNavigationBar: Navigation(),
        floatingActionButton: navaction(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                        width: Get.width * 0.25,
                        child: Text(
                          'Email: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Text(controller.email.value,
                        style: TextStyle(fontSize: 18)),
                    Spacer(),
                    SizedBox(
                        width: Get.width * 0.2,
                        child: IconButton(
                            onPressed: (() {
                              Get.defaultDialog(
                                confirmTextColor: Colors.white,
                                title: 'Update Email',
                                content: Column(
                                  children: [
                                    TextField(
                                      controller: controller.newenail,
                                      decoration: InputDecoration(
                                          hintText: 'Enter New Email'),
                                    ),
                                  ],
                                ),
                                textConfirm: 'Update',
                                onConfirm: () {
                                  controller.email.value =
                                      controller.newenail.text;
                                  controller.updateinfo();
                                  controller.clear();
                                  Get.back();
                                },
                                textCancel: 'Cancel',
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            }),
                            icon: Icon(Icons.edit))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                        width: Get.width * 0.25,
                        child: Text('Password: ',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Text(controller.password.value,
                        style: TextStyle(fontSize: 18)),
                    Spacer(),
                    SizedBox(
                        width: Get.width * 0.2,
                        child: IconButton(
                            onPressed: (() {
                              Get.defaultDialog(
                                confirmTextColor: Colors.white,
                                title: 'Update Password',
                                content: Column(
                                  children: [
                                    TextField(
                                      controller: controller.oldPassword,
                                      decoration: InputDecoration(
                                          hintText: 'Enter New Password'),
                                    ),
                                    TextField(
                                      controller: controller.newPassword,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm New Password'),
                                    ),
                                  ],
                                ),
                                textConfirm: 'Update',
                                onConfirm: () {
                                  if (controller.oldPassword.text ==
                                      controller.newPassword.text) {
                                    controller.password.value =
                                        controller.newPassword.text;
                                    controller.updateinfo();
                                    controller.clear();
                                    Get.back();
                                  }
                                },
                                textCancel: 'Cancel',
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            }),
                            icon: Icon(Icons.edit))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                        width: Get.width * 0.25,
                        child: Text('Name: ',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Text(
                        controller.username.value.isEmpty
                            ? 'Not set yet'
                            : controller.username.value,
                        style: TextStyle(fontSize: 18)),
                    Spacer(),
                    SizedBox(
                        width: Get.width * 0.2,
                        child: IconButton(
                            onPressed: (() {
                              Get.defaultDialog(
                                confirmTextColor: Colors.white,
                                title: 'Update Name',
                                content: Column(
                                  children: [
                                    TextField(
                                      controller: controller.name,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Name'),
                                    ),
                                  ],
                                ),
                                textConfirm: 'Update',
                                onConfirm: () {
                                  controller.username.value =
                                      controller.name.text;
                                  controller.updateinfo();
                                  controller.clear();
                                  Get.back();
                                },
                                textCancel: 'Cancel',
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            }),
                            icon: Icon(Icons.edit))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
