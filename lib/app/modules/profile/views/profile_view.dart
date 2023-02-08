import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ProfileView'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
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
                            onPressed: (() {}), icon: Icon(Icons.edit))),
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
                                  if{
                                    controller.oldPassword.text == controller.newPassword.text
                                  }{
                                    controller.updateinfo();
                                  }
                                },
                                textCancel: 'Cancel',
                                onCancel: () {Get.back();},
                              );
                            }),
                            icon: Icon(Icons.edit))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
