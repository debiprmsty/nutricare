import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutricare/auth_owner/LoginPageOwner.dart';
import 'package:nutricare/theme.dart';

import '../api/auth.dart';

class RegisterPageOwner extends StatefulWidget {
  const RegisterPageOwner({super.key});

  @override
  State<RegisterPageOwner> createState() => _RegisterPageOwnerState();
}

class _RegisterPageOwnerState extends State<RegisterPageOwner> {
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email = '', _password = '';

  bool isChecked = false;
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

  bool _isValidPhone(String nohp) {
    // Periksa panjang password (misalnya, minimal 8 karakter)
    return nohp.length <= 12;
  }
  
  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
    _noHpController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _updateFormState() {
    setState(() {
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _noHpController.text.isNotEmpty) {
        _isFormValid = _isValidEmail(_emailController.text) && _isValidPassword(_passwordController.text) && _isValidPhone(_noHpController.text);
      } else {
        _isFormValid = false;
      }
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
                  color: Colors.white,             
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
                        padding: const EdgeInsets.only(top: 55),
                        child: Image.asset("assets/images/logo.png", width: 230, height: 130,),
                      )
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: ' Login here',
                                style: inclusiveSans.copyWith(fontWeight: FontWeight.bold, color: biruungu, fontSize: 17,),
                                recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return const LoginPageOwner();
                                  }));
                                },
                              )
                            ]
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 206,
                left: 10,
                right: 10,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 100,
                  height: 540,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Center(child: Text("Hi Owner!", style: inclusiveSans.copyWith(fontSize: 27, color: biruungu, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        ),
                        Center(child: Text("Create a new account", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        const SizedBox(
                          height: 60,
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
                                      errorStyle: inclusiveSans,
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
                                    controller: _fullNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: biruungu)
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Icon(Icons.person_outline_rounded, color: biruungu,)),
                                      hintText: "Full Name",
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
                                    controller: _noHpController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: biruungu)
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Icon(Icons.phone_outlined, color: biruungu,)),
                                      hintText: "Mobile Number",
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
                                    keyboardType: TextInputType.text,
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
                          height: 68,
                        ),
                        Center(
                          child: SizedBox(
                            width: 295,
                            height: 45,
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: "By signing up, you agree to our ",
                                style: inclusiveSans.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: ' Terms, Privacy Policy ',
                                    style: inclusiveSans.copyWith(fontWeight: FontWeight.w600, color: biruungu, fontSize: 15,),
                                    recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return const LoginPageOwner();
                                      }));
                                    },
                                  ),
                                  TextSpan(
                                    text: 'and',
                                    style: inclusiveSans.copyWith(fontWeight: FontWeight.w500, fontSize: 15,),
                                  ),
                                  TextSpan(
                                    text: ' Cookies Policy ',
                                    style: inclusiveSans.copyWith(fontWeight: FontWeight.w600, color: biruungu, fontSize: 15,),
                                    recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return const LoginPageOwner();
                                      }));
                                    },
                                  ),
                                ]
                              )
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 320,
                            height: 43,
                            child: FilledButton(
                              onPressed: _isFormValid ? () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  String fullname = _fullNameController.text;
                                  String newpassword = _passwordController.text;
                                  String no_hp = _noHpController.text;

                                  await _authController.register(fullname, email, password, no_hp, 'viewer', '0', '0', '0', '').then((value) {
                                    if (value != null) {
                                    if (value['success'] == true) {
                                      // Registrasi berhasil
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Registrasi berhasil!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );

                                      // Navigasi ke halaman login setelah notifikasi ditampilkan
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return LoginPageOwner(); // Gantilah LoginPage dengan nama kelas halaman login Anda
                                      }));
                                    } else if (value['message'] == 'The username has already been taken') {
                                      // Nama pengguna sudah terdaftar
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Nama pengguna sudah terdaftar.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      // Menangani kondisi lain jika diperlukan
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Registrasi gagal: ${value['message']}'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } else {
                                    // Menangani jika value null
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Registrasi gagal: Username & email sudah terdaftar'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                  });
                                }
                              } : null,
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( _isFormValid ? biruungu : Colors.grey,)),
                              child: Text("SIGN UP", style: inclusiveSans.copyWith(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),),
                            ),
                          ),
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