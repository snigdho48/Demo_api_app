import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../shared_pref.dart';
import '../../helper_functions.dart';
import '../../networkCheck/controllers/network_check_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  Image? image = null;
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
    try {
      image = await getImage();
    } catch (e) {
      print(e);
    }
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

  void imageUpdate(updateimage) async {
    if (updateimage != null) {
      final _image = path.basename(updateimage.path);
      final Directory docDir = await getApplicationDocumentsDirectory();
      final String localPath = docDir.path;
      File file = File('$localPath/${path.split('/').last}$_image');
      final imageBytes = await rootBundle.load('assets/images/$_image');
      final buffer = imageBytes.buffer;
      File newFile = await file.writeAsBytes(buffer.asUint8List(
          imageBytes.offsetInBytes, imageBytes.lengthInBytes));
      await saveImage(image: newFile.path);
      image = await getImage();
      update();
    }
    update();
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
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
