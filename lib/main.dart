import 'package:flutter/material.dart';
import 'package:tawelticlient/HomePage.dart';
import 'package:tawelticlient/Restaurant/RestaurantProfil.dart';
import 'package:tawelticlient/auth/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

