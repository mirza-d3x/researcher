import 'package:flutter/material.dart';
import 'package:researcher/Animation/animation_main.dart';
import 'package:researcher/Notifcation/notication_test.dart';
import 'package:researcher/Notifcation/notification.dart';
import 'package:researcher/PasswordGenerator/password_generator.dart';
import 'package:researcher/VideoCall/video_call_screen.dart';
import 'package:researcher/rz/Pagination/UI/list_view.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  void initState() {
    Notifications().initNotification();
    Notifications().registerPushNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PaginationView(),
                      ),
                    );
                  },
                  child: const Text('Pagination'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PasswordGenerator(),
                      ),
                    );
                  },
                  child: const Text('Password Generator'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AnimationMainScreen(),
                      ),
                    );
                  },
                  child: const Text('Animation'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VideoCallingScreen(),
                      ),
                    );
                  },
                  child: const Text('VideoCall'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                  child: const Text('Notifications'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
