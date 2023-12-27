import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutricare/api/balita.dart';
import 'package:nutricare/api/timbangan.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/models/Timbangan.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/theme.dart';

class UpdatePenimbanganPage extends StatefulWidget {
  final String id;
  const UpdatePenimbanganPage({super.key, required this.id});

  @override
  State<UpdatePenimbanganPage> createState() => _UpdatePenimbanganPageState();
}

class _UpdatePenimbanganPageState extends State<UpdatePenimbanganPage> {
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaBalitaController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  BalitaController _balitaController = BalitaController();
  TimbanganController _timbanganController = TimbanganController();
  TextEditingController _bbController = TextEditingController();
  TextEditingController _tbController = TextEditingController();
  TextEditingController _idBalitaController = TextEditingController();
  TextEditingController _idDataController = TextEditingController();
  UserController _activeController = UserController();
  final UserController _userController = UserController();
  late User _activeUser = User(id: 0, fullname: "", role: "", image: "");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _tanggalController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }

    
  }




  @override
  void initState() {
    super.initState();
    _userController.fetchUser().then((value) => {
      if (value != null) {
        setState(() {
          _activeUser = User(id: value['id'], fullname: value['fullname'], role: value['role'], image: value['image'],nama_dusun: value['nama_dusun'],);
        })
      }
    });
    _timbanganController.fetchTimbanganId(widget.id).then((value) => {
      print(value),
      if(value != null) {
          setState(() {
            _idDataController.text = value['id'].toString();
            _namaBalitaController.text = value['balita']['nama'];
            _idBalitaController.text = value['balita']['id'].toString();
            // Membersihkan tanggal dari karakter non-digit
            String cleanedDate = value['tanggal_timbangan'].replaceAll(RegExp(r'[^0-9]'), '');
            selectedDate = DateTime.parse(cleanedDate);
            // Mengatur tanggal pada _tanggalController menggunakan DateTime
            _tanggalController.text = DateFormat('yyyy-MM-dd').format(
              DateTime.parse(cleanedDate),
            );
            _bbController.text = value['berat_badan'].toString();
            _tbController.text = value['tinggi_badan'].toString();
          })
      }
    });
  }

  String selectedValue = '';


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
        title: Text('Update Data\nPenimbangan', style: inclusiveSans.copyWith(fontSize: 18.5, color: Colors.white), textAlign: TextAlign.center,),
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
                  height: 390,
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
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            style: poppins,
                            controller: _idDataController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Masukkan ID KK',
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
                        ),
                        Text("Pilih Balita", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: TextFormField(
                              style: inclusiveSans,
                              controller: _namaBalitaController,
                              keyboardType: TextInputType.name,
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: 'Silahkan pilih nama balita',
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
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(biruungu),
                                  padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan nilai yang diinginkan
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _displayBottomSheet(context);
                                },
                                child: Text("Pilih", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.white),)
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Tanggal Penimbangan", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans.copyWith(fontSize: 15, color: Colors.grey),
                        readOnly: true,
                        onTap: () async{
                          await _selectDate(context);
                        },
                        controller: TextEditingController(
                          text: selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : 'Pilih tanggal lahir Balita',
                        ),
                        decoration: InputDecoration(
                            hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 15),
                            focusColor: Colors.black,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                            filled: true,
                            suffixIcon: Icon(Icons.calendar_month_rounded,color: biruungu,),
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
                        Text("Berat Badan", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: poppins,
                        controller: _bbController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Masukkan berat badan balita',
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
                        Text("Tinggi/Panjang Badan", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: poppins,
                        controller: _tbController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Masukkan tinggi/panjang badan balita',
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
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            style: poppins,
                            controller: _idBalitaController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Masukkan ID KK',
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
                  onPressed: () async{
                    final id = _idDataController.text;
                    final id_balita = _idBalitaController.text;
                    final tanggal_timbangan = _tanggalController.text;
                    final berat_badan = _bbController.text;
                    final tinggi_badan = _tbController.text;
                    final String nama_posko = _activeUser.nama_dusun.toString();

                    final data = {
                      "id" : id,
                      "id_balita" :id_balita,
                      "tanggal_timbangan" : tanggal_timbangan,
                      "berat_badan" : berat_badan,
                      "tinggi_badan" : tinggi_badan,
                      "nama_posko" : nama_posko,
                    };

                  
                    
                    await _timbanganController.updateTimbangan(id,id_balita, tanggal_timbangan, berat_badan, tinggi_badan,nama_posko).then((value) => {
                      if(value != null) {
                        if(value['success'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data berhasil diupdate'),
                              duration: Duration(seconds: 2), // Durasi notifikasi
                            ),
                          ),
                          Navigator.pop(context)
                      }
                      }
                    });

                  }, child: Text("UPDATE DATA", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.white),)),
              ),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future _displayBottomSheet(BuildContext context) async{
      await showModalBottomSheet(
        context: context, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
        ),
        builder: (context) => Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cari data orang tua",style: inclusiveSans.copyWith(fontSize: 20,color: biruungu,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                       Flexible(
                            flex: 4,
                            child: TextFormField(
                            style: inclusiveSans,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Silahkan pilih orang tua balita',
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
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(biruungu),
                                padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(vertical: 15)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan nilai yang diinginkan
                                  ),
                                ),
                              ),
                              onPressed: () {
                               
                              },
                              child: Text("Cari", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.white),)
                            ),
                          )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: _balitaController.fetchBalita(),
                      builder: (BuildContext context,snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }else if(snapshot.hasData) {
                          final balitas = snapshot.data;
                          return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: balitas.length,
                          itemBuilder: (BuildContext context,index) {
                            final balita = balitas[index];
                            print(balita);
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(maxWidth:260,),
                                        child: SingleChildScrollView(scrollDirection: Axis.horizontal ,child: Text("${index + 1}.  ${balita['nama']}", style: inclusiveSans.copyWith(fontSize: 14,color: Colors.grey[600],fontWeight: FontWeight.w600),textAlign: TextAlign.start,))),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(birulaut),
                                          padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(vertical: 8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan nilai yang diinginkan
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          String data = balita['nama'];
                                          setState(() {
                                            _namaBalitaController.text = data;
                                            _idBalitaController.text = balita['id'].toString();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Pilih", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.white),)
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey[400],
                                  )
                                ],
                              ),
                            );
                          }
                        );
                        }else {
                          return Center(child: Text("Belum ada data"),);
                        }
                      },
                    )
                  )
                ],
              )
            ),
          ),
        )
      );
     
  }
}