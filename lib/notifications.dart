import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static const String channel_id = "pomodoro_time_channel";
  static const String channel_name = "Pomodoro Time";
  static const String channel_desc =
      "Pomodoro Time notifications channel to notify the user.";

  factory NotificationManager() {
    return _instance;
  }

  NotificationManager._internal() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future cancel(int id) => _flutterLocalNotificationsPlugin.cancel(id);
  Future cancelAll() => _flutterLocalNotificationsPlugin.cancelAll();

  Future<void> showOngoingNotification(
    int id,
    String title,
    String body,
  ) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel_id,
      channel_name,
      channel_desc,
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: true,
      autoCancel: false,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) {
        debugPrint("id: $id");
        debugPrint("title: $title");
        debugPrint("body: $body");
        debugPrint("payload: $payload");
        return;
      },
    );

    var initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) {
        debugPrint("payload: $payload");
        return;
      },
    );
  }
}
