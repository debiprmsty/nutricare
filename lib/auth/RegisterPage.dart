import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutricare/api/auth.dart';
import 'package:nutricare/auth/LoginPage.dart';
import 'package:nutricare/models/Kabupaten.dart';
import 'package:nutricare/models/Kecamatan.dart';
import 'package:nutricare/models/Kelurahan.dart';
import 'package:nutricare/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  AuthController _authController = AuthController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dusunController = TextEditingController();
  String _email = '', _password = '';
 
  KabupatenModel _selectedKabupaten  = KabupatenModel(id: '0', nama: 'Pilih Kabupaten',);
  KecamatanModel _selectedKecamatan = KecamatanModel(id: '0', nama: 'Pilih Kecamatan');
  KelurahanModel _selectedKelurahan = KelurahanModel(id: '0', nama: 'Pilih Kelurahan');
  
  String id_kecamatan = '';
  String id_kelurahan = '';
  String id_kabupaten = '';

  String _apiKabupaten = "https://ibnux.github.io/data-indonesia/kabupaten/51.json";
  String _apiKecamatan = "https://ibnux.github.io/data-indonesia/kecamatan/.json";
  String _apiKelurahan= "https://ibnux.github.io/data-indonesia/kelurahan/.json";
 

  bool isChecked = false;
  bool _showPassword = false;
  bool _isFormValid = false;
  bool isPilihLokasi = false;
  bool isLoading = false;

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
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height * 1.5 - 110,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height * 2,
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
                      height: 600,
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
                                    return const LoginPagePetugas();
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
                  height: 840,
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
                          child: Center(child: Text("Hi Petugas!", style: inclusiveSans.copyWith(fontSize: 27, color: biruungu, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        ),
                        Center(child: Text("Create a new account", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.grey[400], fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        const SizedBox(
                          height: 30,
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
                              
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: width,
                                height: 70,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownSearch<KabupatenModel>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    
                                  ),
                                  asyncItems: (String filter) async {
                                      var response = await Dio().get(
                                          _apiKabupaten,
                                          
                                      );
                                      var models = KabupatenModel.fromJsonList(response.data);
                                      return models;

                                  },

                                  dropdownDecoratorProps: DropDownDecoratorProps(

                                      dropdownSearchDecoration: InputDecoration(
                                          labelText: "Kabupaten",
                                          hintText: "country in menu mode",
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Icon(Icons.map,color: biruungu,),
                                          ),
                                          prefixIconConstraints: BoxConstraints(minWidth: 35)
                                          
                                      ),
                                  ),
                                 onChanged: (KabupatenModel? data) {
                                    setState(() {
                                      KabupatenModel newData = data!;
                                      _selectedKabupaten = newData;
                                      id_kabupaten = newData.id.toString();
                                      print(id_kabupaten);
                                      id_kecamatan = newData.id.toString();
                                      _apiKecamatan = "https://ibnux.github.io/data-indonesia/kecamatan/${id_kecamatan}.json";
                                    });
                                  },
                                  selectedItem: _selectedKabupaten,
                                  itemAsString: (KabupatenModel? item) => item?.nama ?? "Pilih Kabupaten",
                                  ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: width,
                                height: 70,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownSearch<KecamatanModel>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    
                                  ),
                                  asyncItems: (String filter) async {
                                      var response = await Dio().get(
                                          _apiKecamatan,
                                          
                                      );
                                      var models = KecamatanModel.fromJsonList(response.data);
                                      return models;

                                  },

                                  dropdownDecoratorProps: DropDownDecoratorProps(

                                      dropdownSearchDecoration: InputDecoration(
                                          labelText: "Kecamatan",
                                          hintText: "country in menu mode",
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Icon(Icons.map,color: biruungu,),
                                          ),
                                          prefixIconConstraints: BoxConstraints(minWidth: 35)
                                          
                                      ),
                                  ),
                                 onChanged: (KecamatanModel? data) {
                                    setState(() {
                                      KecamatanModel newData = data!;
                                      _selectedKecamatan = newData;
                                      id_kelurahan = newData.id;
                                      _apiKelurahan= "https://ibnux.github.io/data-indonesia/kelurahan/${id_kelurahan}.json";
                                      print(_selectedKecamatan.id);
                                    });
                                  },
                                  selectedItem: _selectedKecamatan,
                                  itemAsString: (KecamatanModel? item) => item?.nama ?? "Pilih Kecamatan",
                                  ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: width,
                                height: 70,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownSearch<KelurahanModel>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    
                                  ),
                                  asyncItems: (String filter) async {
                                      var response = await Dio().get(
                                          _apiKelurahan,
                                          
                                      );
                                      var models = KelurahanModel.fromJsonList(response.data);
                                      return models;

                                  },

                                  dropdownDecoratorProps: DropDownDecoratorProps(

                                      dropdownSearchDecoration: InputDecoration(
                                          labelText: "Kelurahan",
                                          hintText: "country in menu mode",
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Icon(Icons.map,color: biruungu,),
                                          ),
                                          prefixIconConstraints: BoxConstraints(minWidth: 35)
                                          
                                      ),
                                  ),
                                 onChanged: (KelurahanModel? data) {
                                    setState(() {
                                      KelurahanModel newData = data!;
                                      _selectedKelurahan = newData!;
                                      print(_selectedKelurahan.id);
                                    });
                                  },
                                  selectedItem: _selectedKelurahan,
                                  itemAsString: (KelurahanModel? item) => item?.nama ?? "Pilih Kelurahan",
                                  ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    style: inclusiveSans,
                                    controller: _dusunController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: biruungu)
                                      ),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Icon(Icons.holiday_village_outlined,color: biruungu,)),
                                      hintText: "Nama Posyandu/Puskesmas",
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
                                        return const LoginPagePetugas();
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
                                        return const LoginPagePetugas();
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
                                  String id_kbpt = id_kabupaten;
                                  String id_kcmt = id_kecamatan;
                                  String id_klrh = id_kelurahan;
                                  String namaDusun = _dusunController.text;

                                  final data = {
                                    'fullname' : fullname,
                                    'email' : email,
                                    'password' : password,
                                    'no_hp' : no_hp,
                                    'code_kabupaten' : id_kbpt,
                                    'code_kecamatan' : id_kcmt,
                                    'code_kelurahan' : id_klrh
                                  };

                                  await _authController.register(fullname, email, password, no_hp, 'petugas', id_kbpt, id_kcmt, id_klrh, namaDusun).then((value) {
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
                                        return LoginPagePetugas(); // Gantilah LoginPage dengan nama kelas halaman login Anda
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


                                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //   return const LoginPagePetugas();
                                  // }));
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