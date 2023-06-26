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
  // Create an instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  // Create an instance of Firebase Message
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Register Push Notification
  //  call this method in main method or initstate
  void registerPushNotifications() async {
    // local notification Initializing
    initNotification();
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
          //  Notification title, body,sound and channelId from Server notification
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              sound: message.data['sound'],
              channelId: message.data['channelId']);
          log('Message also contained a notification: ${message.notification!.title}');
        }
      });

      // Call background Notification handler here
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('A new onMessageOpenedApp event was published!');
        log('Message data: ${message.notification!.title}');
        // Write here the code for what should happen on pressed on notification
      });
    } else {
      log('User declined permission');
    }
  }

//  This method for Handle notification while app running in background
  Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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

// Initializing Local Notifications Settings
  initNotification() async {
    // Icon to show in notification
    //  This settings is only for Android Device
    const androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');

    const notificationSettings =
        InitializationSettings(android: androidSettings);
    await notifications.initialize(notificationSettings);
  }

// call this method to Show Local Notification
  showNotification({
    int id = 0,
    required String title,
    required String body,
    required String sound,
    required String channelId,
  }) async {
    await notifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            // channel Id  must be unique to every notification otherwise sound will not change
            channelId,
            "channelName",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            // using custom notification sound from raw,
            // custom notification sound must be added in android/app/src/main/res/raw
            // first create faw file then add custom sound
            sound: RawResourceAndroidNotificationSound(sound)),
      ),
    );
  }
}
