import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';

import 'app/Conostant.dart';
import 'app/modules/networkCheck/bindings/network_check_binding.dart';
import 'app/modules/notifications/bindings/notifications_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/services/notification.dart';
import 'app/services/notification.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

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
