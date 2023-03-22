import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: const [
                Text(
                  "Generate Strong Random Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _controller,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.cyan,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        final data = ClipboardData(text: _controller.text);
                        Clipboard.setData(data);

                        const snackbar =
                            SnackBar(content: Text("Password Copy"));

                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(snackbar);
                      },
                      icon: const Icon(Icons.copy))),
            ),
            const SizedBox(
              height: 15,
            ),
            buildButtonWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildButtonWidget() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: () {
          final password = generatePassword();
          _controller.text = password;
        },
        child: const Text(
          "Password Generate",
          style: TextStyle(color: Colors.white),
        ));
  }
}

String generatePassword({
  bool letter = true,
  bool isNumber = true,
  bool isSpecial = true,
}) {
  // ankk password nte length adjust cheyyan ith matti koduthal mathi
  const length = 20;
  // pinne ini ithil pedatha etahenkilum character ellam ivide koduthittund
  // ivide ulla characters aan generate aayitt varunnath
  // ankk aavashyam ulla character ivde koduthal mathi
  const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
  const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const number = '0123456789';
  const special = '@#%^*>\$@?/[]=+';

  String chars = "";
  if (letter) chars += '$letterLowerCase$letterUpperCase';
  if (isNumber) chars += number;
  if (isSpecial) chars += special;

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}
