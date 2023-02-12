import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/network_check_controller.dart';

class NetworkCheckView extends GetView<NetworkCheckController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NetworkCheckView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NetworkCheckView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
