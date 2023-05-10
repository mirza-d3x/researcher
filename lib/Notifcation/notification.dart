//
// Author: Geojit Technologies PVT LTD
// notification.dart (c) 2023
// Desc: Copyright (C) Geojit technologies (P) Ltd, All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
// Created:  2023-05-09T04:57:15.081Z
//

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  void registerPushNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.notification!.title}');
        if (message.notification != null) {
          log("=====================Sound========================${message.data['sound']}");
          log(message.data.toString());
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              sound: message.data['sound'],
              channelId: message.data['channelId']);
          log('Message also contained a notification: ${message.notification!.title}');
        }
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('A new onMessageOpenedApp event was published!');
        log('Message data: ${message.notification!.title}');
      });
    } else {
      log('User declined permission');
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log("000000000000000000000000000000000000000000000000000000000000000000000000000000");
    log('Handling a background message ${message.notification!.title}');
    log("=====================Sound========================${message.data['sound']}");
    log(message.data.toString());
    return showNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      sound: message.data['sound'],
      channelId: message.data['channelId'],
    );
  }

  initNotification() async {
    const androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');

    const notificationSettings =
        InitializationSettings(android: androidSettings);
    await notifications.initialize(notificationSettings);
  }

  showNotification({
    int id = 0,
    required String title,
    required String body,
    required String sound,
    required String channelId,
  }) async {
    await notifications.show(
        id, title, body, getNotificationDetails(sound, channelId));
  }

  getNotificationDetails(String sound, String channelId) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        "channelName",
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(sound),
      ),
    );
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}