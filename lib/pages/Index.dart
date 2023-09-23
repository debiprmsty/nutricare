import 'package:flutter/material.dart';
import 'package:nutricare/pages/HomePage.dart';
import 'package:nutricare/pages/ProfilePage.dart';
import 'package:nutricare/pages/ReportPage.dart';
import 'package:nutricare/pages/loggingPage.dart';
import 'package:nutricare/theme.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;
  
  List<Widget> halaman = [
    const HomePage(),
    const LoggingPage(),
    const ReportPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            halaman.elementAt(_selectedIndex)
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          SalomonBottomBarItem(
              icon: Icon(Icons.home, color: biruungu,),
              title: const Text("Home"),
              selectedColor: biruungu,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.receipt_long, color: biruungu,),
              title: const Text("Logging"),
              selectedColor: biruungu,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.insert_chart, color: biruungu,),
              title: const Text("Report"),
              selectedColor: biruungu,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person, color: biruungu,),
              title: const Text("Profile"),
              selectedColor: biruungu,
            ),
        ]
      ),
    );
  }
}