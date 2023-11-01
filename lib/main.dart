import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rbc_interface/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EIC Chula Team',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Routes(
        pageIndex: 0, // Replace with the initial page index
        pageController: StreamController<int>.broadcast(), // Replace with your StreamController
      ),
    );
  }
}