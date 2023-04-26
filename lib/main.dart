import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:researcher/options.dart';
import 'package:researcher/rz/Pagination/Api/api_functions.dart';
import 'package:researcher/rz/Pagination/Bloc/bloc/pagination_bloc_bloc.dart';

void main() {
  ApiS apiS = ApiS();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaginationBloc(apiS),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
