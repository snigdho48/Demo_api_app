import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:demo_app/app/modules/widgets/imageCroper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared_pref.dart';
import '../../helper_functions.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  bool hasCameraPermission = false;
  bool hasstoragePermission = false;
  Rx<CachedMemoryImage?> image = Rx<CachedMemoryImage?>(null);
  Rx<String> email = ''.obs;
  Rx<String> username = ''.obs;
  Rx<String> password = ''.obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController newenail = TextEditingController();
  final connected = Get.put(NetworkCheckController());

  @override
  Future<void> onInit() async {
    email.value = await getemail();
    password.value = await getpass();
    username.value = await getname();
    image.value = await getImage();
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

  Future<void> checkCameraPermission() async {
    await Permission.camera.request();
    final status = await Permission.camera.status;
    if (status.isGranted) {
      hasCameraPermission = true;
      update(); // only needed if you're using GetBuilder widget
      return; // ending the function here because that's all you need.
    }

    if (status.isDenied) {
      await Permission.camera.request();
    }
    // ...continue to handle all the possible outcomes
    update();
  }

  Future<void> checkfilePermission() async {
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      hasstoragePermission = true;
      update(); // only needed if you're using GetBuilder widget
      return; // ending the function here because that's all you need.
    }

    if (status.isDenied) {
      await Permission.manageExternalStorage.request();
    } // ...continue to handle all the possible outcomes
    update();
  }

  Future<CachedMemoryImage?> imageUpdate(XFile? updateimage) async {
    if (updateimage != null) {
      final lastimage = await cropImage(pickedFile: updateimage);
      if (lastimage != null) {
        await saveImage(image: lastimage);
      }
    }
    image.value = await getImage();
    return image.value;
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
