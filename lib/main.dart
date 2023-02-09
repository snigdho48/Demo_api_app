import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/Conostant.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
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