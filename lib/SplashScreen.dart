import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nutricare/auth/LoginPage.dart';
import 'package:nutricare/pages/GetStarted.dart';
import 'package:nutricare/pages/Index.dart';
import 'package:nutricare/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   String? token = '';

    Future<void> _getToken() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('token');
      if (data != null && data.isNotEmpty) {
        setState(() {
          token = data;
        });
      } else {
        // Token is empty or null, navigate to login page
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AwalPageRole(),
            ),
          );
        });
      }
    }


    @override
    void initState() {
      super.initState();
      _getToken();
    }


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Transform.scale(
        scale: 2,
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      nextScreen: token != null && token!.isNotEmpty ? IndexPage() : AwalPageRole(), // Gantilah dengan halaman utama Anda
      splashTransition: SplashTransition.fadeTransition,// Animasi fade
      duration: 3000, // Durasi tampilan splash screen (dalam milidetik)
      backgroundColor: biruungu, // Warna latar belakang
    );
  }
}
