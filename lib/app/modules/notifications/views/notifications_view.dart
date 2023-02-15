import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    controller.arguments = Get.arguments as List;
    return Scaffold(
      appBar: appbar(),
      bottomNavigationBar: Navigation(),
      floatingActionButton: navaction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('NotificationsView is working', style: TextStyle(fontSize: 20)),
          if (controller.arguments.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                ),
                Text(controller.arguments[0].toString()),
                Text(controller.arguments[1].toString()),
                Text(controller.arguments[2].toString()),
                Text(controller.arguments[3].toString()),
              ],
            ),
        ],
      ),
    );
  }
}
