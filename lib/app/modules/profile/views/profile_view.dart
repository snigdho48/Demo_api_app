import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
              Obx(() => controller.connected.type.value == false
                  ? GetSnackBar(
                      title: 'No Internet Connection',
                      message: 'Please check your internet connection',
                    )
                  : Container()),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Container(
                          width: Get.width * 0.5,
                          height: Get.width * 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Obx(
                              () =>
                                  controller.image.value ??
                                  Icon(
                                    Icons.person,
                                    size: 100,
                                  ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          )),
                      Positioned(
                        top: Get.height * 0.03,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              controller.image.value = await Get.dialog(Dialog(
                                child: Container(
                                  height: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        ' Choose an option to Select Image',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await controller
                                                  .checkCameraPermission()
                                                  .then((value) async {
                                                if (controller
                                                        .hasCameraPermission ==
                                                    true) {
                                                  await ImagePicker()
                                                      .pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                        imageQuality: 25,
                                                      )
                                                      .then((value) async {
                                                        if (value != null) {
                                                          controller
                                                                  .image.value =
                                                              await controller
                                                                  .imageUpdate(
                                                                      value);
                                                        }
                                                      })
                                                      .then((value) =>
                                                          GetSnackBar(
                                                            title:
                                                                'Image Updated',
                                                            message:
                                                                'Image Updated Successfully',
                                                          ))
                                                      .then((value) =>
                                                          Get.back());
                                                } else {
                                                  GetSnackBar(
                                                    title: 'Permission Denied',
                                                    message:
                                                        'Please allow camera permission',
                                                  );
                                                  controller.update();
                                                }
                                              }).then((value) => Get.back());
                                            },
                                            child: Text('Camera'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await controller
                                                  .checkfilePermission()
                                                  .then((value) async {
                                                if (controller
                                                        .hasstoragePermission ==
                                                    true) {
                                                  await ImagePicker()
                                                      .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 25,
                                                      )
                                                      .then((value) async {
                                                        if (value != null) {
                                                          await controller
                                                              .imageUpdate(
                                                                  value);
                                                        }
                                                      })
                                                      .then((value) =>
                                                          GetSnackBar(
                                                            title:
                                                                'Image Updated',
                                                            message:
                                                                'Image Updated Successfully',
                                                          ))
                                                      .then((value) =>
                                                          Get.back());
                                                } else {
                                                  GetSnackBar(
                                                    title: 'Permission Denied',
                                                    message:
                                                        'Please allow Storage permission',
                                                  );
                                                  controller.update();
                                                }
                                              }).then((value) => Get.back());
                                            },
                                            child: Text('Gallery'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
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
