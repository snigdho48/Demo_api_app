import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      bottomNavigationBar: Navigation(),
      floatingActionButton: navaction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Obx(() => controller.connected.type.value == false
              ? GetSnackBar(
                  title: 'No Internet Connection',
                  message: 'Please check your internet connection',
                )
              : Container()),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'Theme Change',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Obx(
                  () => FlutterSwitch(
                    width: 100.0,
                    height: 40.0,
                    toggleSize: 25.0,
                    value: !controller.theme.value,
                    borderRadius: 30.0,
                    activeToggleColor: Color(0xFF6E40C9),
                    inactiveToggleColor: Color(0xFF2F363D),
                    activeSwitchBorder: Border.all(
                      color: Color(0xFF3C1E70),
                      width: 2.0,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Color(0xFFD1D5DA),
                      width: 2.0,
                    ),
                    activeColor: Color(0xFF271052),
                    inactiveColor: Colors.white,
                    activeIcon: Icon(
                      Icons.nightlight_round,
                      color: Color(0xFFF8E3A1),
                    ),
                    inactiveIcon: Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFFDF5D),
                    ),
                    onToggle: (val) {
                      controller.changetheme();
                      controller.update();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
