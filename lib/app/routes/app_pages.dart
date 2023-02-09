import 'package:get/get.dart';

import 'package:demo_app/app/modules/detailPreview/bindings/detail_preview_binding.dart';
import 'package:demo_app/app/modules/detailPreview/views/detail_preview_view.dart';
import 'package:demo_app/app/modules/home/bindings/home_binding.dart';
import 'package:demo_app/app/modules/home/views/home_view.dart';
import 'package:demo_app/app/modules/login/bindings/login_binding.dart';
import 'package:demo_app/app/modules/login/views/login_view.dart';
import 'package:demo_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:demo_app/app/modules/profile/views/profile_view.dart';
import 'package:demo_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:demo_app/app/modules/settings/views/settings_view.dart';
import 'package:demo_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:demo_app/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PREVIEW,
      page: () => DetailPreviewView(),
      binding: DetailPreviewBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
