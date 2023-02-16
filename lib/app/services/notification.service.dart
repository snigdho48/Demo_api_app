import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

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
      id, element['msg'], element['msg'], element['time'].toDate().toLocal());
}

void sendNotification(element, rng) {
  final id = rng.nextInt(1000);
  NotificationService()
      .showNotification(id, element['msg'], element['msg'], payload: [
    id,
    element['msg'],
    element['msg'],
    DateFormat('dd/MM/yyyy HH:mm:ss').format(element['time'].toDate().toLocal())
  ]);
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationService notificationService = NotificationService();
    await notificationService.init();
    await getandsetAllPush();
    return Future.value(true);
  });
  Workmanager().registerPeriodicTask(
    "1",
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
    initialDelay: Duration(seconds: 10),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}
