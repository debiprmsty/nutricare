import 'package:flutter/material.dart';
import 'package:nutricare/SplashScreen.dart';
import 'package:nutricare/theme.dart';

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
      home: SplashScreen(),
      theme: ThemeData(
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: biruungu,
          todayBackgroundColor: MaterialStatePropertyAll(biruungu),
          dayStyle: poppins,
          surfaceTintColor: Colors.white,
          rangeSelectionBackgroundColor: biruungu,
          headerHeadlineStyle: poppins,
          rangePickerBackgroundColor: biruungu
        )
      ),
    );
  }
}

