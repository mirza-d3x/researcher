//
// Author: Geojit Technologies PVT LTD
// notication_test.dart (c) 2023
// Desc: Copyright (C) Geojit technologies (P) Ltd, All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
// Created:  2023-05-08T12:25:30.050Z
//

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:researcher/Notifcation/notification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    // const iosSetting = IOSInitializationSettings();

    // #2
    const initSettings = InitializationSettings(android: androidSetting);

    // #3
    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  Notifications notifications = Notifications();
 final AudioPlayer audioPlayers = AudioPlayer();
  @override
  void initState() {
    notifications.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                notifications.showNotification(
                    channelId: "ahgjdjf",
                    title: "Test notification",
                    body: "test notification testing ",
                    sound: 'noti');
              },
              child: const Text("Send Notification"),
            ),
            ElevatedButton(
              onPressed: () {

                audioPlayers.play(AssetSource("sounds/notif.mp3"));
              },
              child: const Text("Alert Sound"),
            ),
            ElevatedButton(
              onPressed: () async {
                final fcmToken = await FirebaseMessaging.instance.getToken();
                log("----------------------------------------Firebase FCM-----------------------------------------");
                log(fcmToken!);
              },
              child: const Text("Generate Token"),
            ),
          ],
        ),
      ),
    );
  }
}
