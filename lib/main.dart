import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/Conostant.dart';
import 'app/modules/networkCheck/bindings/network_check_binding.dart';
import 'app/modules/notifications/bindings/notifications_binding.dart';
import 'app/modules/notifications/controllers/notifications_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await getAllPush();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  runApp(
    GetMaterialApp(
      initialBinding: BindingsBuilder(() async {
        Get.put(NotificationsBinding());
        Get.put(NetworkCheckBinding());
      }),
      builder: EasyLoading.init(),
      defaultTransition: Transition.fadeIn, //
      // transitionDuration: Duration(seconds: 0),
      theme: ThemeUtils.light,
      darkTheme: ThemeUtils.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
