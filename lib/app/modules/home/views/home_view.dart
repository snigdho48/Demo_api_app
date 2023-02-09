import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Api_Get.dart';
import '../../helper_functions.dart';
import '../controllers/home_controller.dart';
import 'Custom_list/custom_list.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exitApp(),
      child: Scaffold(
        appBar: appbar(),
        bottomNavigationBar: Navigation(),
        floatingActionButton: navaction(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Obx(() {
          if (value.value == false) {
            Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < lmodel.length; i++)
                  InkWell(
                    onTap: () {
                      Get.toNamed('/detail-preview', arguments: lmodel[i].id);
                    },
                    child: customList(
                      leading: 'ID ${lmodel[i].id}',
                      title: 'Title ${lmodel[i].title!}',
                      subtitle: 'Status ${lmodel[i].completed}',
                      trail: 'User ID ${lmodel[i].userId}',
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
