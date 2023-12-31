import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutricare/api/balita.dart';
import 'package:nutricare/api/ortu.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/models/OrangTua.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/theme.dart';

class AddBalitaPage extends StatefulWidget {
  const AddBalitaPage({super.key});

  @override
  State<AddBalitaPage> createState() => _AddBalitaPageState();
}

class _AddBalitaPageState extends State<AddBalitaPage> {
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nikBalitaController = TextEditingController();
  TextEditingController _namaBalitaController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _orangtuaController = TextEditingController();
  TextEditingController _umurController = TextEditingController();
  TextEditingController _idKKController = TextEditingController();
  TextEditingController _idOrtuController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  OrtuController _ortuController = OrtuController();
  BalitaController _balitaController = BalitaController();
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
  void calculateAge() {
    if (selectedDate != null) {
      DateTime today = DateTime.now();
      int diffMonths = (today.year - selectedDate!.year) * 12 + today.month - selectedDate!.month;
      _umurController.text = diffMonths.toString();
    }
  }

  String selectedValue = '';

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
        title: Text('Tambah Data\nBalita', style: inclusiveSans.copyWith(fontSize: 18.5, color: Colors.white), textAlign: TextAlign.center,),
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
                  height: 605,
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
                        Text("NIK Balita", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          style: poppins,
                          controller: _nikBalitaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Masukkan NIK balita',
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
                        Text("Nama Balita", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans,
                        controller: _namaBalitaController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'Masukkan nama balita',
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
                        Text("Tanggal Lahir", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans.copyWith(fontSize: 15, color: Colors.grey),
                        readOnly: true,
                        onTap: () async{
                          await _selectDate(context);
                          calculateAge();
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
                        Text("Umur", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                        style: inclusiveSans,
                        controller: _umurController,
                        keyboardType: TextInputType.number,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: 'Masukkan umur balita',
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
                        Text("Jenis Kelamin", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                child: RadioListTile(
                                  activeColor: biruungu,
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  dense: true,
                                  title: Text('Laki-Laki', style: inclusiveSans.copyWith(fontSize: 15),),
                                  value: 'Laki-Laki',
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 150,
                                child: RadioListTile(
                                  activeColor: biruungu,
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  dense: true,
                                  title: Text('Perempuan', style: inclusiveSans.copyWith(fontSize: 15),),
                                  value: 'Perempuan',
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Text("Id KK", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),)
                        ),
                        Visibility(
                          visible: false,
                          child: const SizedBox(
                            height: 8,
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            style: poppins,
                            controller: _idKKController,
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
                         Visibility(
                          visible: false,
                          child: Text("Alamat", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),)
                        ),
                        Visibility(
                          visible: false,
                          child: const SizedBox(
                            height: 8,
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            style: poppins,
                            controller: _alamatController,
                            keyboardType: TextInputType.text,
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
                        Visibility(
                          visible: false,
                          child: const SizedBox(
                            height: 15,
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Text("Id Ortu", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),)
                        ),
                        Visibility(
                          visible: false,
                          child: const SizedBox(
                            height: 8,
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            style: poppins,
                            controller: _idOrtuController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Masukkan ID Ortu',
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
                        Visibility(
                          visible: false,
                          child: const SizedBox(
                            height: 15,
                          ),
                        ),
                        Text("Pilih Orang Tua", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 4,
                                child: TextFormField(
                                style: inclusiveSans,
                                controller: _orangtuaController,
                                keyboardType: TextInputType.name,
                                enabled: false,
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
                                    _displayBottomSheet(context);
                                  },
                                  child: Text("Pilih", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.white),)
                                ),
                              )
                            ],
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
                    final nik_balita = _nikBalitaController.text;
                    final nama = _namaBalitaController.text;
                    final tanggal_lahir = _tanggalController.text;
                    final umur = _umurController.text;
                    final nama_dusun = _alamatController.text;
                    final idKK = _idKKController.text;
                    final idOrtu = _idOrtuController.text;
                    final jenis_kelamin = selectedValue;
                    final String nama_posko = _activeUser.nama_dusun.toString();

                    final data = {
                      "nik_balita" : nik_balita,
                      "nama" : nama,
                      "tanggal_lahir" : tanggal_lahir,
                      "umur" : umur,
                      "nama_dusun" : nama_dusun,
                      "idKK" : idKK,
                      "idOrtu" : idOrtu,
                      "jenis_kelamin" : jenis_kelamin,
                    };
                    
                    await _balitaController.addBalita(nik_balita, nama, tanggal_lahir, umur, jenis_kelamin, nama_dusun, idKK, idOrtu, nama_posko).then((value) => {
                      if(value['success'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data berhasil ditambah'),
                              duration: Duration(seconds: 2), // Durasi notifikasi
                            ),
                          ),
                          Navigator.pop(context)
                      }
                    });
                    
                  }, child: Text("TAMBAH DATA", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.white),)),
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
                      future: _ortuController.fetchOrtu(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData){
                          final orangtuas = snapshot.data;
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: orangtuas.length,
                            itemBuilder: (BuildContext context,index) {
                              final orangtua = orangtuas[index];

                              final idOrtu = orangtua['id'];
                              final namaBapak = orangtua['nama_bapak'];
                              final namaIbu = orangtua['nama_ibu'];
                              final idKK = orangtua['id_kk'];
                              final alamat = orangtua['alamat'];
                            
                              
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(maxWidth:260,),
                                          child: SingleChildScrollView(scrollDirection: Axis.horizontal ,child: Text("${index + 1}.  $namaBapak - $namaIbu", style: inclusiveSans.copyWith(fontSize: 14,color: Colors.grey[600],fontWeight: FontWeight.w600),textAlign: TextAlign.start,))),
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
                                            setState(() {
                                              _orangtuaController.text = "$namaBapak - $namaIbu";
                                              _idOrtuController.text = "$idOrtu";
                                              _idKKController.text = "$idKK";
                                              _alamatController.text = "$alamat";
                                            });
                                            print(_alamatController.text);
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
                        } else {
                          return Center(
                            child: Text("Tidak ada data"),
                          );
                        }
                      }
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
//  final orangtuas = snapshot.data;

// for(var i = 1; i < orangtuas=13; i++) {
//   print("saya adalah data ke ${orangtuas[i+ 1]}")
// }

// // output
// saya  adalah data ke 2
// saya  adalah data ke 2
// saya  adalah data ke 3
// saya  adalah data ke 4
// saya  adalah data ke 12
