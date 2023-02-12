import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkCheckController extends GetxController {
  //TODO: Implement NetworkCheckController

  final type = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void onInit() {
    checkConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });

    super.onInit();
  }

  final isConnected = true.obs;
  Future<void> checkConnection() async {
    var connectivityResult;
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return _updateConnectionStatus(connectivityResult);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(connectivityResult);
  }

  _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        type.value = true;
        update();
        break;
      case ConnectivityResult.mobile:
        type.value = true;
        update();
        break;
      case ConnectivityResult.none:
        type.value = false;
        update();
        break;
      default:
        Get.showSnackbar(
          GetSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your internet connection',
            icon: Icon(Icons.error),
          ),
        );
        break;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
