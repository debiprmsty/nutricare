import 'package:flutter/material.dart';
import 'package:nutricare/auth/loginPage.dart';
import 'package:nutricare/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NUTRICARE',
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}

