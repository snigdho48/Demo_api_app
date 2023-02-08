import 'package:flutter/material.dart';
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
Future<void> logout() async {
  await setstatus(isLogin: false);
  Get.offNamed('/login');
}

void jumpToPage(int index) {
  selected.value = index;
  print(index);
  switch (index) {
    case 0:
      Get.offAllNamed('/home');
      break;
    case 1:
      Get.offNamed('/dashboard');
      break;
    case 2:
      Get.offNamed('/profile');
      break;
    case 3:
      Get.offNamed('/settings');

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
