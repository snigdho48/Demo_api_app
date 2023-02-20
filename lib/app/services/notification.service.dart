import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/DB.dart';
import '../shared_pref.dart';
import 'notification.dart';

List PushNoti = [];

Future<void> getandsetAllPush() async {
  bool newInstall = false;
  PushNoti = await getNoti();
  Db.getNoti().listen((event) async {
    if (PushNoti.isEmpty) {
      PushNoti = event.docs.map((e) => e.data()).toList();
      print('new');
      newInstall = true;
    } else {
      print('old');
      newInstall = false;
      PushNoti = PushNoti.reversed.toList();
    }
    event.docs.forEach((element) {
      final rng = Random();
      if (PushNoti.toString().contains(element.data().toString())) {
        print('matched');
        if (newInstall) {
          PushNoti.add(element.data());
          SetNotification(element, rng);
        }
      } else {
        PushNoti.add(element.data());
        SetNotification(element, rng);
      }
    });
    await saveNoti(list: event.docs.map((e) => e.data()).toList());
  });
}

void SetNotification(
    QueryDocumentSnapshot<Map<String, dynamic>> element, Random rng) {
  if (DateTime.parse(element['time'].toDate().toString())
      .isAfter(DateTime.now())) {
    print('ScheduleNotification');
    sendScheduleNotification(element.data(), rng);
  } else {
    print('Notification');
    sendNotification(element.data(), rng);
  }
}

void sendScheduleNotification(element, rng) {
  // final Date = DateTime.parse(element['time'].toDate().toString());
  final id = rng.nextInt(1000);
  NotificationService().scheduleNotification(
      1, element['msg'], element['msg'], element['time'].toDate().toLocal());
}

void sendNotification(element, rng) {
  final id = rng.nextInt(1000);
  NotificationService()
      .showNotification(1, element['msg'], element['msg'], payload: [
    id,
    element['msg'],
    element['msg'],
    DateFormat('dd/MM/yyyy HH:mm:ss').format(element['time'].toDate().toLocal())
  ]);
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    await Firebase.initializeApp();
    NotificationService notificationService = NotificationService();
    await notificationService.init();
    await getandsetAllPush();
    if (Get.routing.current == '/home') {
      await Permission.notification.isDenied.then((value) async {
        await NotificationService().requestIOSPermissions();
        await NotificationService().requestAndroidPermission();
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
      });
    }
  });
}

Future<void> backgroundinit() async {
  DartPluginRegistrant.ensureInitialized();
  final service = FlutterBackgroundService();
  service.invoke('setAsBackground');
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      autoStartOnBoot: true,
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
}
