import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper_functions.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(),
        bottomNavigationBar: Navigation(),
        floatingActionButton: navaction(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
          child: Text(
            'NotificationsView is working',
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
