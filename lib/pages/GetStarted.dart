import 'package:flutter/material.dart';
import 'package:nutricare/auth/LoginPage.dart';
import 'package:nutricare/auth/RegisterPage.dart';
import 'package:nutricare/auth_owner/LoginPageOwner.dart';
import 'package:nutricare/theme.dart';

class AwalPageRole extends StatefulWidget {
  const AwalPageRole({super.key});

  @override
  State<AwalPageRole> createState() => _AwalPageRoleState();
}

class _AwalPageRoleState extends State<AwalPageRole> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          height: height * 1.25,
          color: biruungu,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 245,
              ),
              Center(
                child: Image.asset("assets/images/logo.png", width: 250, height: 150)
              ),
              const SizedBox(
                height: 185,
              ),
              Center(child: Text("Let's Get Started!", style: mooli.copyWith(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)),
              const SizedBox(
                height: 5,
              ),
              Center(child: Text("Aplikasi Pencatatan dan Penilaian\nStatus Gizi Anak ", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: width,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), 
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(5)
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return LoginPage();
                    // }));
      
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const LoginPagePetugas();
                    }));
                  }, 
                  child: Text("Masuk sebagai Petugas", style: inclusiveSans.copyWith(fontSize: 18, color: biruungu, fontWeight: FontWeight.bold),)
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: width,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(biruungu),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), 
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        color: Colors.white, // Warna border
                        width: 1.5, // Lebar border
                      ),
                    ),
                  ),
                  onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const LoginPageOwner();
                    }));
                  }, 
                  child: Text("Masuk sebagai Owner", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}