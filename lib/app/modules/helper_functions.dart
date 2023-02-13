import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../shared_pref.dart';

// void showMsg(BuildContext context, String msg) =>
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
final selected = 0.obs;
Rx<bool> heart = false.obs;

void showMsg(String msg) => Get.showSnackbar(
      GetSnackBar(
        title: msg,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
    );
AppBar appbar() {
  return AppBar(
    title: Text(Get.currentRoute.toUpperCase().split('/').last),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('No')),
                  TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text('Yes')),
                ],
              ),
            );
          },
          icon: Icon(Icons.logout))
    ],
  );
}

Future<void> logout() async {
  await setstatus(isLogin: false);
  Get.offAllNamed('/login')!
      .then((value) => Get.reset(clearRouteBindings: true));
}

void jumpToPage(int index) {
  selected.value = index;
  print(index);
  switch (index) {
    case 0:
      Get.offAllNamed('/home');
      break;
    case 1:
      Get.offAllNamed('/imagedashboard');
      break;
    case 2:
      Get.offAllNamed('/profile');
      break;
    case 3:
      Get.offAllNamed('/settings');
      break;
    default:
      Get.offAllNamed('/home');
  }
}

class navaction extends GetView {
  const navaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        heart.value = !heart.value;
      },
      backgroundColor: Colors.white,
      child: Obx(() => heart.value
          ? Icon(
              Icons.heart_broken,
              color: Colors.red,
            )
          : Icon(
              Icons.heart_broken_outlined,
              color: Colors.red,
            )),
    );
  }
}

class Navigation extends GetView {
  const Navigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => StylishBottomBar(
          items: [
            BottomBarItem(
              icon: const Icon(
                Icons.house_rounded,
              ),
              selectedIcon: const Icon(Icons.house_rounded),
              selectedColor: Colors.teal,
              title: const Text('Home'),
            ),
            BottomBarItem(
              icon: const Icon(
                Icons.dashboard,
              ),
              selectedIcon: const Icon(Icons.dashboard),
              selectedColor: Colors.teal,
              title: const Text('Dashboard'),
            ),
            BottomBarItem(
              icon: const Icon(
                Icons.person,
              ),
              selectedIcon: const Icon(Icons.person),
              selectedColor: Colors.teal,
              title: const Text('Profile'),
            ),
            BottomBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              selectedIcon: const Icon(Icons.settings),
              selectedColor: Colors.teal,
              title: const Text('Settings'),
            ),
          ],
          hasNotch: true,
          fabLocation: StylishBarFabLocation.center,
          currentIndex: selected.value,
          onTap: (index) {
            jumpToPage(index);
          },
          option: AnimatedBarOptions(
            // iconSize: 32,
            barAnimation: BarAnimation.liquid,
            iconStyle: IconStyle.animated,
            opacity: 0.3,
          ),
        ));
  }
}

bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  if (stopDefaultButtonEvent) {
    return false;
  } else {
    jumpToPage(0);
    return true;
  }
}

exitApp() {
  return Get.dialog(
    AlertDialog(
      title: Text('Exit App'),
      content: Text('Are you sure you want to Exit?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('No')),
        TextButton(
            onPressed: () {
              FlutterExitApp.exitApp(iosForceExit: true);
            },
            child: Text('Yes')),
      ],
    ),
  );
}
