import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:researcher/Notifcation/notification.dart';
import 'package:researcher/firebase_options.dart';
import 'package:researcher/options.dart';
import 'package:researcher/rz/Pagination/Api/api_functions.dart';
import 'package:researcher/rz/Pagination/Bloc/bloc/pagination_bloc_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ApiS apiS = ApiS();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaginationBloc(apiS),
        ),
      ],
      child: MyApp(navigatorKey: navigatorKey),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OptionsPage(),
    );
  }
}
