import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_flow/domain/models/notification_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse?> notificationStream =
      StreamController<NotificationResponse?>.broadcast();

  static Stream<NotificationResponse?> get onNotificationTapped =>
      notificationStream.stream;

  static Future<void> requestPermission() async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      if (await FlutterForegroundTask.checkNotificationPermission() !=
          NotificationPermission.granted) {
        await FlutterForegroundTask.requestNotificationPermission();
      }
      await init();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  static Future<void> init() async {
    final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();

    // to change the zone to my zone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        notificationStream.add(response);
      },
    );
  }


  static void scheduleNotification(NotificationModel notification, DateTime date) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        notification.channelID,
        notification.channelName,
        priority: Priority.max,
        importance: Importance.max,
      ),
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: notification.notificationId,
      title: notification.title,
      body: notification.body,
      payload: notification.payload,
      scheduledDate: tz.TZDateTime.from(date, tz.local),
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }
}
