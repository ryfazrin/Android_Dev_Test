import 'package:android_dev_test/ui/first_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Android Test',
      theme: CupertinoThemeData(
        primaryColor: Color(0xFF2B637B),
      ),
      home: FirstScreen(),
    );
  }
}
