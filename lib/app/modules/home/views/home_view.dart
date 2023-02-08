import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Api_Get.dart';
import '../../helper_functions.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
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
                ListTile(
                  leading: Text('ID ${lmodel[i].id}'),
                  title: Text('Title ${lmodel[i].title!}'),
                  subtitle: Text('Status ${lmodel[i].completed}'),
                  trailing: Text('User ID ${lmodel[i].userId}'),
                )
            ],
          ),
        );
      }),
    );
  }
}
