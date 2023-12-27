import 'package:flutter/material.dart';
import 'package:nutricare/api/ortu.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/pages/Index.dart';
import 'package:nutricare/pages/LoggingPage.dart';
import 'package:nutricare/theme.dart';

class AddOrangTuaPage extends StatefulWidget {
  const AddOrangTuaPage({super.key});

  @override
  State<AddOrangTuaPage> createState() => _AddOrangTuaPageState();
}

class _AddOrangTuaPageState extends State<AddOrangTuaPage> {
  final _formKey = GlobalKey<FormState>();
  OrtuController _ortuController = OrtuController();
  UserController _activeController = UserController();
  final UserController _userController = UserController();
  late User _activeUser = User(id: 0, fullname: "", role: "", image: "");
  
  TextEditingController nik_bapak = TextEditingController();
  TextEditingController _namaBapakController = TextEditingController();
  TextEditingController nik_ibu = TextEditingController();
  TextEditingController _namaIbuController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _noKKController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.fetchUser().then((value) => {
      print(value),
      if (value != null) {
        setState(() {
          _activeUser = User(id: value['id'], fullname: value['fullname'], role: value['role'], image: value['image'],nama_dusun: value['nama_dusun'],);
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: biruungu,
        title: Text('Tambah Data\nOrang Tua', style: inclusiveSans.copyWith(fontSize: 18.5, color: Colors.white), textAlign: TextAlign.center,),
        centerTitle: true,
        elevation: 5,
        shadowColor: biruungu,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height * 0.25 - 70,
                color: biruungu,
              ),
              Positioned(
                top: 30,
                left: 18,
                right: 18,
                child: Container(
                  width: width,
                  height: 570,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                        offset: Offset(0, 2.5), // Offset bayangan (x, y)
                        blurRadius: 0.5,
                        spreadRadius: 0.0, // Radius penyebaran bayangan
                      ),
                    ],
                    border: Border.all(
                      color:  Color.fromARGB(255, 194, 194, 194),
                      width: 1
                    )
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Nomor KK", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: poppins,
                        controller: _noKKController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Masukkan Nomor KK',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("NIK Bapak", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: poppins,
                        controller: nik_bapak,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Masukkan NIK Bapak',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Nama Bapak", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans,
                        controller: _namaBapakController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'Masukkan Nama Bapak',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("NIK Ibu", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: poppins,
                        controller: nik_ibu,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Masukkan NIK Ibu',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Nama Ibu", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans,
                        controller: _namaIbuController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'Masukkan Nama Ibu',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Alamat", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans,
                        controller: _alamatController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'Masukkan alamat dari Orang Tua',
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: biruungu,
                                  width: 2 // Warna border ketika tidak dalam keadaan fokus
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
              offset: Offset(0, 2.5), // Offset bayangan (x, y)
              blurRadius: 0.5,
              spreadRadius: 0.0, // Radius penyebaran bayangan
            ),
          ],
          border: Border(
            top: BorderSide(
              color:  Color.fromARGB(255, 194, 194, 194),
              width: 1
            )
          )
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/info.png", scale: 2.8,),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Pastikan data yang diinputkan sudah benar.", style: inclusiveSans.copyWith(fontSize: 12, color: Colors.grey),)
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan nilai yang diinginkan
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(biruungu)
                  ),
                  onPressed: () async {
                    String noKk = _noKKController.text;
                    String nikBapak = nik_bapak.text;
                    String nikIbu = nik_ibu.text;
                    String namaIbu = _namaIbuController.text;
                    String namaBapak = _namaBapakController.text;
                    String alamat = _alamatController.text;
                    final String nama_posko = _activeUser.nama_dusun.toString();

                    

                    await _ortuController.addOrtu(noKk, nikBapak, nikIbu, namaBapak, namaIbu, alamat, nama_posko).then((value) => {
                      if(value != null) {
                        if(value['success'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data berhasil ditambah'),
                              duration: Duration(seconds: 2), // Durasi notifikasi
                            ),
                          ),
                          Navigator.pop(context)
                        }
                      }
                    });
                  },
                  child: Text("TAMBAH DATA", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.white),)),
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}