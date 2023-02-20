import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "Snigdho",
    channelDescription:
        "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static final IOSNotificationDetails _iOSNotificationDetails =
      IOSNotificationDetails();

  final NotificationDetails notificationDetails = NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );
  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    final IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    // *** Initialize timezone here ***
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> requestAndroidPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> androidPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  Future<void> showNotification(int id, String title, String body,
      {required payload}) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime eventDate,
      [DateTimeComponents? dateTimeComponents]) async {
    final payload = [
      id,
      title,
      body,
      DateFormat('dd/MM/yyyy HH:mm:ss').format(eventDate).toString()
    ];
    final scheduledTime = eventDate;
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: jsonEncode(payload),
      matchDateTimeComponents: dateTimeComponents,
    );
    print('$payload is payload');
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> onSelectNotification(String? payload) async {
    final json = jsonDecode(payload!);
    await Get.toNamed('/notifications', arguments: json);
  }
}
