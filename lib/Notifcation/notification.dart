//
// Author: Geojit Technologies PVT LTD
// notification.dart (c) 2023
// Desc: Copyright (C) Geojit technologies (P) Ltd, All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
// Created:  2023-05-09T04:57:15.081Z
//

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  late final FirebaseMessaging _messaging;

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
          print(
              "=====================Sound========================${message.data['sound']}");
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              sound: message.data['sound']);
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
    log('Handling a background message ${message.notification!.title}');
    print(
        "=====================Sound========================${message.data['sound']}");
    showNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        sound: message.data['sound']);
  }

  // void registerNotification() async {
  //   await Firebase.initializeApp();

  //   _messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       log('Got a message whilst in the foreground!');
  //       log('Message data: ${message.data}');

  //       if (message.notification != null) {
  //         log("NotificationRecieved");
  //         showNotification(
  //           title: message.notification!.title!,
  //           body: message.notification!.body!,
  //         );
  //         log(
  //             'Message also contained a notification: ${message.notification}');
  //       }
  //     });

  //     // FirebaseMessaging.onBackgroundMessage(
  //     //     _firebaseMessagingBackgroundHandler);

  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       log('A new onMessageOpenedApp event was published!');
  //       log('Message data: ${message.data}');
  //       showNotification(
  //         title: message.notification!.title!,
  //         body: message.notification!.body!,
  //       );
  //     });
  //   } else {
  //     log('User declined permission');
  //   }
  // }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   showNotification(
  //     title: message.notification!.title!,
  //     body: message.notification!.body!,
  //   );
  //   log('Handling a background message ${message.messageId}');
  // }

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
  }) async {
    print("=====================Sound========================$sound");
    notifications.show(id, title, body, await getNotificationDetails(sound));
  }

  getNotificationDetails(String sound) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "channelIdfsgfgs",
        "channelName",
        importance: Importance.max,
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

// Initialize the FirebaseMessaging instance
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// Request permission for receiving push notifications (optional)
void requestPermissionForPushNotifications() async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  log('User granted permission: ${settings.authorizationStatus}');
}

// Get the device token for push notifications (required for sending notifications)
void getDeviceTokenForPushNotifications() async {
  String? token = await _firebaseMessaging.getToken();
  log('Device token for push notifications: $token');
}

// Listen for incoming push notifications while the app is in the foreground (optional)
void handleIncomingForegroundNotifications() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Received a foreground message: ${message.notification!.title}');
  });
}

// Listen for incoming push notifications while the app is in the background (optional)
void handleIncomingBackgroundNotifications() {
  FirebaseMessaging.onBackgroundMessage((message) {
    log('Received a background message: ${message.notification!.title}');
    return Future<void>.value();
  });
}

// Listen for incoming push notifications while the app is terminated (optional)
void handleIncomingTerminatedNotifications() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log('Received a terminated message: ${initialMessage.notification!.title}');
  }
}
