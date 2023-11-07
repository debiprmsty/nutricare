import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutricare/api/auth.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/auth_owner/RegisterPageOwner.dart';
import 'package:nutricare/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/Index.dart';

class LoginPageOwner extends StatefulWidget {
  const LoginPageOwner({super.key});

  @override
  State<LoginPageOwner> createState() => _LoginPageOwnerState();
}

class _LoginPageOwnerState extends State<LoginPageOwner> {
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  final UserController _userController = UserController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email = '', _password = '';

  bool isClick = false;

  bool _showPassword = false;
  bool _isFormValid = false;

  bool _isValidEmail(String email) {
  // Gunakan ekspresi reguler atau metode validasi lainnya untuk memeriksa format email
  // Contoh sederhana: periksa apakah email mengandung "@" dan "."
    return email.contains('@') && email.contains('.');
  }

  bool _isValidPassword(String password) {
    // Periksa panjang password (misalnya, minimal 8 karakter)
    return password.length >= 8;
  }



  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFormState() {
    setState(() {
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        _isFormValid = _isValidEmail(_emailController.text) && _isValidPassword(_passwordController.text);
      } else {
        _isFormValid = false;
      }
    });
  }


  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Center(
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width,
                        height: 500,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(    
                          color: biruungu,         
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 67),
                        child: Image.asset("assets/images/logo.png", width: 250, height: 150,),
                      )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account?",
                          style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: inclusiveSans.copyWith(fontWeight: FontWeight.bold, color: biruungu, fontSize: 17,),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const RegisterPageOwner();
                                }));
                              },
                            )
                          ]
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 250,
                left: 10,
                right: 10,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 100,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                        offset: Offset(0, 2.5), // Offset bayangan (x, y)
                        blurRadius: 0.5,
                        spreadRadius: 0.0, // Radius penyebaran bayangan
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Welcome Owner!", style: inclusiveSans.copyWith(fontSize: 27, color: biruungu, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        Center(child: Text("Sign in to continue", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        const SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    style: inclusiveSans,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: biruungu)
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Icon(Icons.mail_outline_rounded, color: biruungu,)),
                                      hintText: "Email",
                                      hintStyle: inclusiveSans.copyWith(color: Colors.grey[400]),
                                      isDense: false,
                                      isCollapsed: false,
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 10,
                                        minHeight: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    style: inclusiveSans,
                                    obscureText: !_showPassword,
                                    onSaved: (value) {
                                      _password = value!;
                                    },
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: togglePasswordVisibility,
                                        icon: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: biruungu)
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Icon(Icons.lock_outline_rounded, color: biruungu,)),
                                      hintText: "Password",
                                      hintStyle: inclusiveSans.copyWith(color: Colors.grey[400]),
                                      isDense: false,
                                      isCollapsed: false,
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 10,
                                        minHeight: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isClick = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Forgot Password ?", style: isClick == true?inclusiveSans.copyWith(fontSize: 15, color: biruungu, decoration: TextDecoration.underline):inclusiveSans.copyWith(fontSize: 15, color: Colors.grey[400],)),
                          ),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                        Center(
                          child: SizedBox(
                            width: 320,
                            height: 43,
                            child: FilledButton(
                              onPressed: _isFormValid
                                ? () async {
                                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Email dan password harus diisi.'),
                                        ),
                                      );
                                    } else {
                                        _formKey.currentState!.save();

                                      String email = _emailController.text;
                                      String password = _passwordController.text;
                                      // Lakukan tindakan saat LOGIN berhasil
                                      await _authController
                                      .login(email, password)
                                      .then((value) async {
                                        if (value['success'] == false) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Email atau Password salah'),
                                              duration: Duration(
                                                  seconds: 2), // Durasi notifikasi
                                            ),
                                          );
                                        } else if (value['success'] == true) {
                                          final SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                          prefs.setString(
                                              'token',
                                              value[
                                                  'token']); 
                                           _userController.fetchUser().then((value) => {
                                              if(value != null) {
                                                if(value['role'] == 'viewer') {
                                                  Navigator.pushReplacement(context,
                                                      MaterialPageRoute(builder: (context) {
                                                    return IndexPage();
                                                  }))
                                                }else if(value['role'] == 'petugas') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Maaf sudah terdaftar menjadi petugas, silahkan masuk sebagai petugas'),
                                                      duration: Duration(
                                                          seconds: 2), // Durasi notifikasi
                                                    ),
                                                  )
                                                }
                                              }
                                            });// Simpan toke
                                                  
                                        
                                        }
                                      });
                                    }
                                  }
                                : null, 
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  _isFormValid ? biruungu : Colors.grey, // Warna tombol berubah sesuai status validasi
                                ),
                              ),
                              child: Text(
                                "LOGIN",
                                style: inclusiveSans.copyWith(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text("Or sign in with:", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.grey[400]),),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50/2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Image.asset("assets/images/google.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50/2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Image.asset("assets/images/facebook.png"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}