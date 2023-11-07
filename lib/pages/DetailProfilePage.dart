import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProfilePage extends StatefulWidget {
  const DetailProfilePage({super.key});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String _email = '', _password = '';
  String? profileImage = "",code_kecamatan = "", code_kabupaten = "",code_kelurahan="",nama_dusun = "",role = "";
  
  late File? _getImage;
  UserController _userController =  UserController();
  bool _showPassword = false;
  bool _isFormValid = false;
  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) { // Periksa jika gambar telah berhasil diambil
      setState(() {
        _getImage = File(pickedFile.path);
      });

      imageController.text = _getImage!.path;
    }
  }


  Future<void> updateUser(
    String fullname,
    String email,
    String password,
    String no_hp,
    String file,
    String code_kabupaten,
    String code_kecamatan,
    String code_kelurahan,
    String nama_dusun,
    String role
  ) async {
    final token = await _getToken();
    final baseUrl = "https://testchairish.000webhostapp.com/api/";


    if (token != null) {
      final url = "$baseUrl" + "update-user";

      var formData = FormData.fromMap({
        'fullname': fullname,
        'email': email,
        'password': password,
        'no_hp': no_hp,
        'code_kecamatan' : code_kecamatan,
        'code_kelurahan' : code_kelurahan,
        'code_kabupaten' : code_kabupaten,
        'nama_dusun' : nama_dusun,
        'role' : role,
      });

      if (file.isNotEmpty) {
        var imageFile = await MultipartFile.fromFile(file, filename: 'file');
        formData.files.add(MapEntry('file', imageFile));
      }

      try {
        var response = await dio.post(
          url,
          data: formData,
          options: Options(
            followRedirects: false,
            validateStatus: (status) { return status! < 500; },
            headers: {
              "Accept" : "application/json",
              'Authorization': 'Bearer $token',
              },
          ),
        );

        print(response.data);
        return response.data;
        // Tambahkan logika lain sesuai kebutuhan, misalnya penanganan respons sukses atau gagal.
      } catch (error) {
        print('Error: $error');
        // Tambahkan logika penanganan kesalahan sesuai kebutuhan.
      }
    }
  }

  @override
    void initState() {
      super.initState();
      _userController.fetchUser().then((value) => {
        print(value),
        if(value != null) {
          setState(() {
           _emailController.text = value['email'];
           _fullNameController.text = value['fullname'];
           _noHpController.text = value['no_hp'];
           profileImage = value['image'];
           code_kecamatan = value['code_kecamatan'].toString();
           code_kabupaten = value['code_kabupaten'].toString();
           code_kelurahan = value['code_kelurahan'].toString();
           nama_dusun = value['nama_dusun'];
           role = value['role'];
          })
        }
      });
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

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: biruungu,
        title: Text('Profile Setting', style: inclusiveSans.copyWith(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w600),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: biruungu,
          ),
          Positioned(
            top: 100,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 18, right: 18),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: inclusiveSans.copyWith(color: biruungu, fontSize: 17, fontWeight: FontWeight.w600),),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: inclusiveSans,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: biruungu,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: biruungu,
                            width: 1.5 // Warna border ketika tidak dalam keadaan fokus
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.mail_outline_rounded, color: biruungu,),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Full Name", style: inclusiveSans.copyWith(color: biruungu, fontSize: 17, fontWeight: FontWeight.w600),),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: inclusiveSans,
                      controller: _fullNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: biruungu,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: biruungu,
                            width: 1.5 // Warna border ketika tidak dalam keadaan fokus
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.person_outline_rounded, color: biruungu,),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Nomor HP", style: inclusiveSans.copyWith(color: biruungu, fontSize: 17, fontWeight: FontWeight.w600),),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: inclusiveSans,
                      controller: _noHpController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Nomor HP",
                        hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: biruungu,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: biruungu,
                            width: 1.5 // Warna border ketika tidak dalam keadaan fokus
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.phone_outlined, color: biruungu,),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Password", style: inclusiveSans.copyWith(color: biruungu, fontSize: 17, fontWeight: FontWeight.w600),),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: inclusiveSans,
                      obscureText: !_showPassword,
                      onSaved: (value) {
                        _password = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silahkan masukkan password akun terlebih dahulu';
                        }
                        return null;
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
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: biruungu,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: biruungu,
                            width: 1.5 // Warna border ketika tidak dalam keadaan fokus
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: biruungu,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: biruungu,
                            width: 1.5 // Warna border ketika tidak dalam keadaan fokus
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: biruungu,),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      width: width,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(biruungu),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async  {
                          if(_formKey.currentState!.validate()) {
                                _formKey.currentState!.validate();
              
                                String fullname = _fullNameController.text;
                                String email= _emailController.text;
                                String imagePath = imageController.text;
                                String password = _passwordController.text;
                                String no_hp = _noHpController.text;
              
                                final data = {
                                  'fullname' : fullname,
                                  'email' : email,
                                  'image' : imagePath,
                                  'password' : password,
                                  'no_hp' : no_hp
                                };
              
                                
                               await updateUser(fullname, email, password, no_hp, imagePath, code_kabupaten!, code_kecamatan!, code_kelurahan!, nama_dusun!, role!).then((value) => 
                               {
                                       ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('Data berhasil diupdate'),
                                                duration: Duration(seconds: 2), // Durasi notifikasi
                                              ),
                                            ),

                                           Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailProfilePage(),
                                            ),
                                          )
                                    });
              
              
                                }
                        },
                        child: Text('SIMPAN', style: inclusiveSans.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),)
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          Positioned(
            top: 20,
            left: 125,
            child: Container(
              height: 200,
              width: 200,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: profileImage != "" ? NetworkImage("https://testchairish.000webhostapp.com/api/user-image/${profileImage}",) : NetworkImage("https://afpertise.com/media/2020/09/Member-1.jpg",) ,
                  ),
                  Positioned(
                    top: 120,
                    left: 55,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return Container(
                              height: 60.0,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.photo),
                                    title: Text('Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: biruungu,
                          borderRadius: BorderRadius.circular(30/2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                              offset: Offset(0, 2.5), // Offset bayangan (x, y)
                              blurRadius: 0.5,
                              spreadRadius: 0.0, // Radius penyebaran bayangan
                            ),
                          ]
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    )
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}